import 'package:get/get.dart';

import '../../../entity/student_detail_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../mine/ClassRepository.dart';
import 'student_state.dart';

class StudentLogic extends GetxController {
  final StudentState state = StudentState();
  ClassRepository netTool = ClassRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getStudentDetail(String userId) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.StudentDetail,
            labelId: userId)
        .then((value) {
      if (value != null) {
        return StudentDetailResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is StudentDetailResponse) {
      state.myStudentDetail= cache!;
      hasCache = true;
      update([GetBuilderIds.getStudentDetail + userId]);
    }
    StudentDetailResponse list = await netTool.getStudentDetail(userId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.StudentDetail, list.toJson(),
        labelId: userId);
    state.myStudentDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getStudentDetail + userId]);
    }
  }
}
