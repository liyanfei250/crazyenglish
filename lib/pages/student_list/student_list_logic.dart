import 'package:get/get.dart';

import '../../entity/class_bottom_info.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../mine/ClassRepository.dart';
import 'student_list_state.dart';

class Student_listLogic extends GetxController {
  final Student_listState state = Student_listState();
  ClassRepository netTool = ClassRepository();

  void getMyClassBottom(String classId, int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> p = {};
    p['current'] = current;
    p['size'] = size;
    req['classId'] = classId;
    req['p'] = p;
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeClassBottom,
        labelId: classId)
        .then((value) {
      if (value != null) {
        return ClassBottomInfo.fromJson(value as Map<String, dynamic>?);
      }
    });
    state.pageNo = current;
    if (current == 1 && cache is ClassBottomInfo && cache.obj != null) {
      state.list = cache.obj!.records!;
      if (state.list.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getMyClassHomeBottom + classId]);
    }

    ClassBottomInfo list = await netTool.getMyClassBottom(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeClassBottom,
          labelId: classId,
          list.toJson());
    }
    if (list.obj == null) {
      if (current == 1) {
        state.list.clear();
      }
    } else {
      if (current == 1) {
        state.list = list.obj!.records!;
      } else {
        state.list.addAll(list.obj!.records!);
      }
      if (list.obj!.records!.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getMyClassHomeBottom + classId]);
  }
}
