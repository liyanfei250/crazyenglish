import 'package:crazyenglish/entity/week_test_list_response.dart';
import 'package:get/get.dart';

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
        JsonCacheManageUtils.WeekTestListResponse,labelId: weekTime.toString()).then((value){
      if(value!=null){
        return Data.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is Data && cache.records!=null) {
      state.list = cache.records!;
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
    if(list.records==null) {
      if(page ==1){
        state.list.clear();
      }
    } else {
      if(page ==1){
        state.list = list.records!;
      } else {
        state.list.addAll(list.records!);
      }
      if(list.records!.length < pageSize){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.weekTestList]);
  }

}
