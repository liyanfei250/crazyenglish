import 'package:crazyenglish/entity/class_list_response.dart';
import 'package:crazyenglish/pages/mine/ClassRepository.dart';
import 'package:get/get.dart';

import '../../../entity/HomeworkHistoryResponse.dart';
import '../../../repository/home_work_repository.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'choose_history_homework_state.dart';

class ChooseHistoryHomeworkLogic extends GetxController {
  final ChooseHistoryHomeworkState state = ChooseHistoryHomeworkState();
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

  void getHistoryListActionPage(dynamic schoolClassId, int teacherId,
      int actionPage, int page, int pageSize) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeworkHistoryResponse,labelId: schoolClassId.toString()+actionPage.toString())
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
      update([GetBuilderIds.getHistoryHomeworkList]);
    }

    HomeworkHistoryResponse list =
        await homeworkRepository.getHistoryHomeworkActionPage(
            schoolClassId, teacherId, actionPage, page, pageSize);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeworkHistoryResponse,
          labelId: schoolClassId.toString()+actionPage.toString(),
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
    update([GetBuilderIds.getHistoryHomeworkList]);
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
