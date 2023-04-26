import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/commit_request.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../question_factory.dart';
import 'base_question_result.dart';

/**
 * Time: 2023/4/19 13:48
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 选择填空题结果页
 */
class SelectFillingQuestionResult extends BaseQuestionResult {
  SubjectVoList data;

  SelectFillingQuestionResult(Map<String,ExerciseLists> subtopicAnswerVoMap,{required this.data,Key? key}) : super(subtopicAnswerVoMap,key: key);

  @override
  BaseQuestionResultState<SelectFillingQuestionResult> getState() => _SelectFillingQuestionResultState();

}

class _SelectFillingQuestionResultState extends BaseQuestionResultState<SelectFillingQuestionResult> {

  late SubjectVoList element;

  int questionNum = 0;
  @override
  void onCreate() {
    element = widget.data;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.w,right: 18.w,top: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildQuestionDesc("原文"),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          Expanded(child: getDetail(0))
        ],
      ),
    );
  }

  Widget getDetail(int defaultIndex){
    // 判断是否父子题
    // 普通阅读 常规阅读题 是父子题
    questionNum = element.subtopicVoList!.length;
    if(logic!=null){
      logic.updateCurrentPage(defaultIndex,totalQuestion: questionNum,isInit: true);
      selectGapGetxController.updateFocus("${defaultIndex+1}",true,isInit: true);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildQuestionType("选择填空题"),
          QuestionFactory.buildSelectFillingQuestion(element,makeFocusNodeController,widget.subtopicAnswerVoMap),
          QuestionFactory.buildSelectOptionQuestion(element.optionsList!,isClickEnable:false)
        ],
      ),
    );
  }


  @override
  void next() {
    bool canNext = false;
    int nextIndex = -1;
    selectGapGetxController.hasFocusMap.forEach((key, value) {
      if(value){
        if(questionNum == int.parse(key)){
          canNext = false;
        }else{
          if(int.parse(key)+1 <= questionNum){
            canNext = true;
            nextIndex = int.parse(key);
          }
        }
      }
    });
    if(canNext){
      jumpToQuestion(nextIndex);
    }
  }

  @override
  void pre() {
    bool canPre = false;
    int preIndex = -1;
    selectGapGetxController.hasFocusMap.forEach((key, value) {
      if(value){
        if(int.parse(key)-1>0){
          canPre = true;
          preIndex = int.parse(key)-1-1;
        }
      }
    });
    if(canPre){
      jumpToQuestion(preIndex);
    }
  }

  @override
  void jumpToQuestion(int index) {
    // 更新空选中状态
    selectGapGetxController.updateFocus("${index+1}",true);
    // 更细底部页码
    int currentPage = index;
    logic.updateCurrentPage(currentPage);
  }

  @override
  getAnswers() {
    // TODO: implement getAnswers
    throw UnimplementedError();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
