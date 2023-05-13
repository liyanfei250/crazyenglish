import 'package:crazyenglish/repository/home_work_repository.dart';
import 'package:get/get.dart';

import '../../../utils/json_cache_util.dart';
import 'homework_complete_overview_state.dart';

class HomeworkCompleteOverviewLogic extends GetxController {
  final HomeworkCompleteOverviewState state = HomeworkCompleteOverviewState();
  HomeworkRepository homeworkRepository = HomeworkRepository();
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



  void getHomeworkDetailRespose(String paperType,String paperId) async{

    Map<String,String> req= {};
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

}
