import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/start_exam.dart';
import '../answer_interface.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import 'base_question.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_detail_response.dart';
/**
 * Time: 2023/2/21 14:02
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class ReadQuestion extends BaseQuestion {

  ReadQuestion(Map<String,ExerciseLists> subtopicAnswerVoMap,int answerType,SubjectVoList data,int childIndex,{Key? key}) : super(subtopicAnswerVoMap,answerType,childIndex,data:data,key: key);


  @override
  BaseQuestionState<BaseQuestion> getState() {
    return _ReadQuestionState();
  }

}

class _ReadQuestionState extends BaseQuestionState<ReadQuestion> {

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
    if(selectGapGetxController!=null){
      selectGapGetxController.disposeId(GetBuilderIds.updateFocus+"isInit");
      selectGapGetxController.disposeId(GetBuilderIds.updateFocus);
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.w,right: 18.w,top: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildQuestionDesc("原文"),
          Padding(padding: EdgeInsets.only(top: 8.w),),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          buildReadQuestion(element!.content),
          buildQuestionDesc("Question"),
        ],
      ),
    );
  }

  Widget buildReadQuestion(String? htmlContent){
    return Container(
      height: 204.w,
      margin: EdgeInsets.only(top: 17.w,bottom: 18.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.c_FFD2D5DC,width: 0.4.w)
      ),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child:  Util.getHtmlWidget(htmlContent),
      ),
    );
  }

  @override
  void onDestroy() {
  }
}