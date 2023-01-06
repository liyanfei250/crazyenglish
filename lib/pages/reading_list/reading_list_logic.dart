import 'package:crazyenglish/repository/week_repository.dart';
import 'package:get/get.dart';

import '../../entity/week_paper_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'reading_list_state.dart';

class ReadingListLogic extends GetxController {
  final ReadingListState state = ReadingListState();

  WeekRepository weekRepository = WeekRepository();

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

  void getPeridList(String weekTime,int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekPaperResponse,labelId: weekTime.toString()).then((value){
      if(value!=null){
        return WeekPaper.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is WeekPaper && cache.records!=null) {
      state.list = cache.records!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      }else{
        state.hasMore = true;
      }
      update([GetBuilderIds.weekList]);
    }
    WeekPaper list = await weekRepository.getWeekPaperList(req);
    if(page ==1){
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.WeekPaperResponse,
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
    update([GetBuilderIds.weekList]);
  }

}
