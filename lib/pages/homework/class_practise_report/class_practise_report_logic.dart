import 'package:crazyenglish/entity/report_response.dart';
import 'package:crazyenglish/pages/mine/ClassRepository.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/json_cache_util.dart';
import 'package:get/get.dart';

import 'class_practise_report_state.dart';

class ClassPractiseReportLogic extends GetxController {
  final ClassPractiseReportState state = ClassPractiseReportState();
  ClassRepository classRepository = ClassRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getReportResponseList(String operationClassId) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.TeacherGetRerport,
            labelId: "$operationClassId")
        .then((value) {
      if (value != null) {
        return ReportResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    if (cache is ReportResponse && cache.obj != null) {
      state.listTop = cache.obj!.topThree!;
      state.listBottom = cache.obj!.notSubmit!;
      update([(GetBuilderIds.getTeacherGetRerport)]);
    }
    ReportResponse list =
        await classRepository.getReportResponse(operationClassId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.TeacherGetRerport, list.toJson(),
        labelId: "$operationClassId");
    if (list.obj == null && list.obj!.topThree == null) {
      state.listTop.clear();
    } else {
      state.listTop = list.obj!.topThree!;
    }

    if (list.obj == null && list.obj!.notSubmit == null) {
      state.listBottom.clear();
    } else {
      state.listBottom = list.obj!.notSubmit!;
    }
    update([(GetBuilderIds.getTeacherGetRerport)]);
  }
}
