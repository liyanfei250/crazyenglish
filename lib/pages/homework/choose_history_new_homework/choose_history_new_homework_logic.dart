import 'package:crazyenglish/entity/HomeworkHistoryResponse.dart';
import 'package:crazyenglish/entity/class_list_response.dart';
import 'package:crazyenglish/pages/mine/ClassRepository.dart';
import 'package:crazyenglish/repository/home_work_repository.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/json_cache_util.dart';
import 'package:get/get.dart';

import 'choose_history_new_homework_state.dart';

class Choose_history_new_homeworkLogic extends GetxController {
  final Choose_history_new_homeworkState state =
      Choose_history_new_homeworkState();
  HomeworkRepository homeworkRepository = HomeworkRepository();
  ClassRepository netTool = ClassRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHomeworkHistoryList(
      dynamic schoolClassId, int page, int pageSize, String endDate) async {
    Map<String, String> req = {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeworkHistoryResponse,
            labelId: endDate + schoolClassId.toString())
        .then((value) {
      if (value != null) {
        return HomeworkHistoryResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 &&
        cache is HomeworkHistoryResponse &&
        cache.obj != null &&
        cache.obj!.records != null) {
      state.list = cache.obj!.records!;
      if (state.list.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([
        GetBuilderIds.getHistoryHomeworkList +
            endDate +
            schoolClassId.toString()
      ]);
    }

    HomeworkHistoryResponse list = await homeworkRepository.getHistoryHomework(
        schoolClassId, page, pageSize, endDate);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeworkHistoryResponse,
          labelId: endDate + schoolClassId.toString(),
          list.toJson());
    }

    if (list.obj == null ||
        list.obj!.records == null ||
        list.obj!.records!.isEmpty) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.obj!.records!;
      } else {
        state.list.addAll(list.obj!.records!);
      }
      if (list.obj!.records!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([
      GetBuilderIds.getHistoryHomeworkList + endDate + schoolClassId.toString()
    ]);
  }

  //班级列表查询
  void getMyClassList(String teacherUserId) async {
    Map<String, String> req = {};
    req['teacherUserId'] = teacherUserId;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeClassTab,
            labelId: teacherUserId)
        .then((value) {
      if (value != null) {
        return ClassListResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is ClassListResponse) {
      state.myClassList = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeClassTab + teacherUserId]);
    }
    ClassListResponse list = await netTool.getMyClassList(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeClassTab, list.toJson(),
        labelId: teacherUserId);
    state.myClassList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeClassTab + teacherUserId]);
    }
  }
}
