import 'package:get/get.dart';

import '../../../entity/home/PractiseDate.dart';
import '../../../entity/review/PractiseHistoryDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../repository/ReviewRepository.dart';
import 'practise_history_state.dart';

class Practise_historyLogic extends GetxController {
  final Practise_historyState state = Practise_historyState();
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
            JsonCacheManageUtils.PracticeDate,
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
      update([GetBuilderIds.PracticeDate]);
    }
    PractiseDate list = await recordData.getPracticeDateList(id, date);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PracticeDate, labelId: id, list.toJson());
    state.dateDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.PracticeDate]);
    }
  }

  // void getRecordInfo(String userId, String date, int size, int current) async {
  //   Map<String, dynamic> req = {};
  //   Map<String, dynamic> reqTwo = {};
  //   req["userId"] = userId;
  //   req["date"] = date;
  //   reqTwo["size"] = size;
  //   reqTwo["current"] = current;
  //   req["p"] = reqTwo;
  //   var cache = await JsonCacheManageUtils.getCacheData(
  //           JsonCacheManageUtils.PracRecordInfoResponse,
  //           labelId: date.toString())
  //       .then((value) {
  //     if (value != null) {
  //       return PractiseHistoryDate.fromJson(value as Map<String, dynamic>?);
  //     }
  //   });
  //
  //   bool hasCache = false;
  //   if (cache is PractiseHistoryDate) {
  //     state.paperDetail = cache!;
  //     hasCache = true;
  //     update([GetBuilderIds.getPracticeRecordList + date.toString()]);
  //   }
  //   PractiseHistoryDate list = await recordData.getPracticeRecordList(req);
  //   JsonCacheManageUtils.saveCacheData(
  //       JsonCacheManageUtils.PracRecordInfoResponse,
  //       labelId: date.toString(),
  //       list.toJson());
  //   state.paperDetail = list!;
  //   if (!hasCache) {
  //     update([GetBuilderIds.getPracticeRecordList + date.toString()]);
  //   }
  // }


  void getRecordInfo(String userId, String date, int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["userId"] = userId;
    req["date"] = date;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.PracRecordInfoResponse,
        labelId: date.toString())
        .then((value) {
      if (value != null) {
        return PractiseHistoryDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 && cache is PractiseHistoryDate && cache.obj != null) {
      state.list = cache.obj!;
      if (state.list.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getPracticeRecordList + date.toString()]);
    }
    PractiseHistoryDate list = await recordData.getPracticeRecordList(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.PracRecordInfoResponse,
          labelId: date.toString(),
          list.toJson());
    }
    if (list.obj == null) {
      if (current == 1) {
        state.list.clear();
      }
    } else {
      if (current == 1) {
        state.list = list.obj!;
      } else {
        state.list.addAll(list.obj!);
      }
      if (list.obj!.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getPracticeRecordList + date.toString()]);
  }
}
