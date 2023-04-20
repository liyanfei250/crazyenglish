import 'package:crazyenglish/base/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_detail_response.dart';
import '../question_result/base_question_result.dart';

/**
 * Time: 2023/2/21 16:05
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class OthersQuestionResult extends BaseQuestionResult {
  SubjectVoList data;

  OthersQuestionResult({required this.data,Key? key}) : super(key: key);

  @override
  BaseQuestionResultState<BaseQuestionResult> getState() {
    // TODO: implement getState
    return _OthersQuestionResultState();
  }

}

class _OthersQuestionResultState extends BaseQuestionResultState<OthersQuestionResult> {

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
          buildQuestionType(QuestionType.getName(element.questionTypeStr!)),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          Expanded(child:getQuestionDetail(element)),
        ],
      ),
    );
  }



  @override
  void onDestroy() {
  }
}