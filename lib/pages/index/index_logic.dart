import 'package:crazyenglish/pages/index/HomeViewRepository.dart';
import 'package:get/get.dart';

import '../../entity/home/HomeKingDate.dart';
import '../../entity/home/HomeMyJournalListDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
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

  void getHomeList(String type) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeListDate)
        .then((value) {
      if (value != null) {
        return HomeKingDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeDateList]);
    }
    HomeKingDate list = await homeViewRepository.getHomeKingList(type);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListDate,list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateList]);
    }
  }

  void getMyJournalList() async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeMyJournalDate)
        .then((value) {
      if (value != null) {
        return HomeMyJournalListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeMyJournalListDate) {
      state.myJournalDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeMyJournalDate]);
    }
    HomeMyJournalListDate list = await homeViewRepository.getMyJournalList('');
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyJournalDate,list.toJson());
    state.myJournalDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeMyJournalDate]);
    }
  }

  void getMyTasks() async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeMyTasks)
        .then((value) {
      if (value != null) {
        return HomeMyTasksDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeMyTasksDate) {
      state.myTask = cache!;
      hasCache = true;
      update([GetBuilderIds.getMyTasksDate]);
    }
    HomeMyTasksDate list = await homeViewRepository.getMyTask('');
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyTasks,list.toJson());
    state.myTask = list!;
    if (!hasCache) {
      update([GetBuilderIds.getMyTasksDate]);
    }
  }
}
