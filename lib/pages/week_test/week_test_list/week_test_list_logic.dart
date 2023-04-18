import 'package:crazyenglish/entity/week_list_response.dart';
import 'package:get/get.dart';

import '../../../entity/review/HomeWeeklyChoiceDate.dart';
import '../../../repository/week_test_repository.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'week_test_list_state.dart';

class WeekTestListLogic extends GetxController {
  final WeekTestListState state = WeekTestListState();

  final WeekTestRepository weekTestListResponse = WeekTestRepository();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getList(String weekTime,int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekListRespose,labelId: weekTime.toString()).then((value){
      if(value!=null){
        return Data.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is Data && cache.rows!=null) {
      state.list = cache.rows!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.weekTestList]);
    }
    Data list = await weekTestListResponse.getWeekTestList(req);
    if(page ==1){
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.WeekTestListResponse,
          labelId: weekTime.toString(),
          list.toJson());
    }
    if(list.rows==null) {
      if(page ==1){
        state.list.clear();
      }
    } else {
      if(page ==1){
        state.list = list.rows!;
      } else {
        state.list.addAll(list.rows!);
      }
      if(list.rows!.length < pageSize){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.weekTestList]);
  }


  void getChoiceMap(String id) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeWeeklyListChoiceDate,
        labelId: id.toString())
        .then((value) {
      if (value != null) {
        return HomeWeeklyChoiceDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeWeeklyChoiceDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeWeeklyChoiceDate]);
    }
    HomeWeeklyChoiceDate list = await weekTestListResponse.getHomeWeeklyChoiceDate(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeWeeklyListChoiceDate, labelId: id, list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeWeeklyChoiceDate]);
    }
  }
}
