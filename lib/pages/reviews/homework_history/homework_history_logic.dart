import 'package:crazyenglish/entity/home/PractiseDate.dart';
import 'package:crazyenglish/pages/reviews/repository/ReviewRepository.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/json_cache_util.dart';
import 'package:get/get.dart';

import 'homework_history_state.dart';

class HomeworkHistoryLogic extends GetxController {
  final HomeworkHistoryState state = HomeworkHistoryState();
  ReviewRepository recordData = ReviewRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getPracticeDateInfo(String id, String date) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeworkHistoryDate,
        labelId: id.toString())
        .then((value) {
      if (value != null) {
        return PractiseDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is PractiseDate) {
      state.dateDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.HomeworkHistoryDate]);
    }
    PractiseDate list = await recordData.getPracticeDateList(id, date);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeworkHistoryDate, labelId: id, list.toJson());
    state.dateDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.HomeworkHistoryDate]);
    }
  }
}
