import 'package:crazyenglish/pages/practise/question_answering/base_question.dart';
import 'package:flutter/material.dart';

import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';

/**
 * Time: 2023/4/19 13:39
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 完形填空题
 */
class CompleteFillingQuestion extends BaseQuestion {

  CompleteFillingQuestion(Map<String,ExerciseLists> subtopicAnswerVoMap,int answerType,SubjectVoList data,int childIndex,{Key? key}) : super(subtopicAnswerVoMap,answerType,childIndex,data:data,key: key);

  @override
  BaseQuestionState<CompleteFillingQuestion> getState() => _CompleteFillingQuestionState();

}

class _CompleteFillingQuestionState extends BaseQuestionState<CompleteFillingQuestion> {

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
