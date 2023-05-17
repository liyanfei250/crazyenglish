import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../entity/home/HomeMyTasksDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../../utils/sp_util.dart';
import '../../../repository/HomeViewRepository.dart';
import 'my_task_state.dart';

class My_taskLogic extends GetxController {
  final My_taskState state = My_taskState();
  HomeViewRepository homeViewRepository = HomeViewRepository();

  void getMyTasks(String weekTime, int page, int pageSize) async {
    Map<String, dynamic> req = {};
    Map<String,String> pageParam = {};
    pageParam["current"] = "$page";
    pageParam["size"] = "$pageSize";
    req["p"] = pageParam;
    req["userId"] = SpUtil.getInt(BaseConstant.USER_ID);

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
      state.paperList = cache.obj!;
      if(state.paperList.length < pageSize){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getMyTasksDate]);
    }

    HomeMyTasksDate list = await homeViewRepository.getMyTask(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeMyTasks,
          labelId: weekTime.toString(),
          list.toJson());
    }

    if(list.obj==null) {
      if(page ==1){
        state.paperList.clear();
      }
    } else {
      if(page ==1){
        state.paperList = list.obj!;
      } else {
        state.paperList.addAll(list.obj!);
      }
      if(list.obj!.length < pageSize){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getMyTasksDate]);
  }

}
