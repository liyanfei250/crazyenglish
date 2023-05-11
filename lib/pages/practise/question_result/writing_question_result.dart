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
    collectLogic.queryCollectState(element.id??0);
    return _buildClassCard(0);
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
                      return buildFavorAndFeedback(_.state.collectMap["${element.id}"]??false, element.id);
                    },
                  )
                ],
              ),
              buildReadQuestion(widget.data.modelEssay??"无范文"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildQuestionDesc("原文"),
                  Text('')
                ],
              ),
              buildReadQuestion(widget.subtopicAnswerVoMap[element.id.toString()+ ":0"]!=null ? widget.subtopicAnswerVoMap[element.id.toString()+ ":0"]!.answer??"无数据":"无数据"),
              // _exampleLayout(),
            ],
          ),
        )
      ],
    ),
  );


  @override
  void onDestroy() {}

}
