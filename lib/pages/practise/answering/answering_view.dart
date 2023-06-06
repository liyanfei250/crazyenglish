import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/base/widgetPage/dialog_manager.dart';
import 'package:crazyenglish/blocs/refresh_bloc_bloc.dart';
import 'package:crazyenglish/blocs/refresh_bloc_event.dart';
import 'package:crazyenglish/blocs/refresh_bloc_state.dart';
import 'package:crazyenglish/entity/commit_request.dart';
import 'package:crazyenglish/entity/start_exam.dart';
import 'package:crazyenglish/pages/homework/preview_exam_paper/preview_exam_paper_view.dart';
import 'package:crazyenglish/pages/practise/answering/select_gap_getxcontroller.dart';
import 'package:crazyenglish/pages/practise/question/choice_question/choice_question_view.dart';
import 'package:crazyenglish/pages/practise/question/question_factory.dart';
import 'package:crazyenglish/pages/practise/question_answering/complete_filling_question.dart';
import 'package:crazyenglish/pages/practise/question_answering/completion_filling_question.dart';
import 'package:crazyenglish/pages/practise/question_answering/others_question.dart';
import 'package:crazyenglish/pages/practise/question_answering/listen_question.dart';
import 'package:crazyenglish/pages/practise/question_answering/read_question.dart';
import 'package:crazyenglish/pages/practise/question_answering/select_filling_question.dart';
import 'package:crazyenglish/pages/practise/question_answering/writing_question.dart';
import 'package:crazyenglish/pages/practise/result/result_view.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../entity/week_detail_response.dart' as detail;
import '../../../entity/week_detail_response.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../utils/time_util.dart';
import '../question_answering/base_question.dart';
import '../question_answering/select_words_filling_question.dart';
import 'answering_logic.dart';
import 'page_getxcontroller.dart';

/// 核心逻辑：答题页
/// 参数：
/// answerMode: 作答模式：
///   作答模式（1）：没有上次作答记录 从第一道题开始 并计时
///   继续作答模式（2）：有上次作答记录 从第n道题开始 接着上次时间继续计时
///   错题本模式（3） ：直接跳到这道错题 ，一页题要反显其它答案 ；结果页不显示正确答案
///   浏览模式（4）
/// brotherNode: 兄弟节点列表数据 默认空
/// nodeId: 目录Id
/// parentIndex: 跳转父题索引 默认0
/// childIndex: 子题索引 默认0
/// examDetail: 试题数据
/// examResult: 历史作答数据 默认空
class AnsweringPage extends BasePage {
  detail.WeekDetailResponse? testDetailResponse;
  StartExam? lastFinishResult;
  var uuid;
  int parentIndex = 0;
  int childIndex = 0;
  int answerType = answer_normal_type;
  String operationId = "";
  String operationStudentId = "";
  String operationClassId = "";


  static const examDetailKey = "examDetail";
  static const catlogIdKey = "catlogId";
  static const parentIndexKey = "parentIndex";
  static const childIndexKey = "childIndex";
  static const LastFinishResult = "LastFinishResult";
  static const examResult = "examResult";
  static const hasResultIndicator = "hasResultIndicator";

  static const String result_type = "result_type";
  // 浏览模式
  static const int result_browse_type = 1;
  // 正常作答反显答案模式
  static const int result_normal_type = 2;
  // 做作业反显答案模式
  static const int result_homework_type = 3;
  // 教师批改模式
  static const int result_homework_correctioin_type = 4;

  // 也是上传参数值
  static const String answer_type = "answer_type";
  // 正常作答模式
  static const int answer_normal_type = 1;
  // 草稿模式 继续作答
  static const int answer_continue_type = 2;
  // 修正错题模式
  static const int answer_fix_type = 3;
  // 保存作业草稿
  static const int answer_homework_draft_type = 4;
  // 学生做作业模式
  static const int answer_homework_type = 5;
  // 试卷预览模式 无交互 无答案 不跳转结果页
  static const int answer_browse_type = 6;


  AnsweringPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      testDetailResponse = Get.arguments[examDetailKey];
      uuid = Get.arguments[catlogIdKey];
      parentIndex = Get.arguments[parentIndexKey];
      childIndex = Get.arguments[childIndexKey];
      lastFinishResult = Get.arguments[LastFinishResult];
      answerType = Get.arguments[answer_type]?? answer_normal_type;
      operationId = Get.arguments[PreviewExamPaperPage.PaperId]?? "";
      operationStudentId = Get.arguments[PreviewExamPaperPage.StudentOperationId]?? "";
      operationClassId = Get.arguments[PreviewExamPaperPage.OperationClassId]?? "";
    }
  }

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _AnsweringPageState();
  }


  static SubjectVoList? findJumpSubjectVoList(detail.WeekDetailResponse? testDetailResponse,int parentIndex){
    if (testDetailResponse!=null && testDetailResponse!.obj != null) {
      int length = testDetailResponse!.obj!.subjectVoList!.length;

      if(parentIndex < length){
        return testDetailResponse!.obj!.subjectVoList![parentIndex];
      }
    }
    return null;
  }

  static ExerciseVos? findExerciseResult(Exercise? examResult,num subjectId){
    ExerciseVos? exerciseVo;
    if(examResult!=null && examResult.exerciseVos!=null
        && examResult.exerciseVos!.length>0) {
      examResult.exerciseVos!.forEach((element) {
        if (element.subjectId == subjectId) {
          exerciseVo = element;
        }
      });
    }
    return exerciseVo;
  }


  static Map<String,ExerciseLists> makeExerciseResultToMap(ExerciseVos? exerciseVo){
    Map<String,ExerciseLists> subtopicAnswerVoMap = {};
    if (exerciseVo!=null && exerciseVo.exerciseLists != null &&
        exerciseVo.exerciseLists!.length > 0) {
      exerciseVo.exerciseLists!.forEach((element) {
        num subjectId = element.subjectId??0;
        num subtopicId = element.subtopicId??0;
        subtopicAnswerVoMap["${subjectId.toString()}:${subtopicId.toString()}"] = element;
      });
    }
    return subtopicAnswerVoMap;
  }



  static num findInitTime(Exercise? examResult,num subjectId){
    if(examResult!=null && examResult.exerciseVos!=null
        && examResult.exerciseVos!.length>0) {
      for(int i = 0;i< examResult.exerciseVos!.length;i++){
        ExerciseVos exerciseVo = examResult.exerciseVos![i];
        if (exerciseVo.subjectId == subjectId) {
          return exerciseVo.time??0;
        }
      }
    }
    return 0;
  }

}

class _AnsweringPageState extends BasePageState<AnsweringPage> {
  final logic = Get.put(AnsweringLogic());
  final pageLogicLazy = Get.lazyPut(()=>PageGetxController());
  final selectGapGetxController = Get.put(SelectGapGetxController());
  late PageGetxController pageLogic ;
  final state = Get
      .find<AnsweringLogic>()
      .state;
  bool isCountTime = true;
  Timer? _timer;
  var title = "".obs;

  List<BaseQuestion> pages = <BaseQuestion>[];

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  var _selectedIndex = 0.obs;

