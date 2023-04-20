import 'package:get/get.dart';

import '../../entity/home/HomeSearchListDate.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../index/HomeViewRepository.dart';
import 'search_list_state.dart';

class Search_listLogic extends GetxController {
  final Search_listState state = Search_listState();
  HomeViewRepository homeViewRepository = HomeViewRepository();

  void getSearchList(String weekTime, int page, int pageSize) async {
    Map<String, String> req = {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeTopSearch,
            labelId: weekTime.toString())
        .then((value) {
      if (value != null) {
        return HomeSearchListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is HomeSearchListDate && cache != null) {
      state.paperList = cache!;
      //todo 具体的参数获取
      // if(state.paperList.length < pageSize){
      //   state.hasMore = false;
      // } else {
      //   state.hasMore = true;
      // }
      update([GetBuilderIds.getHomeSearchDate]);
    }

    HomeSearchListDate list = await homeViewRepository.getSearchDateList(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeTopSearch,
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
    update([GetBuilderIds.getHomeSearchDate]);
  }
}
