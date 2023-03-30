import 'package:crazyenglish/entity/HomeworkJournalResponse.dart';
import 'package:get/get.dart';

import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'choose_journal_state.dart';

class ChooseJournalLogic extends GetxController {
  final ChooseJournalState state = ChooseJournalState();

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

  void getJournalList(int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.JournalListResponse).then((value){
      if(value!=null){
        return HomeworkJournalResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is HomeworkJournalResponse && cache.data!=null && cache.data!.journals!=null) {
      state.list = cache.data!.journals!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      }else{
        state.hasMore = true;
      }
      update([GetBuilderIds.getJournalList]);
    }

    List<Journals> students = [];
    for(int i = 0;i<13;i++){
      Journals student = Journals(id: page*100+i,name: "初二阅读：${page*100+i}期");
      students.add(student);
    }
    state.list = students!;
    if(state.list.length < pageSize){
      state.hasMore = false;
    }else{
      state.hasMore = true;
    }
    update([GetBuilderIds.getJournalList]);

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
    update([GetBuilderIds.getJournalList]);
  }
}