  detail.SubjectVoList? currentSubjectVoList;
  ExerciseVos? currentExerciseVos;
  // subjectId:subtopicId SubtopicAnswerVo
  Map<String,ExerciseLists> subtopicAnswerVoMap = {};
  bool hasBottomPageTab = true;
  bool isCommiting = false;
  bool hasPageView = false;
  List<Widget> childQuestionList = [];
  Widget? childQustionPageView;
  late PageController pageController;
  final Map<String,TextEditingController> gapEditController = {};
  @override
  void onCreate() {
    pageLogic = Get.find<PageGetxController>();
    if(widget.answerType != AnsweringPage.answer_fix_type
        && widget.answerType!= AnsweringPage.answer_browse_type){
      startTimer();
    }
    logic.updateOperationInfo(widget.operationId, widget.operationStudentId,widget.operationClassId);
    pageController = PageController(keepPage: true,initialPage: widget.childIndex);
    currentSubjectVoList = AnsweringPage.findJumpSubjectVoList(widget.testDetailResponse,widget.parentIndex);
    if(currentSubjectVoList!=null && widget.lastFinishResult!=null){
      if(widget.lastFinishResult!.obj!=null){
        currentExerciseVos = AnsweringPage.findExerciseResult(widget.lastFinishResult!.obj,currentSubjectVoList!.id??0);

        if((widget.answerType == AnsweringPage.answer_fix_type
            || widget.answerType == AnsweringPage.answer_continue_type
        || widget.answerType == AnsweringPage.answer_homework_draft_type)
        && currentExerciseVos!=null && currentExerciseVos!.exerciseLists!=null && currentExerciseVos!.exerciseLists!.isNotEmpty){

          if(currentSubjectVoList!.questionTypeStr == QuestionType.writing_question){
            // ExerciseVos
            if (currentExerciseVos!=null && currentExerciseVos!.exerciseLists != null &&
                currentExerciseVos!.exerciseLists!.length > 0) {
              SubjectAnswerVo subjectAnswerVo = SubjectAnswerVo(subjectId: currentSubjectVoList!.id,answer: currentExerciseVos!.exerciseLists![0].answer);
              logic.updateUserWritAnswer("${currentSubjectVoList!.id}", subjectAnswerVo);
            }

          }else{
            currentExerciseVos!.exerciseLists!.forEach((element) {
              num? subtopicId = element.subtopicId;

              String correctAnswer= "";
              int totalSubtopicLength = 0;
              if(currentSubjectVoList==null || currentSubjectVoList!.subtopicVoList == null){
                totalSubtopicLength = 0;
              } else {
                totalSubtopicLength = currentSubjectVoList!.subtopicVoList!.length;
              }
              for(int i = 0;i< totalSubtopicLength;i++){
                if(currentSubjectVoList!.subtopicVoList![i].id == subtopicId){
                  correctAnswer = currentSubjectVoList!.subtopicVoList![i].answer??"";
                }
              }
              SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(
                  subtopicId:element.subtopicId,
                  optionId:0,
                  userAnswer: element.answer,
                  answer: correctAnswer,
                  isCorrect: false);
              logic.updateUserAnswer("${subtopicId}", subtopicAnswerVo);
            });
          }

        }
        subtopicAnswerVoMap = AnsweringPage.makeExerciseResultToMap(currentExerciseVos);
        num time = AnsweringPage.findInitTime(widget.lastFinishResult!.obj,currentSubjectVoList!.id??0);
        if(widget.answerType == AnsweringPage.answer_normal_type ||
            widget.answerType == AnsweringPage.answer_homework_type ||
            widget.answerType == AnsweringPage.answer_fix_type
        ){
          time = 0;
        }
        if(time>0){
          logic.updateTime(countTime: time.toInt());
        }
      } else {
        print("无作答数据异常");
      }
    }else{
      print("作答数据异常，请联系开发人员");
    }

    logic.addListenerId(GetBuilderIds.uploadWrite,(){
      if(mounted){
        _uploadTestAnswer();
      }
    });

    logic.addListenerId(GetBuilderIds.examResult, () {
      // 刷新各个页面数据
      BlocProvider.of<RefreshBlocBloc>(context)
          .add(RefreshAnswerStateInfoEvent());
      if(widget.answerType == AnsweringPage.answer_fix_type){
        Get.back();
      } else {
        int resultType = AnsweringPage.result_normal_type;
        if(widget.answerType == AnsweringPage.answer_normal_type
            || widget.answerType == AnsweringPage.answer_continue_type ){
          resultType = AnsweringPage.result_normal_type;
        }else{
          resultType = AnsweringPage.result_homework_type;
        }
        RouterUtil.offAndToNamed(
            AppRoutes.ResultPage,
            isNeedCheckLogin:true,
            arguments: {
          AnsweringPage.examDetailKey: widget.testDetailResponse,
          AnsweringPage.catlogIdKey:widget.uuid,
          AnsweringPage.parentIndexKey:widget.parentIndex,
          AnsweringPage.childIndexKey:widget.childIndex,
          AnsweringPage.examResult: state.examResult.obj,
          AnsweringPage.LastFinishResult: widget.lastFinishResult,
          AnsweringPage.result_type:resultType,
          PreviewExamPaperPage.PaperId: widget.operationId,
          PreviewExamPaperPage.StudentOperationId: widget.operationStudentId,
          PreviewExamPaperPage.OperationClassId: widget.operationClassId,
        });
      }
    });

    if(widget.answerType== AnsweringPage.answer_homework_type ||
        widget.answerType== AnsweringPage.answer_homework_draft_type){
      logic.addListenerId(GetBuilderIds.answerHomework, () {
        if(widget.testDetailResponse!=null){
          if(widget.parentIndex+1 < widget.testDetailResponse!.obj!.subjectVoList!.length){
            RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
                isNeedCheckLogin:true,
                arguments: {AnsweringPage.examDetailKey: widget.testDetailResponse,
                  AnsweringPage.catlogIdKey:widget.uuid,
                  AnsweringPage.parentIndexKey:widget.parentIndex+1,
                  AnsweringPage.childIndexKey:widget.childIndex,
                  AnsweringPage.answer_type:AnsweringPage.answer_homework_type,
                  PreviewExamPaperPage.PaperId: widget.operationId,
                  PreviewExamPaperPage.StudentOperationId: widget.operationStudentId,
                  PreviewExamPaperPage.OperationClassId: widget.operationClassId,
                });
          }else{
            // TODO 刷新上级列表接口
            Get.back();
          }
        }else{
          // TODO 刷新上级列表接口
          Get.back();
        }
      });
    }

