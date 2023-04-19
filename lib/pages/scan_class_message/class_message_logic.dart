import 'package:crazyenglish/entity/home/ClassInfoDate.dart';
import 'package:get/get.dart';

import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../index/HomeViewRepository.dart';
import 'class_message_state.dart';

class Class_messageLogic extends GetxController {
  final Class_messageState state = Class_messageState();
  HomeViewRepository homeViewRepository = HomeViewRepository();

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
}
