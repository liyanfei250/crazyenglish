import 'package:crazyenglish/pages/index/HomeViewRepository.dart';
import 'package:get/get.dart';

import '../../entity/review/HomeListDate.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'index_state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();
  HomeViewRepository homeViewRepository = HomeViewRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHomeList() async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeListDate)
        .then((value) {
      if (value != null) {
        return HomeListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeListDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getSearchRecord]);
    }
    HomeListDate list = await homeViewRepository.getHomeList('');
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListDate,list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getSearchRecord]);
    }
  }
}
