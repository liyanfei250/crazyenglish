import 'package:get/get.dart';

import '../../entity/paper_category.dart';
import '../../repository/week_repository.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'reading_catalog_state.dart';

class Reading_catalogLogic extends GetxController {
  final Reading_catalogState state = Reading_catalogState();

  WeekRepository weekRepository = WeekRepository();

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
        JsonCacheManageUtils.PaperCategory,labelId: periodicaId.toString()).then((value){
      if(value!=null){
        return PaperCategory.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is PaperCategory) {
      state.paperCategory = cache!;
      update([GetBuilderIds.paperCategory]);
    }
    PaperCategory list = await weekRepository.getWeekPaperCategory(periodicaId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PaperCategory,
        labelId: periodicaId,
        list.toJson());
    state.paperCategory = list!;
    update([GetBuilderIds.paperCategory]);
  }
}
