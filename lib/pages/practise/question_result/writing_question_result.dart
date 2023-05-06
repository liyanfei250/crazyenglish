import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/pages/practise/question_result/base_question_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../../reviews/collect/collect_practic/collect_practic_logic.dart';
import '../../week_test/week_test_detail/test_player_widget.dart';

class WritingQuestionResult extends BaseQuestionResult {
  SubjectVoList data;

  WritingQuestionResult(Map<String, ExerciseLists> subtopicAnswerVoMap,
      {required this.data, Key? key})
      : super(subtopicAnswerVoMap, key: key);

  @override
  BaseQuestionResultState<BaseQuestionResult> getState() {
    return _WritingQuestionResultState();
  }
}

class _WritingQuestionResultState
    extends BaseQuestionResultState<WritingQuestionResult> {
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
    return Scaffold(
        body: _buildClassCard(0));
  }

  Widget _buildClassCard(int index) => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8.w),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.only(top: 18.w, left: 18.w, right: 18.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildQuestionDesc("范文"),
                  GetBuilder<Collect_practicLogic>(
                    id: "${GetBuilderIds.collectState}:${element.id}",
                    builder: (_){
                      return buildFavorAndFeedback(_.collectMap["${element.id}"]??false, element.id);
                    },
                  )
                ],
              ),
              buildReadQuestion(widget.data.content??"无数据"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildQuestionDesc("原文"),
                  GetBuilder<Collect_practicLogic>(
                    id: "${GetBuilderIds.collectState}:${element.id}",
                    builder: (_){
                      return buildFavorAndFeedback(_.collectMap["${element.id}"]??false, element.id);
                    },
                  )
                ],
              ),
              buildReadQuestion("无数据"),
              // _exampleLayout(),
            ],
          ),
        )
      ],
    ),
  );

  Widget _myHorizontalLayout(String iconData, String title, String subtitle) =>
      Row(
        children: [
          Image.asset(
            iconData,
            width: 12.w,
            height: 12.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Color(0xffb3b7c6)),
              )),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
            child: Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffb3b7c6)),
                )),
          )
        ],
      );

  @override
  void onDestroy() {}

}
