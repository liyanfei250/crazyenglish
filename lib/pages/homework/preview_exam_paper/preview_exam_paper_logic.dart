import 'package:get/get.dart';

import '../../../entity/test_paper_look_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../mine/ClassRepository.dart';
import 'preview_exam_paper_state.dart';

class PreviewExamPaperLogic extends GetxController {
  final PreviewExamPaperState state = PreviewExamPaperState();
  ClassRepository classRepository =ClassRepository();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getPreviewQuestionList(int paperType,int paperId) async{

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.TeacherTestPagerLook,labelId: "$paperType$paperId").then((value){
      if(value!=null){
        return TestPaperLookResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if (cache is TestPaperLookResponse && cache.obj != null) {
      state.list = cache.obj!;
      update([(GetBuilderIds.getExamper)]);
    }
    TestPaperLookResponse list = await classRepository.toPreviewOperation({"paperType":paperType,"historyOperationId":paperId});
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.TeacherTestPagerLook,
        list.toJson(),
      labelId: "$paperType$paperId"
    );
    if (list.obj == null) {
        state.list.clear();
    } else {
        state.list = list.obj!;
    }
    update([(GetBuilderIds.getExamper)]);
  }
}
