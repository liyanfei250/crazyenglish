import 'dart:convert';
import 'dart:ffi';

import 'package:crazyenglish/entity/base_resp.dart';
import 'package:get/get.dart';

import '../../../entity/home/CommentDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../repository/HomeViewRepository.dart';
import 'question_feedback_state.dart';

class Question_feedbackLogic extends GetxController {
  final Question_feedbackState state = Question_feedbackState();
  HomeViewRepository recordData = HomeViewRepository();

  void postContent(int id,String content,List<String> url,{Long? subtopicId}) async {
    final jsonStr = '{ "userId": $id, "subtopicId": $subtopicId, "content": "$content", "url": ["https://pic2.zhimg.com/80/v2-6e0013227329676938a574be6a7386d1_1440w.webp","321412321312"] }';
    final jsonMap = json.decode(jsonStr);
    CommentDate collectResponse = await recordData.toPushContent(jsonMap);
    state.pushDate = collectResponse;
    update([GetBuilderIds.toPushContent]);
  }
}
