import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/entity/home/HomeKingNewDate.dart';
import 'package:crazyenglish/entity/home/HomeMyTasksDate.dart';
import 'package:crazyenglish/entity/week_list_response.dart';
import 'package:crazyenglish/repository/HomeViewRepository.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/json_cache_util.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:get/get.dart';

import 'index_new_state.dart';

class Index_newLogic extends GetxController {
  final Index_newState state = Index_newState();
  HomeViewRepository homeViewRepository = HomeViewRepository();

  void getHomeListNew() async {
    String type = "0";
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeKingListNew,labelId: type)
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
        JsonCacheManageUtils.HomeKingListNew,labelId:type, list.toJson());
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
        return WeekListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is WeekListResponse) {
      state.myJournalDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeMyJournalDate]);
    }
    WeekListResponse list = await homeViewRepository.getMyJournalList(SpUtil.getInt(BaseConstant.USER_ID).toString());
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyJournalDate, list.toJson());
    state.myJournalDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeMyJournalDate]);
    }
  }

}
