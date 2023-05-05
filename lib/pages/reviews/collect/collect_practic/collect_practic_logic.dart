import 'package:get/get.dart';

import '../../../../entity/home/HomeKingDate.dart';
import '../../../../entity/home/SearchCollectListDetail.dart';
import '../../../../entity/review/CollectDate.dart';
import '../../../../entity/review/SearchCollectListDate.dart' as listdate;
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import '../../repository/ReviewRepository.dart';
import 'collect_practic_state.dart';

class Collect_practicLogic extends GetxController {
  final Collect_practicState state = Collect_practicState();
  ReviewRepository recordData = ReviewRepository();
  Map<String,bool> collectMap = {};

  //搜索筛选
  void getHomeList(String type) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeListDate)
        .then((value) {
      if (value != null) {
        return HomeKingDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingDate) {
      state.tabList = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeDateList]);
    }
    HomeKingDate list = await recordData.getHomeKingList(type);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListDate, list.toJson());
    state.tabList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateList]);
    }
  }


  void getCollectList(int userId, bool isRecentView, dynamic classify, int size,
      int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["userId"] = userId;
    req["isRecentView"] = isRecentView;
    req["classify"] = classify;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.SearchCollectListDate,
            labelId: isRecentView.toString() + classify.toString())
        .then((value) {
      if (value != null) {
        return listdate.SearchCollectListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 && cache?.obj != null&& cache!.obj is listdate.Obj ) {
      state.paperList = cache.obj!;
      if(state.paperList!.length < size){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getCollectListDate + isRecentView.toString() + classify.toString()]);
    }

    listdate.SearchCollectListDate list = await recordData.getCollectList(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.SearchCollectListDate,
          labelId: isRecentView.toString() + classify.toString(),
          list.toJson());
    }
    if(list.obj==null) {
      if(current ==1){
        state.paperList!.clear();
      }
    } else {
      if(current ==1){
        state.paperList = list.obj!;
      } else {
        state.paperList.addAll(list.obj!);
      }
      if(list.obj!.length < size){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }

    update([GetBuilderIds.getCollectListDate  + isRecentView.toString() + classify.toString()]);
  }

  void toCollect(num subjectId,{num? subtopicId=-1}) async {
    CollectDate collectResponse = await recordData.toCollect(subjectId.toString());
    state.collectDate = collectResponse;
    if(subjectId>0){
      if(subtopicId!=null && subtopicId>0){
        CollectDate collectResponse = await recordData.toCollect(subjectId.toString(),subtopicId: subtopicId);
        collectMap["${subjectId}:${subtopicId}"] = collectResponse.obj!.isCollect??false;
        update(["${GetBuilderIds.collectState}:${subjectId}:${subtopicId}"]);
      } else {
        CollectDate collectResponse = await recordData.toCollect(subjectId.toString());
        collectMap["${subjectId}"] = collectResponse.obj!.isCollect??false;
        update(["${GetBuilderIds.collectState}:${subjectId}"]);
      }
    } else {
      print("subjectId 有误");
    }
    update([GetBuilderIds.toCollectDate]);

  }

  // subtopicId为可选项
  void queryCollectState(num subjectId,{num? subtopicId=-1}) async{
    if(subjectId>0){
      if(subtopicId!=null && subtopicId>0){
        CollectDate collectResponse = await recordData.queryCollect(subjectId.toString(),subtopicId: subtopicId);
        collectMap["${subjectId}:${subtopicId}"] = collectResponse.obj!.isCollect??false;
        update(["${GetBuilderIds.collectState}:${subjectId}:${subtopicId}"]);
      }else{
        CollectDate collectResponse = await recordData.queryCollect(subjectId.toString());
        collectMap["${subjectId}"] = collectResponse.obj!.isCollect??false;
        update(["${GetBuilderIds.collectState}:${subjectId}"]);
      }
    }else{
      print("subjectId 有误");
    }
  }

}
