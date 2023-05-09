import 'package:get/get.dart';

import '../../entity/class_bottom_info.dart';
import '../../entity/class_list_response.dart';
import '../../entity/class_top_info.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../mine/ClassRepository.dart';
import 'class_state.dart';

class ClassLogic extends GetxController {
  final ClassState state = ClassState();
  ClassRepository netTool = ClassRepository();

  //班级列表查询
  void getMyClassList(String teacherUserId) async {
    Map<String, String> req = {};
    req['teacherUserId'] = teacherUserId;

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeClassTab)
        .then((value) {
      if (value != null) {
        return ClassListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ClassListResponse) {
      state.myClassList = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeClassTab]);
    }
    ClassListResponse list = await netTool.getMyClassList(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeClassTab, list.toJson());
    state.myClassList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeClassTab]);
    }
  }
}
