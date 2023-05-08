import 'package:get/get.dart';

import '../../base/common.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyJournalListDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
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

  void getMyJournalList() async {

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeMyJournalDateTeacher)
        .then((value) {
      if (value != null) {
        return HomeMyJournalListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeMyJournalListDate) {
      state.myJournalDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeMyJournalDateTeacher]);
    }
    HomeMyJournalListDate list = await homeViewRepository.getMyJournalListTeacher(SpUtil.getInt(BaseConstant.USER_ID).toString());
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyJournalDateTeacher, list.toJson());
    state.myJournalDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeMyJournalDateTeacher]);
    }
  }

  void getMyRecommendation() async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeMyRecommendation)
        .then((value) {
      if (value != null) {
        return HomeMyJournalListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeMyJournalListDate) {
      state.myTask = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeMyRecommendation]);
    }
    HomeMyJournalListDate list = await homeViewRepository.getMyRecommendationTeacher('');
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyRecommendation, list.toJson());
    state.myTask = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeMyRecommendation]);
    }
  }
}
