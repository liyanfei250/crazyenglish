import 'package:crazyenglish/entity/test_paper_look_response.dart';
import 'package:crazyenglish/pages/mine/ClassRepository.dart';
import 'package:crazyenglish/repository/home_work_repository.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:get/get.dart';

import '../../../utils/json_cache_util.dart';
import 'homework_complete_overview_state.dart';
import 'package:crazyenglish/base/common.dart' as common;

class HomeworkCompleteOverviewLogic extends GetxController {
  final HomeworkCompleteOverviewState state = HomeworkCompleteOverviewState();
  HomeworkRepository homeworkRepository = HomeworkRepository();
  ClassRepository classRepository = ClassRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHomeworkDetailRespose(String paperType, String paperId) async {
    Map<String, String> req = {};
    // req["weekTime"] = weekTime;
    // var cache = await JsonCacheManageUtils.getCacheData(
    //     JsonCacheManageUtils.WeekDirectoryResponse,labelId: paperId+":"+paperType).then((value){
    //   if(value!=null){
    //     return WeekDirectoryResponse.fromJson(value as Map<String,dynamic>?);
    //   }
    // });
    //
    // if(cache is WeekDirectoryResponse) {
    //   state.weekDirectoryResponse = cache!;
    //   state.nodes = process(state.weekDirectoryResponse);
    //   update([GetBuilderIds.weekTestCatalogList]);
    // }
    // WeekDirectoryResponse list = await weekTestRepository.getWeekTestCategory(periodicaId);
    // JsonCacheManageUtils.saveCacheData(
    //     JsonCacheManageUtils.WeekDirectoryResponse,
    //     labelId: periodicaId,
    //     list.toJson());
    // state.weekDirectoryResponse = list!;
    // state.nodes = process(state.weekDirectoryResponse);
    // update([GetBuilderIds.weekTestCatalogList]);
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
