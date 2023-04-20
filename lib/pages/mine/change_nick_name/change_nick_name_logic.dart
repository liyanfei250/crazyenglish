import 'package:get/get.dart';

import '../../../entity/home/CommentDate.dart';
import '../../../routes/getx_ids.dart';
import '../../index/HomeViewRepository.dart';
import 'change_nick_name_state.dart';

class Change_nick_nameLogic extends GetxController {
  final Change_nick_nameState state = Change_nick_nameState();
  HomeViewRepository recordData = HomeViewRepository();
  void changeNickName(String id) async {
    CommentDate collectResponse = await recordData.toChangeNickName({"mobile": id});
    state.pushDate = collectResponse;
    update([GetBuilderIds.toChangeNickName]);
  }
}
