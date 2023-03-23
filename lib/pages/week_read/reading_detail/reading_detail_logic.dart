import 'package:get/get.dart';

import '../../../entity/paper_detail.dart';
import '../../../repository/week_repository.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'reading_detail_state.dart';

class Reading_detailLogic extends GetxController {
  final Reading_detailState state = Reading_detailState();


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

  void getPagerDetail(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.PaperDetail,labelId: id.toString()).then((value){
      if(value!=null){
        return PaperDetail.fromJson(value as Map<String,dynamic>?);
      }
    });

    bool hasCache = false;
    if(cache is PaperDetail) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.paperDetail]);
    }
    PaperDetail list = await weekRepository.getWeekPaperDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PaperDetail,
        labelId: id,
        list.toJson());
    state.paperDetail = list!;
    if(!hasCache){
      update([GetBuilderIds.paperDetail]);
    }
  }
}
