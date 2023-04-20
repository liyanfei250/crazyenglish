import 'package:crazyenglish/entity/base_resp.dart';
import 'package:get/get.dart';

import '../../entity/home/CommentDate.dart';
import '../../routes/getx_ids.dart';
import '../index/HomeViewRepository.dart';
import 'question_feedback_state.dart';

class Question_feedbackLogic extends GetxController {
  final Question_feedbackState state = Question_feedbackState();
  HomeViewRepository recordData = HomeViewRepository();

  void postContent(String id) async {
    CommentDate collectResponse = await recordData.toPushContent({"mobile": id});
    state.pushDate = collectResponse;
    update([GetBuilderIds.toPushContent]);
  }
}
