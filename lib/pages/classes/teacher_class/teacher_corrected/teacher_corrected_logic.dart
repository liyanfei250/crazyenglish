import 'package:get/get.dart';

import '../../../../entity/to_correct_response.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import '../../../mine/ClassRepository.dart';
import 'teacher_corrected_state.dart';

class Teacher_correctedLogic extends GetxController {
  final Teacher_correctedState state = Teacher_correctedState();
  ClassRepository netTool = ClassRepository();
  void getHomeListToCorrect() async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.TeacherToCorrected)
        .then((value) {
      if (value != null) {
        return ToCorrectResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ToCorrectResponse) {
      state.myTask = cache!;
      hasCache = true;
      update([GetBuilderIds.getTeacherToCorrected]);
    }
    ToCorrectResponse list = await netTool.getHomeListToCorrect({'test':2});
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.TeacherToCorrected, list.toJson());
    state.myTask = list!;
    if (!hasCache) {
      update([GetBuilderIds.getTeacherToCorrected]);
    }
  }
}
