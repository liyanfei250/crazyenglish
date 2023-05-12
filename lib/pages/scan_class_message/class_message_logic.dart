import 'package:crazyenglish/entity/home/ClassInfoDate.dart';
import 'package:get/get.dart';

import '../../entity/class_detail_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../index/HomeViewRepository.dart';
import '../mine/ClassRepository.dart';
import 'class_message_state.dart';

class Class_messageLogic extends GetxController {
  final Class_messageState state = Class_messageState();
  HomeViewRepository homeViewRepository = HomeViewRepository();
  ClassRepository netTool = ClassRepository();

  void getClassInfo() async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeTopScan)
        .then((value) {
      if (value != null) {
        return ClassInfoDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ClassInfoDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeScanDate]);
    }
    ClassInfoDate list = await homeViewRepository.getClassInfo('');
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeTopScan, list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeScanDate]);
    }
  }

  //班级详情
  void getMyClassDetail(String id, {isTeacher = false, isJoin = false}) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeMyClassDetail,
            labelId: id + isTeacher.toString())
        .then((value) {
      if (value != null) {
        return ClassDetailResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ClassDetailResponse) {
      state.myClassListDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getMyClassListDetail + id + isTeacher.toString()]);
    }
    ClassDetailResponse list = await netTool.getMyClassDetail(id,
        isTeacher: isTeacher, isJoin: isJoin);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyClassDetail, list.toJson(),
        labelId: id + isTeacher.toString());
    state.myClassListDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getMyClassListDetail + id + isTeacher.toString()]);
    }
  }
}
