import 'package:get/get.dart';

import '../../../entity/home/HomeKingDate.dart';
import '../../../entity/paper_detail.dart';
import '../../../entity/review/ReviewHomeDetail.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../repository/ReviewRepository.dart';
import 'review_state.dart';

class ReviewLogic extends GetxController {
  final ReviewState state = ReviewState();
  ReviewRepository reviewRepository = ReviewRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHomePagerInfo(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.ReviewHomeResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return ReviewHomeDetail.fromJson(value as Map<String,dynamic>?);
      }
    });

    bool hasCache = false;
    if(cache is ReviewHomeDetail) {
      state.paperDetail = cache!;
      resetOtherCount(state.paperDetail);
      hasCache = true;

    }
    ReviewHomeDetail list = await reviewRepository.getReviewHomeDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.ReviewHomeResponse,
        labelId: id,
        list.toJson());
    state.paperDetail = list!;
    resetOtherCount(state.paperDetail);
  }

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
    HomeKingDate list = await reviewRepository.getHomeKingList(type);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListDate, list.toJson());
    state.tabList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateList]);
    }
  }

  void resetOtherCount(ReviewHomeDetail paperDetail){
    if (paperDetail!.obj != null) {
      if (paperDetail!.obj!.cumulativeExercise != null) {
          state.cumulativeExercise =
              paperDetail!.obj!.cumulativeExercise!.toInt();
      }else{
        state.cumulativeExercise = 0;
      }
      if (paperDetail!.obj!.todayExercise != null) {
          state.todayExercise = paperDetail!.obj!.todayExercise!.toInt();
      }else{
        state.todayExercise = 0;
      }
      if (paperDetail!.obj!.cumulativeError != null) {
          state.cumulativeError = paperDetail!.obj!.cumulativeError!.toInt();
      }else{
        state.cumulativeError = 0;
      }
      if (paperDetail!.obj!.crrect != null) {
          state.correct = paperDetail!.obj!.crrect!.toInt();
      }else{
        state.correct = 0;
      }
      if (paperDetail!.obj!.collected != null) {
          state.collected = paperDetail!.obj!.collected!.toInt();
      }else{
        state.collected = 0;
      }
      if (paperDetail!.obj!.historyJob != null) {
          state.histoty = paperDetail!.obj!.historyJob!.toInt();
      }else{
        state.histoty = 0;
      }
      if (paperDetail!.obj!.exerciseRecord != null) {
          state.practiceRecord = paperDetail!.obj!.exerciseRecord!.toInt();
      }else{
        state.practiceRecord = 0;
      }
    }else{
        state.cumulativeExercise = 0;
        state.todayExercise = 0;
        state.cumulativeError = 0;
        state.correct = 0;
        state.collected = 0;
        state.histoty = 0;
        state.practiceRecord = 0;
    }
    update([GetBuilderIds.getReviewHomeDate]);
  }
}
