import 'package:crazyenglish/entity/history_homework_date.dart';
import 'package:crazyenglish/entity/home/PractiseDate.dart';
import 'package:crazyenglish/repository/ReviewRepository.dart';
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
    PractiseDate list = await recordData.getHistHomeWorkDateList(date);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeworkHistoryDate, labelId: id, list.toJson());
    state.dateDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.HomeworkHistoryDate]);
    }
  }

  void getRecordInfo(String date, int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["dateDay"] = date;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HistoryHomeworkInfoResponse,
            labelId: date.toString())
        .then((value) {
      if (value != null) {
        return HistoryHomeworkDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 &&
        cache is HistoryHomeworkDate &&
        cache.obj != null &&
        cache.obj!.records != null) {
      state.list = cache.obj!.records!;
      if (state.list.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.HistoryHomeworkInfoResponse + date.toString()]);
    }
    HistoryHomeworkDate list = await recordData.getHistHomeWorkRecordList(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HistoryHomeworkInfoResponse,
          labelId: date.toString(),
          list.toJson());
    }
    if (list.obj == null) {
      if (current == 1) {
        state.list.clear();
      }
    } else {
      if (current == 1) {
        state.list = list.obj!.records!;
      } else {
        state.list.clear();
        state.list.addAll(list.obj!.records!);
      }
      if (list.obj!.records!.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.HistoryHomeworkInfoResponse + date.toString()]);
  }
}
