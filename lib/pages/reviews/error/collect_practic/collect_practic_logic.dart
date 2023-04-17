import 'package:get/get.dart';

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

  void getCollectList(String weekTime, int page, int pageSize) async {
    Map<String, String> req = {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.SearchCollectListDate,
            labelId: weekTime.toString())
        .then((value) {
      if (value != null) {
        return SearchCollectListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is SearchCollectListDate && cache != null) {
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
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.SearchCollectListDate,
          labelId: weekTime.toString(),
          list.toJson());
    }
    //todo 具体的参数获取
    // if(list.rows==null) {
    //   if(page ==1){
    //     state.paperList.clear();
    //   }
    // } else {
    //   if(page ==1){
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

  void toCollect(String id) async {
    CollectDate collectResponse = await recordData.toCollect({"mobile": id});
    state.collectDate = collectResponse;
    update([GetBuilderIds.toCollectDate]);
  }

  void toCancellCollect(String id) async {
    CancellCollectDate collectCancelResponse = await recordData.toCancellCollect({"mobile": id});
    state.cancellCollectDate = collectCancelResponse;
    update([GetBuilderIds.toCancellCollectDate]);
  }
}
