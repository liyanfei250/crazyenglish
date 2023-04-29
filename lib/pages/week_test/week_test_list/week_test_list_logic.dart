import 'dart:convert';

import 'package:crazyenglish/entity/week_list_response.dart';
import 'package:get/get.dart';

import '../../../entity/home/HomeKingDate.dart';
import '../../../entity/review/HomeWeeklyChoiceDate.dart';
import '../../../repository/week_test_repository.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'week_test_list_state.dart';

class WeekTestListLogic extends GetxController {
  final WeekTestListState state = WeekTestListState();

  final WeekTestRepository weekTestListResponse = WeekTestRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getList(dynamic affiliatedGrade, int page, int pageSize) async {
    String jsonStr =
        '{ "affiliatedGrade": $affiliatedGrade, "p": { "size":$pageSize, "current": $page } }';
    Map<String, dynamic> req = jsonDecode(jsonStr);
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.WeekListRespose,
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
      update([GetBuilderIds.weekTestList + affiliatedGrade.toString()]);
    }
    WeekListResponse list = await weekTestListResponse.getWeekTestList(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.WeekTestListResponse,
          labelId: affiliatedGrade.toString(),
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
    update([GetBuilderIds.weekTestList + affiliatedGrade.toString()]);
  }

  void getChoiceMap(String id) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeWeeklyListChoiceDate,
            labelId: id.toString())
        .then((value) {
      if (value != null) {
        return HomeKingDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingDate) {
      state.paperDetailNew = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeWeeklyChoiceDate]);
    }
    HomeKingDate list = await weekTestListResponse.getHomeWeeklyChoiceDate(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeWeeklyListChoiceDate,
        labelId: id,
        list.toJson());
    state.paperDetailNew = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeWeeklyChoiceDate]);
    }
  }
}
