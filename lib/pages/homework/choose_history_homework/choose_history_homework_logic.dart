import 'package:get/get.dart';

import '../../../entity/HomeworkHistoryResponse.dart';
import '../../../repository/home_work_repository.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'choose_history_homework_state.dart';

class ChooseHistoryHomeworkLogic extends GetxController {
  final ChooseHistoryHomeworkState state = ChooseHistoryHomeworkState();
  HomeworkRepository homeworkRepository = HomeworkRepository();

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


  //TODO 缓存key需要处理
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
    if(page==1 && cache is HomeworkHistoryResponse && cache.obj!=null && cache.obj!.records!=null) {
      state.list = cache.obj!.records!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getHistoryHomeworkList]);
    }


    HomeworkHistoryResponse list = await homeworkRepository.getHistoryHomework(page,pageSize);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeworkHistoryResponse,
          labelId: "",
          list.toJson());
    }

    if (list.obj == null || list.obj!.records==null || list.obj!.records!.isEmpty) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.obj!.records!;
      } else {
        state.list.addAll(list.obj!.records!);
      }
      if (list.obj!.records!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getHistoryHomeworkList]);
  }


  //TODO 缓存key需要处理
  void getHistoryListActionPage(int actionPage,int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    // var cache = await JsonCacheManageUtils.getCacheData(
    //     JsonCacheManageUtils.HomeworkHistoryResponse).then((value){
    //   if(value!=null){
    //     return HomeworkHistoryResponse.fromJson(value as Map<String,dynamic>?);
    //   }
    // });
    //
    // state.pageNo = page;
    // if(page==1 && cache is HomeworkHistoryResponse && cache.obj!=null && cache.obj!.records!=null) {
    //   state.list = cache.obj!.records!;
    //   if(state.list.length < pageSize){
    //     state.hasMore = false;
    //   } else {
    //     state.hasMore = true;
    //   }
    //   update([GetBuilderIds.getHistoryHomeworkList]);
    // }


    HomeworkHistoryResponse list = await homeworkRepository.getHistoryHomeworkActionPage(actionPage,page,pageSize);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeworkHistoryResponse,
          labelId: "",
          list.toJson());
    }

    if (list.obj == null || list.obj!.records==null || list.obj!.records!.isEmpty) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.obj!.records!;
      } else {
        state.list.addAll(list.obj!.records!);
      }
      if (list.obj!.records!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getHistoryHomeworkList]);
  }
}
