import 'package:get/get.dart';

import '../../base/common.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/teacher_week_list_response.dart';
import '../../entity/week_list_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../../utils/sp_util.dart';
import '../index/HomeViewRepository.dart';
import 'teacher_index_state.dart';

class TeacherIndexLogic extends GetxController {
  final TeacherIndexState state = TeacherIndexState();
  HomeViewRepository homeViewRepository = HomeViewRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHomeListNew(String type) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeKingListNewTeacher)
        .then((value) {
      if (value != null) {
        return HomeKingNewDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingNewDate) {
      state.paperDetailNew = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeDateListTeacher]);
    }

    HomeKingNewDate list = await homeViewRepository.getHomeKingListNew(type);

    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeKingListNewTeacher, list.toJson());
    state.paperDetailNew = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateListTeacher]);
    }
  }

//获取首页我的已购期刊
  void getMyJournalList(String userId, int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> p = {};
    p['current'] = current;
    p['size'] = size;
    req['userId'] = userId;
    req['p'] = p;
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeMyJournalDateTeacher)
        .then((value) {
      if (value != null) {
        return TeacherWeekListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is TeacherWeekListResponse) {
      state.myJournalDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeMyJournalDateTeacher]);
    }
    TeacherWeekListResponse list =
        await homeViewRepository.getMyJournalListTeacher(
            req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyJournalDateTeacher, list.toJson());
    state.myJournalDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeMyJournalDateTeacher]);
    }
  }

  void getMyRecommendation(String userId, int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> p = {};
    p['current'] = current;
    p['size'] = size;
    req['userId'] = userId;
    req['p'] = p;
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeMyRecommendation)
        .then((value) {
      if (value != null) {
        return TeacherWeekListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is TeacherWeekListResponse) {
      state.recommendJournal = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeMyRecommendation]);
    }
    TeacherWeekListResponse list =
        await homeViewRepository.getMyRecommendationTeacher(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyRecommendation, list.toJson());
    state.recommendJournal = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeMyRecommendation]);
    }
  }
}
