import 'dart:convert';
import 'dart:ffi';

import 'package:crazyenglish/entity/base_resp.dart';
import 'package:crazyenglish/entity/feedback_request.dart';
import 'package:get/get.dart';

import '../../../entity/home/CommentDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../repository/HomeViewRepository.dart';
import 'question_feedback_state.dart';

class Question_feedbackLogic extends GetxController {
  final Question_feedbackState state = Question_feedbackState();
  HomeViewRepository recordData = HomeViewRepository();

  void postFeedback(num sourceId,int feedbackType,String content,List<String> url) async {
    FeedbackRequest feedbackRequest = FeedbackRequest(
      sourceId: sourceId,
      type:feedbackType,
        content: content,
    imgs: url);
    CommentDate collectResponse = await recordData.toUploadFeeedback(feedbackRequest.toJson());
    state.pushDate = collectResponse;
    update([GetBuilderIds.toPushContent]);
  }
}
