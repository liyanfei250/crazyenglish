import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/entity/start_exam.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/pages/practise/question_result/writing_question_result.dart';
import 'package:crazyenglish/pages/reviews/collect/collect_practic/collect_practic_logic.dart';
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
import '../answering/answering_logic.dart';
import '../question_result/base_question_result.dart';
import '../question_result/listen_question_result.dart';
import '../question_result/read_question_result.dart';
import '../question_result/select_filling_question_result.dart';
import '../question_result/select_words_filling_question.dart';
import '../question_result/others_question_result.dart';

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
  Exercise? examResult;
  StartExam? lastFinishResult;
  detail.WeekDetailResponse? testDetailResponse;
  var uuid;
  int parentIndex = 0;
  int childIndex = 0;
  int? resultType = AnsweringPage.result_normal_type;

  ResultPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      examResult = Get.arguments[AnsweringPage.examResult];
      testDetailResponse = Get.arguments[AnsweringPage.examDetailKey];
      uuid = Get.arguments[AnsweringPage.catlogIdKey];
      parentIndex = Get.arguments[AnsweringPage.parentIndexKey];
      childIndex = Get.arguments[AnsweringPage.childIndexKey];
      lastFinishResult = Get.arguments[AnsweringPage.LastFinishResult];
      resultType = Get.arguments[AnsweringPage.result_type]?? AnsweringPage.result_normal_type;
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
  final logic = Get.put(AnsweringLogic());
  final state = Get.find<AnsweringLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;
  final logicCollect = Get.put(Collect_practicLogic());


  late TabController _tabController;

  List<BaseQuestionResult> pages = <BaseQuestionResult>[];

  // TODO 会替换成小题 选择题 或者 填空的数量
  List<SubtopicVoList> tabs = [];
  detail.SubjectVoList? currentSubjectVoList;
  ExerciseVos? currentExerciseVos;
  // subtopicId SubtopicAnswerVo
  Map<String,ExerciseLists> subtopicAnswerVoMap = {};
  bool hasTab = true;
  @override
  void onCreate() {
    currentSubjectVoList = AnsweringPage.findJumpSubjectVoList(widget.testDetailResponse,widget.parentIndex);
    if(currentSubjectVoList!=null){
      if(widget.examResult!=null){
        currentExerciseVos = AnsweringPage.findExerciseResult(widget.examResult,currentSubjectVoList!.id??0);

        subtopicAnswerVoMap = AnsweringPage.makeExerciseResultToMap(currentExerciseVos);
      }else{
        // TODO 逻辑严谨否
        if(widget.lastFinishResult!=null){
          currentExerciseVos = AnsweringPage.findExerciseResult(widget.lastFinishResult!.obj,currentSubjectVoList!.id??0);

          subtopicAnswerVoMap = AnsweringPage.makeExerciseResultToMap(currentExerciseVos);
        }else{
          print("无作答数据及历史数据");
          Util.toast("无作答数据及历史数据");
        }
      }
    }else{
      Util.toast("作答数据异常，请联系开发人员");
      print("作答数据异常，请联系开发人员");
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
                      child: Util.buildTopIndicator(
                          currentExerciseVos!=null ? currentExerciseVos!.questionCount??0:0,
                          currentExerciseVos!=null ? currentExerciseVos!.correctCount??0:0,
                          currentExerciseVos!=null ? currentExerciseVos!.time??0:0,
                          currentSubjectVoList!.catalogueName??"",isWritinPage: currentSubjectVoList!.questionTypeStr == QuestionType.writing_question),
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
                      Visibility(
                      visible: hasTab,
                      child: Padding(padding: EdgeInsets.only(top: 24.w))),
                        Visibility(
                          visible: hasTab,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                            ],
                          ),
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
          Visibility(
              visible: widget.resultType == AnsweringPage.result_normal_type,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  logicDetail.addJumpToStartExamListen();
                  logicDetail.getDetailAndStartExam("${currentSubjectVoList!.journalCatalogueId}",enterResult:false,isOffCurrentPage:true,jumpParentIndex: widget.parentIndex,jumpChildIndex: 0);
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
                    var nextHasResult = false;
                    detail.SubjectVoList? nextSubjectVoList = AnsweringPage.findJumpSubjectVoList(widget.testDetailResponse,widget.parentIndex+1);
                    if(nextSubjectVoList!=null && widget.lastFinishResult!=null){
                      if(widget.lastFinishResult!=null && widget.lastFinishResult!.obj!=null){
                        ExerciseVos? exerciseVos = AnsweringPage.findExerciseResult(widget.lastFinishResult!.obj,nextSubjectVoList!.id??0);
                        Map<String,ExerciseLists> nextSubtopicAnswerVoMap = AnsweringPage.makeExerciseResultToMap(exerciseVos);
                        if(nextSubtopicAnswerVoMap.isEmpty){
                          nextHasResult = false;
                        }else{
                          nextHasResult = true;
                        }
                      }else{
                        nextHasResult = false;
                      }
                    }else{
                      nextHasResult = false;
                    }

                    if(nextHasResult){  // 跳结果页
                      RouterUtil.offAndToNamed(
                          AppRoutes.ResultPage,
                          isNeedCheckLogin:true,
                          arguments: {
                        AnsweringPage.examDetailKey: widget.testDetailResponse,
                        AnsweringPage.catlogIdKey:widget.uuid,
                        AnsweringPage.parentIndexKey:widget.parentIndex+1,
                        AnsweringPage.childIndexKey:widget.childIndex,
                        AnsweringPage.examResult: widget.lastFinishResult!.obj,
                        AnsweringPage.LastFinishResult: widget.lastFinishResult,
                      });
                    } else {
                      // 跳作答页
                      logicDetail.addJumpToStartExamListen();
                      logicDetail.getDetailAndStartExam("${currentSubjectVoList!.journalCatalogueId}",enterResult:false,isOffCurrentPage:true,jumpParentIndex: widget.parentIndex+1,jumpChildIndex: 0);
                    }
                  } else {
                    // TODO 有下一节且有内容 传参需要带上目录
                    Util.toast("已经是最后一题");
                    Get.back();
                    // var hasNext = true;
                    // if (hasNext) {
                    //   logicDetail.addJumpToStartExamListen();
                    //   logicDetail.getDetailAndStartExam("0",enterResult: true,isOffCurrentPage:true);
                    // } else {
                    //   Util.toast("已经是最后一题");
                    // }
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
          )),

        ],
      ),
    );
  }

  Widget _buildTabBar() => tabs.length>0? TabBar(
    onTap: (value){
      pages[0].jumpToQuestion(value);
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
    num subjectId = currentSubjectVoList!.id??0;
    num subtopicId = e.id??0;
    if(subtopicAnswerVoMap.containsKey("$subjectId:$subtopicId")){
      if((subtopicAnswerVoMap["$subjectId:$subtopicId"]!.answer??"").isEmpty){
        state = 1;
      }else{
        if(subtopicAnswerVoMap["$subjectId:$subtopicId"]!.isRight??false){
          state =2;
        }else{
          state =0;
        }
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
        currentSubjectVoList = weekTestDetailResponse.obj!.subjectVoList![widget.parentIndex];
        if(currentSubjectVoList!.questionTypeStr == QuestionType.select_words_filling){
          questionList.add(SelectWordsFillingQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
        }else if (currentSubjectVoList!.questionTypeStr == QuestionType.select_filling){
          questionList.add(SelectFillingQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.complete_filling){
          questionList.add(ReadQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.writing_question){
          questionList.add(WritingQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
          hasTab = false;
        }else{
          switch (currentSubjectVoList!.classifyValue) {
            case QuestionTypeClassify.listening: // 听力题
              questionList.add(ListenQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
              break;
            case QuestionTypeClassify.reading: // 阅读题
              questionList.add(ReadQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
              if(currentSubjectVoList!.questionTypeStr == QuestionType.question_reading){
                hasTab = false;
              }
              break;
            case QuestionTypeClassify.writing:
              questionList.add(WritingQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
              if(currentSubjectVoList!.questionTypeStr == QuestionType.writing_question){
                hasTab = false;
              }
              break;
            default:
              questionList.add(OthersQuestionResult(subtopicAnswerVoMap,data: currentSubjectVoList!));
              Util.toast("题型分类${currentSubjectVoList!.questionTypeName}还未解析");
          }
        }

      }
    }
    return questionList;
  }



  @override
  void onDestroy() {
    Get.delete<AnsweringLogic>();
    Get.delete<WeekTestDetailLogic>();
    Get.delete<Collect_practicLogic>();
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