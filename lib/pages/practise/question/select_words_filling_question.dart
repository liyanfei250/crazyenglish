import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../question_factory.dart';

/**
 * Time: 2023/4/19 13:44
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 选词填空题
 */
class SelectWordsFillingQuestion extends BaseQuestion {

  SelectWordsFillingQuestion(SubjectVoList data,{Key? key}) : super(data:data,key: key);

  @override
  BaseQuestionState<SelectWordsFillingQuestion> getState() => _SelectWordsFillingQuestionState();

}

class _SelectWordsFillingQuestionState extends BaseQuestionState<SelectWordsFillingQuestion> {

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
          Expanded(child: getDetail(0),)
        ],
      ),
    );
  }


  Widget getDetail(int defaultIndex){
    questionNum = element.subtopicVoList!.length;
    if(logic!=null){
      logic.updateCurrentPage(defaultIndex,totalQuestion: questionNum);
      jumpToQuestion(defaultIndex);
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildQuestionType("选词填空题"),
          QuestionFactory.buildSelectFillingQuestion(element,makeFocusNodeController),
          QuestionFactory.buildSelectAnswerQuestion(element.optionsList!)
        ],
      ),
    );
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
