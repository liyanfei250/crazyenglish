import 'package:get/get.dart';

import '../../entity/class_bottom_info.dart';
import '../../entity/class_top_info.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../mine/ClassRepository.dart';
import 'class_home_state.dart';

class ClassHomeLogic extends GetxController {
  final ClassHomeState state = ClassHomeState();

  ClassRepository netTool = ClassRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getMyClassTop(String classId) async {
    Map<String, String> req = {};
    req['classId'] = classId;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeClassTop,
            labelId: classId)
        .then((value) {
      if (value != null) {
        return ClassTopInfo.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ClassTopInfo) {
      state.myClassTop = cache!;
      hasCache = true;
      update([GetBuilderIds.getMyClassHomeTop + classId]);
    }
    ClassTopInfo list = await netTool.getMyClassTop(classId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeClassTop, list.toJson(),
        labelId: classId);
    state.myClassTop = list!;
    if (!hasCache) {
      update([GetBuilderIds.getMyClassHomeTop + classId]);
    }
  }

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

    bool hasCache = false;
    if (cache is ClassBottomInfo) {
      state.myClassBottom = cache!;
      hasCache = true;
      update([GetBuilderIds.getMyClassHomeBottom + classId]);
    }
    ClassBottomInfo list = await netTool.getMyClassBottom(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeClassBottom, list.toJson(),
        labelId: classId);
    state.myClassBottom = list!;
    if (!hasCache) {
      update([GetBuilderIds.getMyClassHomeBottom + classId]);
    }
  }
}