    logic.addListenerId(GetBuilderIds.answerPageNum, () {
      if(pageController.hasClients){
        pageController.jumpToPage(state.currentQuestionNum);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = buildQuestionList(widget.testDetailResponse!);

    return Scaffold(
      // resizeToAvoidBottomInset:false,
      appBar: AppBar(
        shadowColor: const Color(0x1F000000),
        title: Text(
          widget.testDetailResponse!.obj!.name??"未获取到标题",
          style: TextStyle(
              color: AppColors.c_FF32374E,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        leading: Util.buildBackWidget(context),
        actions: [
          Visibility(
              visible: isCountTime,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    R.imagesPractiseCountTimeIcon,
                    width: 18.w,
                    height: 18.w,
                  ),
                  Padding(padding: EdgeInsets.only(left: 6.w)),
                  Visibility(
                      visible: widget.answerType != AnsweringPage.answer_fix_type,
                      child: GetBuilder<AnsweringLogic>(
                        id: GetBuilderIds.answerPeriodTime,
                        builder: (_){
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                TimeUtil.getPractiseTime(_.state.countTime),
                                style: TextStyle(
                                    fontSize: 14.w, color: AppColors.c_FF353E4D),
                              ),
                              Padding(padding: EdgeInsets.only(left: 17.w))
                            ],
                          );
                        }),
                      ),
                ],
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: pages[0],
              ),
              SliverVisibility(
                visible: hasPageView,
                sliver: childQustionPageView??SliverToBoxAdapter(child: Container(),),
              )
            ],
          )),
          Visibility(
              visible: hasBottomPageTab,
              child: SafeArea(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(height: 0.2.w,color: AppColors.c_FFD2D5DC,),
                      Container(
                        margin:
                        EdgeInsets.only(left: 46.w, right: 46.w, top: 14.w, bottom: 27.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                pageLogic.prePage();
                              },
                              child: GetBuilder<AnsweringLogic>(
                                  id: GetBuilderIds.answerPageNum,
                                  builder: (logic) {
                                    return Container(
                                      width: 70.w,
                                      height: 30.w,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            logic.state.currentQuestionNum>0
                                                ? R.imagesPractisePreQuestionEnable
                                                : R.imagesPractisePreQuestionUnable,
                                            width: 18.w,
                                            height: 18.w,
                                          ),
                                          Text("上一题",style: TextStyle(fontSize: 14.sp,
                                              color: logic.state.currentQuestionNum>0? AppColors.c_FF353E4D:AppColors.c_80353E4D),),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            GetBuilder<AnsweringLogic>(
                                id: GetBuilderIds.answerPageNum,
                                builder: (logic) {
                                  print("====pageJumg===${logic.state.currentQuestionNum+1}/${logic.state.totalQuestionNum}");
                                  return Text(
                                    "${logic.state.currentQuestionNum+1}/${logic.state.totalQuestionNum}",
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.c_FF353E4D),
                                  );
                                }),
                            InkWell(
                              onTap: (){
                                if(state.currentQuestionNum+1 >= state.totalQuestionNum){
                                  if(widget.answerType == AnsweringPage.answer_browse_type){
                                    if(AnsweringPage.findJumpSubjectVoList(widget.testDetailResponse,widget.parentIndex+1)!=null){
                                      RouterUtil.toNamed(AppRoutes.AnsweringPage,
                                          isNeedCheckLogin:true,
                                          arguments: {AnsweringPage.examDetailKey: widget.testDetailResponse,
                                            AnsweringPage.catlogIdKey:widget.uuid,
                                            AnsweringPage.parentIndexKey:widget.parentIndex+1,
                                            AnsweringPage.childIndexKey:0,
                                            AnsweringPage.LastFinishResult:widget.lastFinishResult,
                                            AnsweringPage.answer_type:AnsweringPage.answer_browse_type,
                                          });
                                    }else{
                                      Get.back();
                                    }

                                  }else{
                                    _uploadTestAnswer();
                                  }
                                }else{
                                  pageLogic.nextPage();
                                }
                              },
                              child: GetBuilder<AnsweringLogic>(
                                  id: GetBuilderIds.answerPageNum,
                                  builder: (logic) {
                                    return Container(
                                      width: 70.w,
                                      height: 30.w,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text((widget.answerType==AnsweringPage.answer_browse_type
                                              || logic.state.currentQuestionNum+1 < logic.state.totalQuestionNum)? "下一题":"提交",style: TextStyle(fontSize: 14.sp,
                                              color: (logic.state.currentQuestionNum+1 < logic.state.totalQuestionNum
                                                  || (logic.state.currentQuestionNum+1 >= logic.state.totalQuestionNum && widget.answerType != AnsweringPage.answer_browse_type ))? AppColors.c_FF353E4D:AppColors.c_80353E4D),),
                                          (widget.answerType==AnsweringPage.answer_browse_type || logic.state.currentQuestionNum+1 < logic.state.totalQuestionNum) ?
                                          Image.asset(
                                            logic.state.currentQuestionNum+1 < logic.state.totalQuestionNum
                                                ? R.imagesPractiseNextQuestionEnable
                                                : R.imagesPractiseNextQuestionUnable,
                                            width: 18.w,
                                            height: 18.w,
                                          ):Container(width: 18.w,
                                              height: 18.w)
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ))
        ],
      ),
    );
  }

  void _uploadTestAnswer(){

    Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.all(0.0.w),
      contentPadding: EdgeInsets.all(0.0.w),
      confirm: InkWell(
        onTap: (){
          if(currentSubjectVoList!=null){
            isCommiting = true;
            // 草稿模式提交的时候要转变
            if(widget.answerType == AnsweringPage.answer_homework_draft_type){
              logic.uploadWeekTest(exerciseVos:currentExerciseVos,currentSubjectVoList!,AnsweringPage.answer_homework_type);
            }else if(widget.answerType == AnsweringPage.answer_continue_type){
              logic.uploadWeekTest(exerciseVos:currentExerciseVos,currentSubjectVoList!,AnsweringPage.answer_normal_type);
            }else  if(widget.answerType == AnsweringPage.answer_fix_type){
              logic.uploadWeekTest(currentSubjectVoList!,widget.answerType);
            }else{
              logic.uploadWeekTest(currentSubjectVoList!,widget.answerType);
            }
          }else{
            Util.toast("未获取到试题信息");
          }

          Get.back();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.w,horizontal: 23.w),
          margin: EdgeInsets.only(left:10.w,bottom: 18.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xfff19e59),
                  Color(0xffec5f2a),
                ]),
            borderRadius: BorderRadius.all(Radius.circular(16.5.w)),
            boxShadow:[
              BoxShadow(
                color: const Color(0xffee754f).withOpacity(0.25),		// 阴影的颜色
                offset: Offset(0.w, 4.w),						// 阴影与容器的距离
                blurRadius: 8.w,							// 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 0.w,
              ),
            ],
          ),
          child: Text("确定",style: TextStyle(color:Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w500),),
        ),
      ),
      cancel: InkWell(
        onTap: (){
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3.w,horizontal: 23.w),
          margin: EdgeInsets.only(right:10.w,bottom: 18.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.w, color: AppColors.c_FFD2D5DC),
            borderRadius: BorderRadius.all(Radius.circular(16.5.w)),
          ),
          child: Text("取消",style: TextStyle(color:AppColors.c_FF353E4D,fontSize: 16.sp,fontWeight: FontWeight.w500),),
        ),
      ),
      content: Container(
        margin: EdgeInsets.only(bottom: 10.w),
        child: Text(
          widget.answerType == AnsweringPage.answer_fix_type ?
          "是否确定提交已纠正错题？" : "是否确定提交？",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
      ),
    );
  }

  List<BaseQuestion> buildQuestionList(
      detail.WeekDetailResponse weekTestDetailResponse) {
    List<BaseQuestion> questionList = [];
    if (weekTestDetailResponse.obj != null) {
      int length = weekTestDetailResponse.obj!.subjectVoList!.length;

      if(widget.parentIndex < length){
        currentSubjectVoList = weekTestDetailResponse.obj!.subjectVoList![widget.parentIndex];
        if(currentSubjectVoList!.questionTypeStr == QuestionType.select_words_filling){
          questionList.add(SelectWordsFillingQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.completion_filling
            || currentSubjectVoList!.questionTypeStr == QuestionType.translate_filling
            || currentSubjectVoList!.questionTypeStr == QuestionType.normal_gap

        ){
          questionList.add(CompletionFillingQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
        }else if (currentSubjectVoList!.questionTypeStr == QuestionType.select_filling){
          questionList.add(SelectFillingQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.complete_filling){
          questionList.add(CompleteFillingQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
          childQustionPageView = getQuestionDetail(currentSubjectVoList!);
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.writing_question){
          hasBottomPageTab = false;
          questionList.add(WritingQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.normal_reading
        || currentSubjectVoList!.questionTypeStr == QuestionType.question_reading){
          questionList.add(ReadQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
          childQustionPageView = getQuestionDetail(currentSubjectVoList!);
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.translate_question){
          questionList.add(OthersQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
          childQustionPageView = getQuestionDetail(currentSubjectVoList!);
        }else{
          switch (currentSubjectVoList!.classifyValue) {
            case QuestionTypeClassify.listening: // 听力题
              questionList.add(ListenQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
              childQustionPageView = getQuestionDetail(currentSubjectVoList!);
              break;
            case QuestionTypeClassify.reading: // 阅读题
              questionList.add(ReadQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
              childQustionPageView = getQuestionDetail(currentSubjectVoList!);
              break;
            default:
              questionList.add(OthersQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
              childQustionPageView = getQuestionDetail(currentSubjectVoList!);
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

  TextEditingController makeEditController(String key){
    if(gapEditController[key] == null){
      TextEditingController controller = TextEditingController();
      gapEditController[key] = controller;
      return controller;
    }else{
      return gapEditController[key]!;
    }
  }

  Widget getQuestionDetail(SubjectVoList element){
    childQuestionList.clear();

    // 判断是否父子题
    // 普通阅读 常规阅读题 是父子题
    int questionNum = element.subtopicVoList!.length;
    if(questionNum>0){
      for(int i = 0 ;i< questionNum;i++){
        SubtopicVoList question = element.subtopicVoList![i];

        List<Widget> itemList = [];

        if(element.questionTypeStr == QuestionType.single_choice
            || element.questionTypeStr == QuestionType.complete_filling
            || element.questionTypeStr == QuestionType.normal_reading
            || element.questionTypeStr == QuestionType.multi_choice
            || element.questionTypeStr == QuestionType.judge_choice){
          // 选择题
          itemList.add(buildQuestionType("选择题"));
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
          bool isClickEnable = true;
          String defaultChooseAnswers = "";
          // 找到上次作答记录 或者 错题本正确题目答案
          num subjectId = element.id??0;
          num subtopicId = question.id??0;
          if(subtopicAnswerVoMap!=null
              && subtopicAnswerVoMap.containsKey("$subjectId:$subtopicId")){
            ExerciseLists exerciseLists = subtopicAnswerVoMap["$subjectId:$subtopicId"]!;
            if(question.optionsList!=null &&
                exerciseLists.answer!=null &&
                exerciseLists.answer!.isNotEmpty){
              for(int i = 0; i< question.optionsList!.length;i++){
                if(exerciseLists.answer!.contains("${question.optionsList![i].sequence}")){
                  defaultChooseAnswers = "$defaultChooseAnswers+${question.optionsList![i].sequence}";
                }
              }
            }
          }
          if(widget.answerType == AnsweringPage.answer_fix_type){
            if(subtopicAnswerVoMap!=null
                && subtopicAnswerVoMap.containsKey("$subjectId:$subtopicId")){
              isClickEnable = false;
            }
          } else if(widget.answerType == AnsweringPage.answer_normal_type
            || widget.answerType == AnsweringPage.answer_homework_type){
            defaultChooseAnswers = "";
          }

          if(element.questionTypeStr == QuestionType.multi_choice){
            if((question.optionsList![0].content??"").isNotEmpty){
              itemList.add(ChoiceQuestionPage(i,question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:true));
            } else {
              itemList.add(ChoiceQuestionPage(i,question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:true,isImgChoice: true,));
            }
          }else if(element.questionTypeStr == QuestionType.judge_choice){
            itemList.add(ChoiceQuestionPage(i,question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isJudge:true));
          }else{
            // TODO 判断是否是图片选择题的逻辑需要修改
            if((question.optionsList![0].content??"").isNotEmpty){
              itemList.add(ChoiceQuestionPage(i,question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:false));
            } else {
              itemList.add(ChoiceQuestionPage(i,question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:false,isImgChoice: true));
            }
          }

        }else if(element.questionTypeStr == QuestionType.normal_gap) {
          itemList.add(buildQuestionType("填空题"));
          // itemList.add(buildReadQuestion(element.content ?? ""));
          itemList.add(QuestionFactory.buildNarmalGapQuestion(
              question, 0, makeEditController,answerType: widget.answerType));
        }else if(element.questionTypeStr == QuestionType.question_reading){
          itemList.add(buildQuestionType("填空"));
          itemList.add(Visibility(
            visible: question!.problem != null && question!.problem!.isNotEmpty,
            child: Text(
              question!.problem!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
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
          itemList.add(Padding(
            padding: EdgeInsets.only(top: 18.w),
          ));
          itemList.add(QuestionFactory.buildShortAnswerQuestion(element.id!.toInt(),question,1,subtopicAnswerVoMap,null,clearFocus,userAnswerCallback: userAnswerCallback,answerType: widget.answerType));
        } else if(element.questionTypeStr == QuestionType.translate_question){
          itemList.add(buildQuestionType("填空"));
          itemList.add(Text("英汉互译",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 18.sp)));
          itemList.add(Padding(padding: EdgeInsets.only(top: 30.w),));
          itemList.add(Row(
            children: [
              Text("原文",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp),),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Expanded(child: Container(
                height: 44.w,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7.w)),
                  border: Border.all(
                      width: 1.w,
                      color: AppColors.c_FFB4B9C6,
                      style: BorderStyle.solid
                  ),
                ),
                child: Text("${question.problem}",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp),),
              ))
            ],
          ));
          itemList.add(Padding(padding: EdgeInsets.only(top: 16.w),));
          itemList.add(Row(
            children: [
              Text("译文",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp)),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Expanded(child: QuestionFactory.buildShortAnswerQuestion(element.id!.toInt(),question,1,subtopicAnswerVoMap,null,clearFocus,userAnswerCallback: userAnswerCallback,answerType: widget.answerType))
            ],
          ));
        }
        // else if(element.questionTypeStr == QuestionType.correction_question){
        //   itemList.add(buildQuestionType("纠错题"));
        //   itemList.add(QuestionFactory.buildFixProblemQuestion(element,element!.content!));
        // }

        childQuestionList.add(SingleChildScrollView(
          child: Container(
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

    if(logic!=null){
      print("call updateCurrentPage getQuestionDetail");
      logic.updateCurrentPage(widget.childIndex,totalQuestion:childQuestionList.length,isInit: true);
    }

    hasPageView = true;
    return SliverFillViewport(
      delegate: SliverChildListDelegate(
          [Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: _neverScroll,
                  pageSnapping: false,
                  onPageChanged: (int value){
                    // if(logic!=null){
                    //   logic.updateCurrentPage(value,totalQuestion:questionList.length);
                    // }
                  },
                  children: childQuestionList,
                ),
              )
            ],
          )]
      ),
    );

  }

  void userAnswerCallback(SubtopicAnswerVo subtopicAnswerVo,{int indexPage=-1}){
    if(indexPage>-1 && selectGapGetxController!=null){
      selectGapGetxController.updateGapKeyContent("${indexPage+1}", subtopicAnswerVo.userAnswer??"");
    }
    logic.updateUserAnswer((subtopicAnswerVo.subtopicId??1).toString(), subtopicAnswerVo);
  }

  Widget buildQuestionType(String name){
    return Container(
      height: 17.w,
      margin: EdgeInsets.only(top:14.w,bottom: 10.w),
      padding: EdgeInsets.only(left:2.w,right:2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
          border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
      ),
      child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 10.sp),),
    );
  }

  void clearFocus(){
    closeKeyBoard();
  }

  startTimer() {
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      logic.updateTime();
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  void onDestroy() {
    cancelTimer();
    if(pageController.hasClients){
      pageController.dispose();
    }
    if(!isCommiting){
      if(widget.answerType == AnsweringPage.answer_normal_type
      || widget.answerType == AnsweringPage.answer_continue_type
      ){
        num? lastSubtopicId = 0;
        if(logic.state.currentQuestionNum>-1){
          if(currentSubjectVoList!.subtopicVoList!=null && currentSubjectVoList!.subtopicVoList!.length>logic.state.currentQuestionNum){
            lastSubtopicId = currentSubjectVoList!.subtopicVoList![logic.state.currentQuestionNum].id;
          }
        }
        logic.uploadWeekTest(exerciseVos:currentExerciseVos,currentSubjectVoList!,AnsweringPage.answer_continue_type,
            lastSubjectId: currentSubjectVoList!.id,
            lastSubtopicId: lastSubtopicId);
      }else if(widget.answerType == AnsweringPage.answer_homework_type
          || widget.answerType == AnsweringPage.answer_homework_draft_type){
        num? lastSubtopicId = 0;
        if(logic.state.currentQuestionNum>-1){
          if(currentSubjectVoList!.subtopicVoList!=null && currentSubjectVoList!.subtopicVoList!.length>logic.state.currentQuestionNum){
            lastSubtopicId = currentSubjectVoList!.subtopicVoList![logic.state.currentQuestionNum].id;
          }
        }
        logic.uploadWeekTest(exerciseVos:currentExerciseVos,currentSubjectVoList!,AnsweringPage.answer_homework_draft_type,
            lastSubjectId: currentSubjectVoList!.id,
            lastSubtopicId: lastSubtopicId);
      }
    }
    Get.delete<AnsweringLogic>();
    Get.delete<PageGetxController>();
    Get.delete<SelectGapGetxController>();
  }
}
