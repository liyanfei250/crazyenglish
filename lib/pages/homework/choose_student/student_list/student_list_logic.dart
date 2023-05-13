import 'package:crazyenglish/entity/HomeworkStudentResponse.dart';
import 'package:get/get.dart';

import '../../../../entity/member_student_list.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import '../../../mine/ClassRepository.dart';
import 'student_list_state.dart';

class StudentListLogic extends GetxController {
  final StudentListState state = StudentListState();
  ClassRepository classRepository = ClassRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getStudentList(String classId) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.StudentChoiceList,
        labelId: classId)
        .then((value) {
      if (value != null) {
        return MemberStudentList.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is MemberStudentList) {
      state.myStudentList = cache!.obj!;
      hasCache = true;
      update([GetBuilderIds.getStudentChoiceList + classId]);
    }
    MemberStudentList list = await classRepository.getClassStudentList(classId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.StudentChoiceList, list.toJson(),
        labelId: classId);
    state.myStudentList = list!.obj!;
    if (!hasCache) {
      update([GetBuilderIds.getStudentChoiceList + classId]);
    }
  }
}
