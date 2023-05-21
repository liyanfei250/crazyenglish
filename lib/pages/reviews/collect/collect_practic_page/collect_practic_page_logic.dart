import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/entity/home/HomeKingDate.dart';
import 'package:crazyenglish/entity/review/CollectDate.dart';
import 'package:crazyenglish/pages/reviews/repository/ReviewRepository.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import '../../../../entity/review/SearchCollectListDate.dart' as listdate;
import 'package:crazyenglish/utils/json_cache_util.dart';
import 'package:get/get.dart';

import 'collect_practic_page_state.dart';

class Collect_practic_pageLogic extends GetxController {
  final Collect_practic_pageState state = Collect_practic_pageState();
  ReviewRepository recordData = ReviewRepository();


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
    if(subjectId>0){
      CollectDate collectResponse;
      if(subtopicId!=null && subtopicId>0){
        collectResponse = await recordData.toCollect(subjectId.toString(),subtopicId: subtopicId);
        state.collectMap["${subjectId}:${subtopicId}"] = collectResponse.obj!.isCollect??false;

        update(["${GetBuilderIds.collectState}:${subjectId}:${subtopicId}"]);
      } else {
        collectResponse = await recordData.toCollect(subjectId.toString());
        state.collectMap["${subjectId}"] = collectResponse.obj!.isCollect??false;
        update(["${GetBuilderIds.collectState}:${subjectId}"]);
      }
      if(collectResponse!=null){
        if(collectResponse.obj!.isCollect??false){
          Util.toast("收藏成功");
        }else{
          Util.toast("取消收藏");
        }
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
        state.collectMap["${subjectId}:${subtopicId}"] = collectResponse.obj!.isCollect??false;
        update(["${GetBuilderIds.collectState}:${subjectId}:${subtopicId}"]);
      }else{
        CollectDate collectResponse = await recordData.queryCollect(subjectId.toString());
        state.collectMap["${subjectId}"] = collectResponse.obj!.isCollect??false;
        update(["${GetBuilderIds.collectState}:${subjectId}"]);
      }
    }else{
      print("subjectId 有误");
    }
  }
}
