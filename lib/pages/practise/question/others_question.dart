import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import 'base_question.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_detail_response.dart';

/**
 * Time: 2023/2/21 16:05
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class OthersQuestion extends BaseQuestion {
  SubjectVoList data;

  OthersQuestion({required this.data,Key? key}) : super(key: key);

  @override
  BaseQuestionState<BaseQuestion> getState() {
    // TODO: implement getState
    return _OthersQuestionState();
  }

}

class _OthersQuestionState extends BaseQuestionState<OthersQuestion> {

  late SubjectVoList element;

  @override
  getAnswers() {
    // TODO: implement getAnswers
    throw UnimplementedError();
  }

  @override
  void onCreate() {
    element = widget.data;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildQuestionType("单选题"),
          Expanded(child:getQuestionDetail(element)),
        ],
      ),
    );
  }



  @override
  void onDestroy() {
  }
}