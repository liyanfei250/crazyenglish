import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/entity/home/banner.dart';
import 'package:crazyenglish/entity/teacher_week_list_response.dart';
import 'package:crazyenglish/repository/HomeViewRepository.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:get/get.dart';

import '../../entity/home/HomeKingDate.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/review/HomeListDate.dart';
import '../../entity/week_list_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'index_state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();
  HomeViewRepository homeViewRepository = HomeViewRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHomeListNew() async {
    String type = "0";
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeKingListNew,labelId: type)
        .then((value) {
      if (value != null) {
        return HomeKingNewDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingNewDate) {
      state.paperDetailNew = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeDateListNew]);
    }
    HomeKingNewDate list = await homeViewRepository.getHomeKingListNew(type);

    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeKingListNew,labelId:type, list.toJson());
    state.paperDetailNew = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateListNew]);
    }
  }
  void getHomeBanner() async {
    bool isTeacherLogin = SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN);
    int roleType = RoleType.student;
    if(isTeacherLogin){
      roleType = RoleType.teacher;
    }

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.Banner,labelId: roleType.toString())
        .then((value) {
      if (value != null) {
        return Banner.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingNewDate) {
      state.banner = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeBanner]);
    }
    Banner list = await homeViewRepository.getHomeBanner(roleType);

    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.Banner,labelId:roleType.toString(), list.toJson());
    state.banner = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeBanner]);
    }
  }

  void getMyRecommendation() async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> p = {};
    p['current'] = 1;
    p['size'] = 10;
    req['userId'] = SpUtil.getInt(BaseConstant.USER_ID);
    req['p'] = p;
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeMyJournalDate)
        .then((value) {
      if (value != null) {
        return TeacherWeekListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is TeacherWeekListResponse) {
      state.myJournalDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeMyJournalDate]);
    }
    TeacherWeekListResponse list =
    await homeViewRepository.getMyRecommendationTeacher(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyJournalDate, list.toJson());
    state.myJournalDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeMyJournalDate]);
    }
  }


  void getMyTasks() async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeMyTasks)
        .then((value) {
      if (value != null) {
        return HomeMyTasksDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeMyTasksDate) {
      state.myTask = cache!;
      hasCache = true;
      update([GetBuilderIds.getMyTasksDate]);
    }

    HomeMyTasksDate list = await homeViewRepository.getMyTask({"userId":SpUtil.getInt(BaseConstant.USER_ID)});
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeMyTasks, list.toJson());
    state.myTask = list!;
    if (!hasCache) {
      update([GetBuilderIds.getMyTasksDate]);
    }
  }
}
