import 'package:crazyenglish/pages/mine/ClassRepository.dart';
import 'package:get/get.dart';

import '../../../../entity/student_ranking_response.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import 'student_ranking_state.dart';

class Student_rankingLogic extends GetxController {
  final Student_rankingState state = Student_rankingState();
  ClassRepository classRepository = ClassRepository();

  void getStudentRanking(String id) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.StudentRanking,
        labelId: id)
        .then((value) {
      if (value != null) {
        return StudentRankingResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is StudentRankingResponse) {
      state.myRanking = cache!;
      hasCache = true;
      update([GetBuilderIds.getStudentRanking + id]);
    }
    StudentRankingResponse list = await classRepository.getStudentRanking(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.StudentRanking, list.toJson(),
        labelId: id);
    state.myRanking = list!;
    if (!hasCache) {
      update([GetBuilderIds.getStudentRanking + id]);
    }
  }

}
