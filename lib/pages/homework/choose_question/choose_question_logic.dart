import 'package:get/get.dart';

import '../../../entity/home/HomeKingDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../reviews/repository/ReviewRepository.dart';
import 'choose_question_state.dart';

class ChooseQuestionLogic extends GetxController {
  final ChooseQuestionState state = ChooseQuestionState();
  ReviewRepository reviewRepository = ReviewRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
