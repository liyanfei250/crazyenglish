import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/pages/practise/question_result/base_question_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../base/common.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/test_player_widget.dart';

class WritingQuestionResult extends BaseQuestionResult {
  SubjectVoList data;

  WritingQuestionResult(Map<String,ExerciseLists> subtopicAnswerVoMap,{required this.data,Key? key}) : super(subtopicAnswerVoMap,key: key);


  @override
  BaseQuestionResultState<BaseQuestionResult> getState() {
    return _WritingQuestionResultState();
  }

}

class _WritingQuestionResultState extends BaseQuestionResultState<WritingQuestionResult> {

  late SubjectVoList element;

  @override
  getAnswers() {
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
          buildQuestionType("写作题"),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          Expanded(child: getQuestionDetail(element)),
        ],
      ),
    );
  }

  @override
  void onDestroy() {
  }

}