import 'dart:io';

import 'package:crazyenglish/api/api.dart';
import 'package:crazyenglish/entity/homework_detail_response.dart';
import 'package:crazyenglish/net/net_manager.dart';
import 'package:crazyenglish/repository/home_work_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../entity/test_paper_look_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../mine/ClassRepository.dart';
import 'preview_exam_paper_state.dart';
import 'package:crazyenglish/base/common.dart' as common;

class PreviewExamPaperLogic extends GetxController {
  final PreviewExamPaperState state = PreviewExamPaperState();
  ClassRepository classRepository = ClassRepository();
  HomeworkRepository homework = HomeworkRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getPreviewQuestionList(int paperType, int paperId) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.TeacherTestPagerLook,
            labelId: "$paperType$paperId")
        .then((value) {
      if (value != null) {
        return TestPaperLookResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    if (cache is TestPaperLookResponse && cache.obj != null) {
      state.list = cache.obj!;
      update([(GetBuilderIds.getExamper)]);
    }
    Map<String, dynamic> req = Map();
    if (paperType == common.PaperType.exam) {
      req = {"paperType": paperType, "paperId": paperId};
    } else {
      req = {"paperType": paperType, "historyOperationId": paperId};
    }
    TestPaperLookResponse list = await classRepository.toPreviewOperation(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.TeacherTestPagerLook, list.toJson(),
        labelId: "$paperType$paperId");
    if (list.obj == null) {
      state.list.clear();
    } else {
      state.list = list.obj!;
    }
    update([(GetBuilderIds.getExamper)]);
  }

  void getPreviewQuestionForCorrectList(int operationId, int operationStudentId,bool isSubjectivity,num studentUserId) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.TeacherTestPagerCorrectLoog,
        labelId: "$operationStudentId")
        .then((value) {
      if (value != null) {
        return TestPaperLookResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    if (cache is TestPaperLookResponse && cache.obj != null) {
      state.list = cache.obj!;
      update([(GetBuilderIds.getExamper)]);
    }
    Map<String, dynamic> req = Map();
    req = {
      "operationId": operationId,
      "operationStudentId": operationStudentId,
      "isSubjectivity":isSubjectivity,
      "studentUserId":studentUserId,
    };
    TestPaperLookResponse list = await classRepository.toPreviewOperationForCorrect(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.TeacherTestPagerCorrectLoog, list.toJson(),
        labelId: "$operationStudentId");
    if (list.obj == null) {
      state.list.clear();
    } else {
      state.list = list.obj!;
    }
    update([(GetBuilderIds.getExamper)]);
  }


  void getPreviewOperation(int paperId) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.TeacherTestPagerLook,
            labelId: "$paperId")
        .then((value) {
      if (value != null) {
        return TestPaperLookResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    if (cache is TestPaperLookResponse && cache.obj != null) {
      state.list = cache.obj!;
      update([(GetBuilderIds.getExamper)]);
    }
    TestPaperLookResponse list =
        await classRepository.getPreviewOperation(paperId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.TeacherTestPagerLook, list.toJson(),
        labelId: "$paperId");
    if (list.obj == null) {
      state.list.clear();
    } else {
      state.list = list.obj!;
    }
    update([(GetBuilderIds.getExamper)]);
  }
}
