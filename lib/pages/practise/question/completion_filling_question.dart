import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:flutter/material.dart';

import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';

/**
 * Time: 2023/4/19 14:40
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class CompletionFillingQuestion extends BaseQuestion {

  CompletionFillingQuestion(Map<String,ExerciseLists> subtopicAnswerVoMap,int answerType,SubjectVoList data,int childIndex,{Key? key}) : super(subtopicAnswerVoMap,answerType,childIndex,data:data,key: key);

  @override
  BaseQuestionState<CompletionFillingQuestion> getState() => _CompletionFillingQuestionState();
}

class _CompletionFillingQuestionState extends BaseQuestionState<CompletionFillingQuestion> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  getAnswers() {
    throw UnimplementedError();
  }

  @override
  void onCreate() {
  }

  @override
  void onDestroy() {
  }
}
