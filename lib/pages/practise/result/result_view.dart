import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../entity/week_detail_response.dart' as detail;

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/week_detail_response.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import '../question_result/base_question_result.dart';
import '../question_result/listen_question_result.dart';
import '../question_result/read_question_result.dart';
import '../question_result/select_filling_question.dart';
import '../question_result/select_words_filling_question.dart';
import 'others_question_result.dart';
import 'result_logic.dart';

/// 核心逻辑：结果页
/// 参数：
/// answerMode: 作答模式： 作答模式（1）； 继续作答模式（2）； 错题本模式（3） 浏览模式（4）
/// brotherNode: 兄弟节点列表数据 默认空
/// nodeId: 目录Id
/// parentIndex: 跳转父题索引 默认0
/// childIndex: 子题索引 默认0
/// examDetail: 试题数据
/// examResult: 历史作答数据 默认空
class ResultPage extends BasePage{
  CommitAnswer? commitAnswer;
  detail.WeekDetailResponse? testDetailResponse;
  var uuid;
  int parentIndex = 0;
  int childIndex = 0;

  ResultPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      commitAnswer = Get.arguments[AnsweringPage.commitResponseAnswerKey];
      testDetailResponse = Get.arguments[AnsweringPage.examDetailKey];
      uuid = Get.arguments[AnsweringPage.catlogIdKey];
      parentIndex = Get.arguments[AnsweringPage.parentIndexKey];
      childIndex = Get.arguments[AnsweringPage.childIndexKey];
    }
  }

  // static const examDetailKey = "examDetail";
  // static const catlogIdKey = "catlogId";
  // static const parentIndexKey = "parentIndex";
  // static const childIndexKey = "childIndex";
  // static const commitResponseAnswerKey = "commitResponseAnswer";
  @override
  BasePageState<BasePage> getState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends BasePageState<ResultPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ResultLogic());
  final state = Get.find<ResultLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;


  late TabController _tabController;

  List<BaseQuestionResult> pages = <BaseQuestionResult>[];

  // TODO 会替换成小题 选择题 或者 填空的数量
  List<SubtopicVoList> tabs = [];

  // 下面两条数据 转换成list后 最后拼装到 commitAnswer中
  SubjectAnswerVo subjectAnswerVo = SubjectAnswerVo();
  // subtopicId SubtopicAnswerVo
  Map<String,SubtopicAnswerVo> subtopicAnswerVoMap = {};
  @override
  void onCreate() {
    if(widget.commitAnswer!=null){
      if(widget.commitAnswer!.subjectAnswerVo!=null
        && widget.commitAnswer!.subjectAnswerVo!.length>0){
        subjectAnswerVo = widget.commitAnswer!.subjectAnswerVo![0];
        if(subjectAnswerVo.subtopicAnswerVo!=null && subjectAnswerVo.subtopicAnswerVo!.length>0){
          subjectAnswerVo.subtopicAnswerVo!.forEach((element) {
            subtopicAnswerVoMap[
            (element.subtopicId??subjectAnswerVo.subtopicAnswerVo!.indexOf(element))
                .toString()] = element;
          });
        }
      }
    }
    // 计算小题数量 TODO 逻辑还需修改
    if(widget.testDetailResponse!.obj!.subjectVoList![widget.parentIndex].subtopicVoList!=null && widget.testDetailResponse!.obj!.subjectVoList![widget.parentIndex].subtopicVoList!.length>0) {
      int questionNum = widget.testDetailResponse!.obj!.subjectVoList![widget.parentIndex].subtopicVoList!.length;
      for(int i =0;i<questionNum;i++){
        tabs.add(widget.testDetailResponse!.obj!.subjectVoList![widget.parentIndex].subtopicVoList![i]);
      }
      _tabController = TabController(vsync: this, length: questionNum);
    }
  }

  @override
  Widget build(BuildContext context) {
    pages = buildQuestionResultList(widget.testDetailResponse!);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,//状态栏颜色
        statusBarIconBrightness: Brightness.light, //状态栏图标颜色
        statusBarBrightness: Brightness.dark,  //状态栏亮度
        systemStatusBarContrastEnforced: true, //系统状态栏对比度强制
        systemNavigationBarColor: Colors.white,  //导航栏颜色
        systemNavigationBarIconBrightness: Brightness.light,//导航栏图标颜色
        systemNavigationBarDividerColor: Colors.transparent,//系统导航栏分隔线颜色
        systemNavigationBarContrastEnforced: true,//系统导航栏对比度强制
      ),
      child: Scaffold(
        // extendBody: true,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.imagesReviewTopBg),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              buildTransparentAppBar("widget.commitResponse!.directory"),
              Expanded(child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [SliverToBoxAdapter(
                      child: Util.buildTopIndicator(),
                    )];
                  },
                  body: Container(
                    margin: EdgeInsets.only(top: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow:[
                        BoxShadow(
                          color: AppColors.c_26D0C5B4,		// 阴影的颜色
                          offset: Offset(0.w, 0.w),						// 阴影与容器的距离
                          blurRadius: 3.w,							// 高斯的标准偏差与盒子的形状卷积。
                          spreadRadius: 1.w,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 24.w)),
                        Container(
                          padding: EdgeInsets.only(left: 18.w,right: 18.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(R.imagesResultAnswerCardTips,width: 18.w,height: 18.w,),
                                  Padding(padding: EdgeInsets.only(left: 9.w)),
                                  Text("答题卡",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.c_FF1B1D2C),),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Util.buildAnswerState(1),
                                  Util.buildAnswerState(2),
                                  Util.buildAnswerState(3),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 24.w)),
                        _buildTabBar(),
                        Container(
                          height: 0.5.w,
                          width: double.infinity,
                          color: AppColors.c_FFD2D5DC,
                        ),
                        Expanded(child: pages[0],)
                      ],
                    ),
                  ))),

              buildSeparatorBuilder(1),
            ],
          ),
        ),
      ),);
  }

  Widget buildSeparatorBuilder(num question){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 18.w,right: 18.w,bottom: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  // 开始作答逻辑
                  // RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
                  //     arguments: {"detail": widget.testDetailResponse,
                  //       "uuid":"dd",
                  //       "parentIndex":widget.parentIndex,
                  //       "childIndex":0,
                  //     });
                  logicDetail.getDetailAndStartExam("0");
                  showLoading("");
                },
                child: Container(
                  width: 134.w,
                  height: 35.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff19e59),
                          Color(0xffec5f2a),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(18.w)),
                  ),
                  child: Text("重新练习",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                ),
              ),
              InkWell(
                onTap: (){
                  // 开始作答逻辑 跳转到下一题
                  if(widget.testDetailResponse!.obj!.subjectVoList!.length > widget.parentIndex+1){
                    // TODO 不用请求了 直接下一题，除非是下一节
                    logicDetail.getStartExam("0",);
                    var nextHasResult = false;
                    if(nextHasResult){  // 跳结果页
                      RouterUtil.offAndToNamed(AppRoutes.ResultPage,
                          arguments: {"detail": widget.testDetailResponse,
                            "uuid":"dd",
                            "parentIndex":widget.parentIndex+1,
                            "childIndex":0,
                          });
                    } else {
                      // 跳作答页
                      RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
                      arguments: {AnsweringPage.examDetailKey: widget.testDetailResponse,
                        AnsweringPage.catlogIdKey:"dd",
                        AnsweringPage.parentIndexKey:widget.parentIndex+1,
                        AnsweringPage.childIndexKey:0,
                      });
                    }
                  } else {
                    // 有下一节且有内容
                    var hasNext = true;
                    if (hasNext) {
                      logicDetail.getDetailAndStartExam("0",enterResult: true,isOffCurrentPage:true);
                    } else {
                      Util.toast("已经是最后一题");
                    }
                  }
                },
                child: Container(
                  width: 134.w,
                  height: 35.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff19e59),
                          Color(0xffec5f2a),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(18.w)),
                  ),
                  child: Text("下一章",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildTabBar() => tabs.length>0? TabBar(
    onTap: (value){
    },
    controller: _tabController,
    indicatorColor: AppColors.c_FF353E4D,
    isScrollable: true,
    labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
    indicatorWeight: 2.w,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    unselectedLabelStyle:
    TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
    labelColor: AppColors.TEXT_COLOR,
    tabs: tabs.map((e) => buildTab(e)).toList(),
  ):Container();

  Widget buildTab(SubtopicVoList e){
    int index = tabs.indexOf(e);
    int state = 1;
    if(subtopicAnswerVoMap.containsKey((e.id??1).toString())){
      if(subtopicAnswerVoMap[(e.id??1).toString()]!.isCorrect??false){
        state =2;
      }else{
        state =0;
      }
    }else{
      state = 1;
    }
    BoxDecoration decoration;
    Color textColor = Colors.white;
    if(state == 1){ // 未作答
      decoration = BoxDecoration(
        color: AppColors.c_FFF5F7FA,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
        border: Border.all(color: AppColors.c_FFD6D9DB,width: 1.w)
      );
      textColor = AppColors.c_FFD6D9DB;
    }else if(state == 2){ // 正确
      decoration = BoxDecoration(
        color: AppColors.c_FF62C5A2,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }else{//错误
      decoration = BoxDecoration(
        color: AppColors.c_FFEC6560,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }

    return Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 9.w),
      decoration: decoration,
      child: Text((index+1).toString(),style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: textColor),),
    );
  }

  Widget buildQuestionType(String name){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 17.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 7.w,right: 7.w,bottom: 2.w),
          margin: EdgeInsets.only(top:14.w,bottom: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
              border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
          ),
          child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 12.sp),),
        ),
        Padding(padding: EdgeInsets.only(left: 11.w)),
        Image.asset(R.imagesResultFavor,width: 48.w,height: 17.w,),
      ],
    );
  }

  List<BaseQuestionResult> buildQuestionResultList(
      detail.WeekDetailResponse weekTestDetailResponse) {
    List<BaseQuestionResult> questionList = [];
    if (weekTestDetailResponse.obj != null) {
      int length = weekTestDetailResponse.obj!.subjectVoList!.length;

      if(widget.parentIndex < length){
        detail.SubjectVoList element = weekTestDetailResponse.obj!.subjectVoList![widget.parentIndex];
        if(element.questionTypeStr == QuestionType.select_words_filling){
          questionList.add(SelectWordsFillingQuestionResult(data: element));
        }else if (element.questionTypeStr == QuestionType.select_filling){
          questionList.add(SelectFillingQuestionResult(data: element));
        }else if(element.questionTypeStr == QuestionType.complete_filling){
          questionList.add(ReadQuestionResult(data: element));
        }else{
          switch (element.classifyValue) {
            case QuestionTypeClassify.listening: // 听力题
              questionList.add(ListenQuestionResult(data: element));
              break;
            case QuestionTypeClassify.reading: // 阅读题
              questionList.add(ReadQuestionResult(data: element));
              break;
            default:
              questionList.add(OthersQuestionResult(data: element));
              Util.toast("题型分类${element.questionTypeName}还未解析");
          }
        }

      }
    }
    return questionList;
  }



  @override
  void onDestroy() {
    Get.delete<ResultLogic>();
    Get.delete<WeekTestDetailLogic>();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}