import 'dart:convert';

import 'package:crazyenglish/entity/HomeworkJournalResponse.dart';
import 'package:get/get.dart';

import '../../../entity/week_list_response.dart';
import '../../../repository/week_test_repository.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'choose_journal_state.dart';

class ChooseJournalLogic extends GetxController {
  final ChooseJournalState state = ChooseJournalState();
  final WeekTestRepository weekTestListResponse = WeekTestRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getJournalList(dynamic affiliatedGrade, int page, int pageSize) async{

    String jsonStr =
        '{ "affiliatedGrade": $affiliatedGrade, "p": { "size":$pageSize, "current": $page } }';
    Map<String, dynamic> req = jsonDecode(jsonStr);
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekTestListResponse,
        labelId: affiliatedGrade.toString())
        .then((value) {
      if (value != null) {
        return WeekListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is WeekListResponse && cache.obj != null) {
      state.list = cache.obj!;
      if (state.list.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getJournalList]);
    }
    WeekListResponse list = await weekTestListResponse.getWeekTestList(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.WeekTestListResponse,
          list.toJson());
    }
    if (list.obj == null) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.obj!;
      } else {
        state.list.addAll(list.obj!);
      }
      if (list.obj!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getJournalList]);

    /*state.pageNo = page;
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
    update([GetBuilderIds.getJournalList]);*/

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
    // update([GetBuilderIds.getJournalList]);
  }
}
