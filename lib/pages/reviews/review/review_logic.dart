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
      hasCache = true;
      update([GetBuilderIds.getReviewHomeDate]);
    }
    ReviewHomeDetail list = await reviewRepository.getReviewHomeDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.ReviewHomeResponse,
        labelId: id,
        list.toJson());
    state.paperDetail = list!;
    if(!hasCache){
      update([GetBuilderIds.getReviewHomeDate]);
    }
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
}
