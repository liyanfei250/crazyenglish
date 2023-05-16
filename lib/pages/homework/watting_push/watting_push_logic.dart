import 'package:get/get.dart';

import '../../../entity/student_work_list_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../mine/ClassRepository.dart';
import 'watting_push_state.dart';

class Watting_pushLogic extends GetxController {
  final Watting_pushState state = Watting_pushState();
  ClassRepository netTool = ClassRepository();

  void getStudentWorkList(
      int workType, String studentId, int curent, int size,num start, num end ) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> p = {};
    req['workType'] = workType;
    req['studentId'] = studentId;
    req['start'] = start;
    req['end'] = end;
    p['curent'] = curent;
    p['size'] = size;
    req['p'] = p;
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.StudentWorkList,
            labelId: workType.toString() + studentId)
        .then((value) {
      if (value != null) {
        return StudentWorkListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = curent;
    if (curent == 1 &&
        cache is StudentWorkListResponse &&
        cache.obj != null &&
        cache.obj!.records != null) {
      state.list = cache.obj!.records!;
      if (state.list.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update(
          [GetBuilderIds.getStudentWorkList + workType.toString() + studentId]);
    }
    StudentWorkListResponse list = await netTool.getStudentWorkList(req);
    if (curent == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.StudentWorkList,
          labelId: workType.toString() + studentId,
          list.toJson());
    }
    if (list.obj!.records == null) {
      if (curent == 1) {
        state.list.clear();
      }
    } else {
      if (curent == 1) {
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
    update(
        [GetBuilderIds.getStudentWorkList + workType.toString() + studentId]);
  }
}
