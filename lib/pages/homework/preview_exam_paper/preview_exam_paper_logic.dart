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
}
