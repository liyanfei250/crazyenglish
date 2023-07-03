import 'package:get/get.dart';

import '../../../entity/class_list_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../mine/ClassRepository.dart';
import 'choose_student_state.dart';

class ChooseStudentLogic extends GetxController {
  final ChooseStudentState state = ChooseStudentState();
  ClassRepository netTool = ClassRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  //班级列表查询
  void getMyClassList(String teacherUserId) async {
    Map<String, String> req = {};
    req['teacherUserId'] = teacherUserId;

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeClassTab,labelId: teacherUserId)
        .then((value) {
      if (value != null) {
        return ClassListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ClassListResponse) {
      state.myClassList = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeClassTab+teacherUserId]);
    }
    ClassListResponse list = await netTool.getMyClassList(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeClassTab, list.toJson(),labelId: teacherUserId);
    state.myClassList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeClassTab+teacherUserId]);
    }
  }
}
