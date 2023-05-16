import 'package:get/get.dart';

import '../../../entity/home/HomeMyTasksDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../index/HomeViewRepository.dart';
import 'my_task_state.dart';

class My_taskLogic extends GetxController {
  final My_taskState state = My_taskState();
  HomeViewRepository homeViewRepository = HomeViewRepository();
  void getMyTasks(String weekTime, int page, int pageSize) async {
    Map<String, String> req = {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeMyTasks,
        labelId: weekTime.toString())
        .then((value) {
      if (value != null) {
        return HomeMyTasksDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is HomeMyTasksDate && cache != null) {
      state.paperList = cache!;
      //todo 具体的参数获取
      // if(state.paperList.length < pageSize){
      //   state.hasMore = false;
      // } else {
      //   state.hasMore = true;
      // }
      update([GetBuilderIds.getMyTasksDate]);
    }

    HomeMyTasksDate list = await homeViewRepository.getMyTask('');
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeMyTasks,
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
    update([GetBuilderIds.getMyTasksDate]);
  }

}
