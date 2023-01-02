import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../entity/week_test_catalog_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'week_test_catalog_state.dart';

class WeekTestCatalogLogic extends GetxController {
  final WeekTestCatalogState state = WeekTestCatalogState();

  final WeekTestRepository weekTestRepository = WeekTestRepository();
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


  void getPagerCategory(String periodicaId) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekTestCatalogResponse,labelId: periodicaId.toString()).then((value){
      if(value!=null){
        return WeekTestCatalogResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekTestCatalogResponse) {
      state.weekTestCatalogResponse = cache!;
      update([GetBuilderIds.weekTestCatalogList]);
    }
    WeekTestCatalogResponse list = await weekTestRepository.getWeekPaperCategory(periodicaId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekTestCatalogResponse,
        labelId: periodicaId,
        list.toJson());
    state.weekTestCatalogResponse = list!;
    update([GetBuilderIds.weekTestCatalogList]);
  }
}
