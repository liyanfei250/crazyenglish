import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:flutter/material.dart';

import '../../../entity/week_detail_response.dart';

/**
 * Time: 2023/4/19 13:44
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 选词填空题
 */
class SelectWordsFillingQuestion extends BaseQuestion {

  SubjectVoList data;

  SelectWordsFillingQuestion({required this.data,Key? key}) : super(key: key);

  @override
  BaseQuestionState<SelectWordsFillingQuestion> getState() => _SelectWordsFillingQuestionState();

}

class _SelectWordsFillingQuestionState extends BaseQuestionState<SelectWordsFillingQuestion> {

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
