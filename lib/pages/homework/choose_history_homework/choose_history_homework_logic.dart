import 'package:get/get.dart';

import '../../../entity/HomeworkHistoryResponse.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'choose_history_homework_state.dart';

class ChooseHistoryHomeworkLogic extends GetxController {
  final ChooseHistoryHomeworkState state = ChooseHistoryHomeworkState();

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


  void getHomeworkHistoryList(int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeworkHistoryResponse).then((value){
      if(value!=null){
        return HomeworkHistoryResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is HomeworkHistoryResponse && cache.data!=null && cache.data!.history!=null) {
      state.list = cache.data!.history!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      }else{
        state.hasMore = true;
      }
      update([GetBuilderIds.getHistoryHomeworkList]);
    }

    List<History> historys = [];
    for(int i = 0;i<13;i++){
      History student = History(id: page*100+i,name: "初二阅读：${page*100+i}期");
      historys.add(student);
    }
    state.list = historys!;
    if(state.list.length < pageSize){
      state.hasMore = false;
    }else{
      state.hasMore = true;
    }
    update([GetBuilderIds.getHistoryHomeworkList]);

    // WeekPaper list = await weekRepository.getWeekPaperList(req);
    // if(page ==1){
    //   JsonCacheManageUtils.saveCacheData(
    //       JsonCacheManageUtils.WeekPaperResponse,
    //       labelId: weekTime.toString(),
    //       list.toJson());
    // }
    // if(list.records==null) {
    //   if(page ==1){
    //     state.list.clear();
    //   }
    // } else {
    //   if(page ==1){
    //     state.list = list.records!;
    //   } else {
    //     state.list.addAll(list.records!);
    //   }
    //   if(list.records!.length < pageSize){
    //     state.hasMore = false;
    //   } else {
    //     state.hasMore = true;
    //   }
    // }
    update([GetBuilderIds.getHistoryHomeworkList]);
  }
}
