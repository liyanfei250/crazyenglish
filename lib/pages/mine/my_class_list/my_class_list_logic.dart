import 'package:get/get.dart';

import '../../../entity/class_detail_response.dart';
import '../../../entity/class_list_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../ClassRepository.dart';
import 'my_class_list_state.dart';

class My_class_listLogic extends GetxController {
  final My_class_listState state = My_class_listState();
  ClassRepository netTool = ClassRepository();

  //班级列表查询
  void getMyClassList(String teacherUserId) async {
    Map<String, String> req = {};
    req['teacherUserId'] = teacherUserId;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeMyClassList,labelId: teacherUserId)
        .then((value) {
      if (value != null) {
        return ClassListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ClassListResponse) {
      state.myClassList = cache!;
      hasCache = true;
      update([GetBuilderIds.getMyClassList+teacherUserId]);
    }
    ClassListResponse list = await netTool.getMyClassList(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyClassList, list.toJson(),labelId: teacherUserId);
    state.myClassList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getMyClassList+teacherUserId]);
    }
  }

}
