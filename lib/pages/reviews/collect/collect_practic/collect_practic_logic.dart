import 'package:get/get.dart';

import '../../../../entity/home/HomeKingDate.dart';
import '../../../../entity/home/SearchCollectListDetail.dart';
import '../../../../entity/review/CancellCollectDate.dart';
import '../../../../entity/review/CollectDate.dart';
import '../../../../entity/review/SearchCollectListDate.dart';
import '../../../../entity/review/SearchRecordDate.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import '../../repository/ReviewRepository.dart';
import 'collect_practic_state.dart';

class Collect_practicLogic extends GetxController {
  final Collect_practicState state = Collect_practicState();
  ReviewRepository recordData = ReviewRepository();

  void getSearchRecord(String id) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.SearchRecordDate,
            labelId: id.toString())
        .then((value) {
      if (value != null) {
        return SearchRecordDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is SearchRecordDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getSearchRecord]);
    }
    SearchRecordDate list = await recordData.getSearchRecordList(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.SearchRecordDate, labelId: id, list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getSearchRecord]);
    }
  }

  //搜索筛选
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
      state.tabList = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeDateList]);
    }
    HomeKingDate list = await recordData.getHomeKingList(type);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListDate, list.toJson());
    state.tabList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateList]);
    }
  }


  void getCollectList(int userId, bool isRecentView, dynamic classify, int size,
      int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["userId"] = userId;
    req["isRecentView"] = isRecentView;
    req["classify"] = classify;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.SearchCollectListDate,
            labelId: userId.toString())
        .then((value) {
      if (value != null) {
        return SearchCollectListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 && cache is SearchCollectListDate && cache != null) {
      state.paperList = cache!;
      //todo 具体的参数获取
      // if(state.paperList.length < pageSize){
      //   state.hasMore = false;
      // } else {
      //   state.hasMore = true;
      // }
      update([GetBuilderIds.getCollectListDate]);
    }

    SearchCollectListDate list = await recordData.getCollectList(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.SearchCollectListDate,
          labelId: userId.toString(),
          list.toJson());
    }
    //todo 具体的参数获取
    // if(list.rows==null) {
    //   if(current ==1){
    //     state.paperList.clear();
    //   }
    // } else {
    //   if(current ==1){
    //     state.paperList = list.rows!;
    //   } else {
    //     state.paperList.addAll(list.rows!);
    //   }
    //   if(list.rows!.length < pageSize){
    //     state.hasMore = false;
    //   } else {
    //     state.hasMore = true;
    //   }
    // }
    update([GetBuilderIds.getCollectListDate]);
  }

  void toCollect(int userid, String id) async {
    CollectDate collectResponse = await recordData.toCollect(userid, id);
    state.collectDate = collectResponse;
    update([GetBuilderIds.toCollectDate]);
  }
}
