import 'dart:async';

import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/commit_request.dart';
import 'package:crazyenglish/entity/start_exam.dart';
import 'package:crazyenglish/pages/practise/question/others_question.dart';
import 'package:crazyenglish/pages/practise/question/listen_question.dart';
import 'package:crazyenglish/pages/practise/question/read_question.dart';
import 'package:crazyenglish/pages/practise/question/select_filling_question.dart';
import 'package:crazyenglish/pages/practise/question/writing_question.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:flutter/material.dart';
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
import '../question/base_question.dart';
import '../question/select_words_filling_question.dart';
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

  static const examDetailKey = "examDetail";
  static const catlogIdKey = "catlogId";
  static const parentIndexKey = "parentIndex";
  static const childIndexKey = "childIndex";
  static const LastFinishResult = "LastFinishResult";
  static const examResult = "examResult";
  static const result_type = "result_type";
  static const result_browse_type = 1;
  static const result_normal_type = 2;
  static const answer_type = "answer_type";
  static const answer_normal_type = 1;
  static const answer_continue_type = 2;
  static const answer_fix_type = 3;


  AnsweringPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      testDetailResponse = Get.arguments[examDetailKey];
      uuid = Get.arguments[catlogIdKey];
      parentIndex = Get.arguments[parentIndexKey];
      childIndex = Get.arguments[childIndexKey];
      lastFinishResult = Get.arguments[LastFinishResult];
      answerType = Get.arguments[answer_type]?? answer_normal_type;
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
    Map<String,ExerciseLists> subtopicAnswerVoMap = {};
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
        subtopicAnswerVoMap[
        element.subjectId.toString()+(element.subtopicId ?? exerciseVo.exerciseLists!.indexOf(element))
            .toString()] = element;
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
  final pageLogic = Get.put(PageGetxController());
  final state = Get
      .find<AnsweringLogic>()
      .state;
  bool isCountTime = true;
  late Timer _timer;
  var title = "".obs;

  List<BaseQuestion> pages = <BaseQuestion>[];

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  var _selectedIndex = 0.obs;
  final PageController pageController = PageController(keepPage: true);

  detail.SubjectVoList? currentSubjectVoList;
  ExerciseVos? currentExerciseVos;
  // subtopicId SubtopicAnswerVo
  Map<String,ExerciseLists> subtopicAnswerVoMap = {};
  bool hasBottomPageTab = true;
  @override
  void onCreate() {
    if(widget.answerType != AnsweringPage.answer_fix_type){
      startTimer();
    }

    currentSubjectVoList = AnsweringPage.findJumpSubjectVoList(widget.testDetailResponse,widget.parentIndex);
    if(currentSubjectVoList!=null && widget.lastFinishResult!=null){
      if(widget.lastFinishResult!.obj!=null){
        currentExerciseVos = AnsweringPage.findExerciseResult(widget.lastFinishResult!.obj,currentSubjectVoList!.id??0);

        subtopicAnswerVoMap = AnsweringPage.makeExerciseResultToMap(currentExerciseVos);
        num time = AnsweringPage.findInitTime(widget.lastFinishResult!.obj,currentSubjectVoList!.id??0);
        if(time>0){
          logic.updateTime(countTime: time.toInt());
        }
      } else {
        print("无作答数据异常");
      }
    }else{
      print("作答数据异常，请联系开发人员");
    }

    logic.addListenerId(GetBuilderIds.examResult, () {
      if(widget.answerType == AnsweringPage.answer_fix_type){
        Get.back();
      }else{
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
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    pages = buildQuestionList(widget.testDetailResponse!);

    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
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
                          return Text(
                            TimeUtil.getPractiseTime(_.state.countTime),
                            style: TextStyle(
                                fontSize: 14.w, color: AppColors.c_FF353E4D),
                          );
                        }),
                      ),
                ],
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery
                  .of(context)
                  .size
                  .height -
                  AppBar().preferredSize.height -
                  MediaQuery
                      .of(context)
                      .padding
                      .top),
          child: useOptionArray(pages),
        ),
      ),
    );
  }

  Widget useOptionArray(List<BaseQuestion> pages) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: pages[0],
          ),
        ),
        Visibility(
          visible: hasBottomPageTab,
          child: Container(
          margin:
          EdgeInsets.only(left: 66.w, right: 66.w, top: 10.w, bottom: 10.w),
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
                      return Image.asset(
                        logic.state.currentQuestionNum>0
                            ? R.imagesPractisePreQuestionEnable
                            : R.imagesPractisePreQuestionUnable,
                        width: 40.w,
                        height: 40.w,
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
                    Get.defaultDialog(
                        title: "",
                        textConfirm: "确定",
                        textCancel: "取消",
                        content: Text(
                            widget.answerType == AnsweringPage.answer_fix_type ?
                            "确认纠正错题" : "是否确定提交答案"),
                        onConfirm:(){
                          if(currentSubjectVoList!=null){
                            logic.uploadWeekTest(currentSubjectVoList!,widget.answerType);
                          }else{
                            Util.toast("未获取到试题信息");
                          }

                          Get.back();
                        }
                    );
                  }else{
                    pageLogic.nextPage();
                  }
                },
                child: GetBuilder<AnsweringLogic>(
                    id: GetBuilderIds.answerPageNum,
                    builder: (logic) {
                      return Image.asset(
                        logic.state.currentQuestionNum+1 < logic.state.totalQuestionNum
                            ? R.imagesPractiseNextQuestionEnable
                            : R.imagesPractiseNextQuestionUnable,
                        width: 40.w,
                        height: 40.w,
                      );
                    }),
              )
            ],
          ),
        ))
      ],
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
        }else if (currentSubjectVoList!.questionTypeStr == QuestionType.select_filling){
          questionList.add(SelectFillingQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.complete_filling){
          questionList.add(ReadQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
        }else if(currentSubjectVoList!.questionTypeStr == QuestionType.writing_question){
          hasBottomPageTab = false;
          questionList.add(WritingQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
        }else{
          switch (currentSubjectVoList!.classifyValue) {
            case QuestionTypeClassify.listening: // 听力题
              questionList.add(ListenQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
              break;
            case QuestionTypeClassify.reading: // 阅读题
              questionList.add(ReadQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
              break;
            default:
              questionList.add(OthersQuestion(subtopicAnswerVoMap,widget.answerType,currentSubjectVoList!,widget.childIndex));
              Util.toast("题型分类${currentSubjectVoList!.questionTypeName}还未解析");
          // case QuestionTypeClassify.: // 语言综合训练
          //   if (element.typeChildren == 1) {
          //     // 单项选择题
          //     questionList
          //         .add(ChoiseQuestion(datas: weekTestDetailResponse.data!));
          //     return questionList;
          //   } else if (element.typeChildren == 2) {
          //     // 补全对话
          //     questionList.add(ReadQuestion(data: element));
          //   } else if (element.typeChildren == 3){
          //     // 完型填空
          //     questionList.add(ReadQuestion(data: element));
          //   }
          //   break;
          // case 4: // 写作题
          //   if (element.typeChildren == 7) {
          //     // 写作题
          //   }
          //   break;
          }
        }

      }
    }
    return questionList;
  }

  startTimer() {
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      logic.updateTime();
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  void onDestroy() {
    cancelTimer();

    Get.delete<AnsweringLogic>();
    Get.delete<PageGetxController>();
  }
}
