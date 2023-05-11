import 'package:get/get.dart';

import '../../../entity/student_time_statistics.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../mine/ClassRepository.dart';
import 'learning_report_state.dart';

class Learning_reportLogic extends GetxController {
  final Learning_reportState state = Learning_reportState();
  ClassRepository netTool = ClassRepository();

  void getStudentReport(String studentId, num start, num end) async {
    Map<String, dynamic> req = {};
    req['studentUserId'] = studentId;
    req['start'] = start;
    req['end'] = end;
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.StudentDetailReport,
        labelId: studentId)
        .then((value) {
      if (value != null) {
        return StudentTimeStatistics.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is StudentTimeStatistics) {
      state.studentReport = cache!;
      hasCache = true;
      update([GetBuilderIds.getStudentDetailReport + studentId]);
    }
    StudentTimeStatistics list = await netTool.getStudentReport(req);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.StudentDetailReport, list.toJson(),
        labelId: studentId);
    state.studentReport = list!;
    if (!hasCache) {
      update([GetBuilderIds.getStudentDetailReport + studentId]);
    }
  }
}
