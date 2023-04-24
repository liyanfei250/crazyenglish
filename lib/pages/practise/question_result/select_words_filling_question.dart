import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:flutter/material.dart';

import '../../../entity/commit_request.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import 'base_question_result.dart';

/**
 * Time: 2023/4/19 13:44
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 选词填空题
 */
class SelectWordsFillingQuestionResult extends BaseQuestionResult {

  SubjectVoList data;

  SelectWordsFillingQuestionResult(Map<String,ExerciseLists> subtopicAnswerVoMap,{required this.data,Key? key}) : super(subtopicAnswerVoMap,key: key);

  @override
  BaseQuestionResultState<SelectWordsFillingQuestionResult> getState() => _SelectWordsFillingQuestionResultState();

}

class _SelectWordsFillingQuestionResultState extends BaseQuestionResultState<SelectWordsFillingQuestionResult> {

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
