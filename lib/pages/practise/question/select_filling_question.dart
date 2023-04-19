import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:flutter/material.dart';

import '../../../entity/week_detail_response.dart';

/**
 * Time: 2023/4/19 13:48
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 选择填空题
 */
class SelectFillingQuestion extends BaseQuestion {
  SubjectVoList data;

  SelectFillingQuestion({required this.data,Key? key}) : super(key: key);

  @override
  BaseQuestionState<SelectFillingQuestion> getState() => _SelectFillingQuestionState();

}

class _SelectFillingQuestionState extends BaseQuestionState<SelectFillingQuestion> {

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
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
