import 'package:get/get.dart';

import '../../../entity/home/CommentDate.dart';
import '../../../routes/getx_ids.dart';
import '../../index/HomeViewRepository.dart';
import 'change_psd_state.dart';

class Change_psdLogic extends GetxController {
  final Change_psdState state = Change_psdState();
  HomeViewRepository recordData = HomeViewRepository();

  void toChangePassword(String id) async {
    CommentDate collectResponse = await recordData.toChangePassword({"mobile": id});
    state.pushDate = collectResponse;
    update([GetBuilderIds.toChangeNickName]);
  }
}
