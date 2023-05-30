import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/blocs/update_collect_bloc.dart';
import 'package:crazyenglish/blocs/update_collect_event.dart';
import 'package:crazyenglish/entity/start_exam.dart';
import 'package:crazyenglish/pages/homework/preview_exam_paper/preview_exam_paper_view.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/pages/practise/question_result/complete_filling_question_result.dart';
import 'package:crazyenglish/pages/practise/question_result/completion_filling_question_result.dart';
import 'package:crazyenglish/pages/practise/question_result/translate_question_result.dart';
import 'package:crazyenglish/pages/practise/question_result/writing_question_result.dart';
import 'package:crazyenglish/pages/reviews/collect/collect_practic/collect_practic_logic.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../entity/week_detail_response.dart' as detail;

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/week_detail_response.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import '../answering/answering_logic.dart';
import '../question/choice_question/choice_question_view.dart';
import '../question_result/base_question_result.dart';
import '../question_result/listen_question_result.dart';
import '../question_result/question_reading_question_result.dart';
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

  String operationId = "";
  String operationStudentId = "";
  bool hasResultIndicator = true;
  ResultPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      examResult = Get.arguments[AnsweringPage.examResult];
      testDetailResponse = Get.arguments[AnsweringPage.examDetailKey];
      uuid = Get.arguments[AnsweringPage.catlogIdKey];
      parentIndex = Get.arguments[AnsweringPage.parentIndexKey];
      childIndex = Get.arguments[AnsweringPage.childIndexKey];
      lastFinishResult = Get.arguments[AnsweringPage.LastFinishResult];
      hasResultIndicator = Get.arguments[AnsweringPage.hasResultIndicator]??true;
      resultType = Get.arguments[AnsweringPage.result_type]?? AnsweringPage.result_normal_type;

      operationId = Get.arguments[PreviewExamPaperPage.PaperId]?? "";
      operationStudentId = Get.arguments[PreviewExamPaperPage.StudentOperationId]?? "";
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
  // final PageController pageController = PageController(keepPage: true);

  TabController? _tabController;

  List<BaseQuestionResult> pages = <BaseQuestionResult>[];

  // TODO 会替换成小题 选择题 或者 填空的数量
  List<SubtopicVoList> tabs = [];
  detail.SubjectVoList? currentSubjectVoList;
  ExerciseVos? currentExerciseVos;
  // subtopicId SubtopicAnswerVo
  Map<String,ExerciseLists> subtopicAnswerVoMap = {};
  bool hasTab = true;
  bool hasPageView = false;
  List<Widget> childQuestionList = [];
  Widget? childQustionPageView;
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
      _tabController = TabController(vsync: this, length: questionNum,initialIndex: widget.childIndex<questionNum? widget.childIndex:0);
    }
    logicCollect.addListenerId(GetBuilderIds.toCollectDate, () {
      if(mounted){
        BlocProvider.of<UpdateCollectBloc>(context)
            .add(SendCollectChangeEvent());
      }
    });
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
              buildTransparentAppBar("${currentSubjectVoList!.catalogueName}"),
              Expanded(child: CustomScrollView(
                slivers: [
                  SliverVisibility(
                      visible: widget.hasResultIndicator,
                      sliver: SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.w),
                        ))),
                  SliverVisibility(
                      visible: widget.hasResultIndicator,
                      sliver: SliverToBoxAdapter(
                    child: Util.buildTopIndicator(
                        currentExerciseVos!=null ? currentExerciseVos!.questionCount??0:0,
                        currentExerciseVos!=null ? currentExerciseVos!.correctCount??0:0,
                        currentExerciseVos!=null ? currentExerciseVos!.time??0:0,
                        DataGroup.questionType["${currentSubjectVoList!.classifyValue??"0"}"]??"未知",isWritinPage: currentSubjectVoList!.isSubjectivity??false),
                  )),
                  SliverToBoxAdapter(
                    child: Container(
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
                                          Text("答题卡",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: AppColors.c_FF1B1D2C),),
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
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: pages[0],
                  ),
                  SliverVisibility(
                    visible: hasPageView,
                    sliver: childQustionPageView??SliverToBoxAdapter(child: Container(),),
                  )
                ],)),
              buildSeparatorBuilder(1),
            ],
          ),
        ),
      ),);
  }

  Widget buildSeparatorBuilder(num question){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top:18.w,left: 18.w,right: 18.w,bottom: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
              visible: widget.resultType == AnsweringPage.result_normal_type,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: widget.resultType != AnsweringPage.result_homework_type,
                  child: InkWell(
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
              )),
              Visibility(
                  visible: widget.resultType == AnsweringPage.result_homework_correctioin_type,
                  child: InkWell(
                    onTap: (){
                      // Get.bottomSheet(bottomsheet);
                    },
                    child: Container(
                      width: 134.w,
                      height: 35.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xfff19e59),
                              Color(0xffec5f2a),
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(18.w)),
                      ),
                      child: Text("阅卷",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                    ),
                  )),
              InkWell(
                onTap: (){
                  // 开始作答逻辑 跳转到下一题
                  if(widget.testDetailResponse!.obj!.subjectVoList!.length > widget.parentIndex+1){
                    // TODO 不用请求了 直接下一题，除非是下一节
                    var nextHasResult = false;
                    detail.SubjectVoList? nextSubjectVoList = AnsweringPage.findJumpSubjectVoList(widget.testDetailResponse,widget.parentIndex+1);
                    if(nextSubjectVoList!=null){
                      if(widget.resultType == AnsweringPage.result_homework_type){
                        if(widget.examResult!=null){
                          ExerciseVos? exerciseVos = AnsweringPage.findExerciseResult(widget.examResult!,nextSubjectVoList!.id??0);
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
                        AnsweringPage.examResult: widget.examResult,
                        AnsweringPage.LastFinishResult: widget.lastFinishResult,
                        AnsweringPage.result_type:widget.resultType,
                        PreviewExamPaperPage.PaperId: widget.operationId,
                        PreviewExamPaperPage.StudentOperationId: widget.operationStudentId,
                      });
                    } else {
                      if(widget.resultType == AnsweringPage.result_homework_type){
                        logicDetail.addJumpToStartHomeworkListen();
                        logicDetail.getDetailAndStartHomework("${currentSubjectVoList!.journalCatalogueId}",
                            "${widget.operationStudentId}","${widget.operationId}",enterResult: false,isOffCurrentPage:true,jumpParentIndex: widget.parentIndex+1,jumpChildIndex: 0);
                        showLoading("");
                      }else{
                        // 跳作答页
                        logicDetail.addJumpToStartExamListen();
                        logicDetail.getDetailAndStartExam("${currentSubjectVoList!.journalCatalogueId}",enterResult:false,isOffCurrentPage:true,jumpParentIndex: widget.parentIndex+1,jumpChildIndex: 0);
                      }

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
                  child: Text("下一题",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
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
      // pageController.jumpToPage(value);
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
    int state = AnswerType.no_answer;
    num subjectId = currentSubjectVoList!.id??0;
    num subtopicId = e.id??0;
    if(subtopicAnswerVoMap.containsKey("$subjectId:$subtopicId")){
      if((subtopicAnswerVoMap["$subjectId:$subtopicId"]!.answer??"").isEmpty){
        state = AnswerType.no_answer;
      }else{
        if(subtopicAnswerVoMap["$subjectId:$subtopicId"]!.isRight??false){
          state =AnswerType.right;
        }else{
          state =AnswerType.wrong;
        }
      }
    }else{
      state = AnswerType.no_answer;
    }
    BoxDecoration decoration;
    Color textColor = Colors.white;
    if(state == AnswerType.no_answer){ // 未作答
      decoration = BoxDecoration(
        color: AppColors.c_FFF5F7FA,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
        border: Border.all(color: AppColors.c_FFD6D9DB,width: 1.w)
      );
      textColor = AppColors.c_FFD6D9DB;
    }else if(state == AnswerType.right){ // 正确
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

  List<BaseQuestionResult> buildQuestionResultList(
      detail.WeekDetailResponse weekTestDetailResponse) {
    List<BaseQuestionResult> questionList = [];
    if (weekTestDetailResponse.obj != null) {
      int length = weekTestDetailResponse.obj!.subjectVoList!.length;

      if(widget.parentIndex < length){
        currentSubjectVoList = weekTestDetailResponse.obj!.subjectVoList![widget.parentIndex];
        if(currentSubjectVoList!.questionTypeStr == QuestionType.select_words_filling){
          // 选词填空
          questionList.add(SelectWordsFillingQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
        }else if (currentSubjectVoList!.questionTypeStr == QuestionType.select_filling){
          // 选择填空
          questionList.add(SelectFillingQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.completion_filling
            || currentSubjectVoList!.questionTypeStr == QuestionType.translate_filling
            || currentSubjectVoList!.questionTypeStr == QuestionType.normal_gap
        ){
          // 补全填空 翻译填空 普通填空
          questionList.add(CompletionFillingQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.writing_question){
          // 写作题
          questionList.add(WritingQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
          hasTab = false;
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.normal_reading){
          // 常规阅读题 完型填空
          questionList.add(ReadQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
          childQustionPageView = getChildQuestionDetail(currentSubjectVoList!);
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.complete_filling){
          // 常规阅读题 完型填空
          questionList.add(CompleteFillingQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
          childQustionPageView = getChildQuestionDetail(currentSubjectVoList!);
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.question_reading){
          // 简答阅读题
          questionList.add(QuestionReadingQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
          hasTab = false;
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.translate_question){
          questionList.add(TranslateQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
        } else {
          switch (currentSubjectVoList!.classifyValue) {
            case QuestionTypeClassify.listening: // 听力题
              questionList.add(ListenQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
              childQustionPageView = getChildQuestionDetail(currentSubjectVoList!);
              break;
            case QuestionTypeClassify.reading: // 阅读题
              questionList.add(ReadQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
              childQustionPageView = getChildQuestionDetail(currentSubjectVoList!);
              break;
            case QuestionTypeClassify.writing:
              questionList.add(WritingQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
              if(currentSubjectVoList!.questionTypeStr == QuestionType.writing_question){
                hasTab = false;
              }
              break;
            default:
              questionList.add(OthersQuestionResult(subtopicAnswerVoMap,widget.childIndex,data: currentSubjectVoList!));
              childQustionPageView = getChildQuestionDetail(currentSubjectVoList!);
              print("题型分类："
                  "${QuestionTypeClassify.getName(currentSubjectVoList!.classifyValue!.toInt())}\n"
                  "题型：${currentSubjectVoList!.questionTypeName}"
                  "\n不支持解析");
          }
        }

      }
    }
    return questionList;
  }

  // 本来放在base_question_result中，无奈 要包裹SliverFillViewport 所以提到这一层
  Widget getChildQuestionDetail(SubjectVoList element){
    childQuestionList.clear();

    // 判断是否父子题
    // 普通阅读 常规阅读题 是父子题
    int questionNum = element.subtopicVoList!.length;
    if(questionNum>0){
      for(int i = 0 ;i< questionNum;i++){
        SubtopicVoList question = element.subtopicVoList![i];

        List<Widget> itemList = [];
        itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

        if(element.questionTypeStr == QuestionType.single_choice
            || element.questionTypeStr == QuestionType.complete_filling
            || element.questionTypeStr == QuestionType.multi_choice
            || element.questionTypeStr == QuestionType.judge_choice
            || element.questionTypeStr == QuestionType.normal_reading){
          // 选择题
          itemList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<Collect_practicLogic>(
                id: "${GetBuilderIds.collectState}:${element.id}:${question.id}",
                builder: (_){
                  return buildQuestionType("选择题",_.state.collectMap["${element.id}:${question.id}"]??false, element.id,subtopicId: question.id??-1);
                },
              ),
              Visibility(
                  visible: element.questionTypeStr == QuestionType.question_reading,
                  child: GetBuilder<Collect_practicLogic>(
                    id: "${GetBuilderIds.collectState}:${element.id}:${question.id}",
                    builder: (_){
                      return buildFavorAndFeedback(_.state.collectMap["${element.id}:${question.id}"]??false, element.id,subtopicId: question.id??-1);
                    },
                  )
              )
            ],
          ));
          itemList.add(Padding(padding:EdgeInsets.only(top: 8.w)));
          itemList.add(Visibility(
            visible: question!.problem != null && question!.problem!.isNotEmpty,
            child: Text(
              "${question!.problem}",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          itemList.add(Visibility(
            visible: question!.img != null && question!.img!.isNotEmpty,
            child: ExtendedImage.network(
              question!.img ?? "",
              cacheRawData: true,
              width: double.infinity,
              fit: BoxFit.fitHeight,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
              enableLoadState: true,
              loadStateChanged: (state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.completed:
                    return ExtendedRawImage(
                      image: state.extendedImageInfo?.image,
                      fit: BoxFit.cover,
                    );
                  default:
                    return Image.asset(
                      R.imagesCommenNoDate,
                      fit: BoxFit.fitHeight,
                    );
                }
              },
            ),));
          bool? isCorrect;
          num subjectId = element.id??0;
          num subtopicId = question.id??0;
          String defaultChooseAnswers = "";
          if(subtopicAnswerVoMap!.containsKey("$subjectId:$subtopicId")){
            String userAnswer = subtopicAnswerVoMap!["$subjectId:$subtopicId"]!.answer??"";
            int length =  question!.optionsList!=null ? question!.optionsList!.length:0;
            isCorrect = subtopicAnswerVoMap!["$subjectId:$subtopicId"]!.isRight;
            for(int  i = 0;i <length ;i++){
              if(userAnswer.contains("${question.optionsList![i].sequence}")){
                defaultChooseAnswers = "$defaultChooseAnswers+${question.optionsList![i].sequence}";
              }
            }
          }
          if(element.questionTypeStr == QuestionType.judge_choice){
            itemList.add(ChoiceQuestionPage(i,question,false,true,defaultChooseIndex: defaultChooseAnswers,isCorrect:isCorrect,isJudge: true,));
          }else{
            // TODO 判断是否是图片选择题的逻辑需要修改
            if((question.optionsList![0].content??"").isNotEmpty){
              itemList.add(ChoiceQuestionPage(i,question,false,true,defaultChooseIndex: defaultChooseAnswers,isCorrect:isCorrect));
            }else{
              itemList.add(ChoiceQuestionPage(i,question,false,true,defaultChooseIndex: defaultChooseAnswers,isImgChoice: true,));
            }
          }

        }else if(element.questionTypeStr == QuestionType.translate_question){

        }

        logicCollect.queryCollectState(element.id??0,subtopicId:question.id);

        childQuestionList.add(SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: itemList,
            ),
          ),
        ));
      }
    }

    // if(logic!=null){
    //   logic.initPageStr("1/${questionList.length}");
    // }
    // Util.toast("ddd${childQuestionList.length}");
    print("测试小题页面数量${childQuestionList.length}");
    hasPageView = true;
    return SliverFillViewport(
      delegate: SliverChildListDelegate(
        [Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: childQuestionList,
              ),
            )
          ],
        )]
      ),
    );
  }

  Widget buildFavorAndFeedback(bool isFavor,num? subjectId,{num subtopicId = -1}){
    print("更新");
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: (){
            logicCollect.toCollect(subjectId??0,subtopicId: subtopicId>0? subtopicId:-1);
          },
          child: Image.asset(isFavor? R.imagesExercisesNoteHearingCollected:R.imagesExercisesNoteHearing,width: 48.w,height: 17.w,),
        ),
        Padding(padding: EdgeInsets.only(left: 10.w)),
        InkWell(
          onTap: (){
            RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage,
                arguments: {'isFeedback': false});
          },
          child: Image.asset(R.imagesExerciseNoteFeedback,width: 48.w,height: 17.w),
        )
      ],
    );
  }

  Widget buildQuestionType(String name,bool isFavor,num? subjectId,{num subtopicId = -1}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 17.w,
          padding: EdgeInsets.only(left: 7.w,right: 7.w,bottom: 2.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
              border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
          ),
          child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 10.sp),),
        ),
        Padding(padding: EdgeInsets.only(left: 11.w)),
        InkWell(
          onTap: (){
            logicCollect.toCollect(subjectId??0,subtopicId: subtopicId>0? subtopicId:-1);
          },
          child: Image.asset(isFavor? R.imagesExercisesNoteHearingCollected:R.imagesExercisesNoteHearing,width: 48.w,height: 17.w,),
        ),
      ],
    );
  }




  @override
  void onDestroy() {
    Get.delete<AnsweringLogic>();
    Get.delete<WeekTestDetailLogic>();
    Get.delete<Collect_practicLogic>();
    if(_tabController!=null){
      _tabController!.dispose();
    }

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