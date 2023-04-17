import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import '../question/base_question.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_detail_response.dart';
import 'base_question_result.dart';
/**
 * Time: 2023/2/21 16:06
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class GapQuestionResult extends BaseQuestionResult {
  Data data;

  GapQuestionResult({required this.data,Key? key}) : super(key: key,);


  @override
  BaseQuestionResultState<BaseQuestionResult> getState() {
    // TODO: implement getState
    return _GapQuestionResultState();
  }

}

class _GapQuestionResultState extends BaseQuestionResultState<GapQuestionResult> {

  late Data element;

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

    return SingleChildScrollView(
      child: Column(
        children: [
          buildQuestionType("填空题"),
          Visibility(
              visible: element.title!=null && element.title!.isNotEmpty,
              child: Text(element.title??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          // Visibility(
          //     visible: element.name!=null && element.name!.isNotEmpty,
          //     child: Text(element.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          getQuestionDetail(element),
        ],
      ),
    );
  }



  @override
  void onDestroy() {
  }
}