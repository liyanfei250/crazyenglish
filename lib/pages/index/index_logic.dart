import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/pages/index/HomeViewRepository.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:get/get.dart';

import '../../entity/home/HomeKingDate.dart';
import '../../entity/home/HomeKingNewDate.dart';
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

  //todo 新增的金刚区列表
  void getHomeListNew(String type) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeKingListNew)
        .then((value) {
      if (value != null) {
        return HomeKingNewDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingNewDate) {
      state.paperDetailNew = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeDateListNew]);
    }

    HomeKingNewDate list = await homeViewRepository.getHomeKingListNew(type);

    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeKingListNew, list.toJson());
    state.paperDetailNew = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateListNew]);
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
    HomeMyJournalListDate list = await homeViewRepository.getMyJournalList(SpUtil.getInt(BaseConstant.USER_ID).toString());
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyJournalDate, list.toJson());
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
        JsonCacheManageUtils.HomeMyTasks, list.toJson());
    state.myTask = list!;
    if (!hasCache) {
      update([GetBuilderIds.getMyTasksDate]);
    }
  }
}
