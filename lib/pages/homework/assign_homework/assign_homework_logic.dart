import 'package:get/get.dart';

import '../../../entity/common_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../mine/ClassRepository.dart';
import 'assign_homework_state.dart';

class AssignHomeworkLogic extends GetxController {

  final AssignHomeworkState state = AssignHomeworkState();
  ClassRepository netTool = ClassRepository();
  RxInt chooesNum = 0.obs;

  void setSelectedData(Map<String,dynamic> data) {
    chooesNum.value = data['chooesNum'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toReleaseWork(Map<String, dynamic> req) async {
    CommonResponse list = await netTool.toReleaseWork(req);
    state.releaseWork = list!;
    update([GetBuilderIds.getToReleaseWork]);
  }
}
