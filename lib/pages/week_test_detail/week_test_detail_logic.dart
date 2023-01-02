import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../entity/week_test_detail_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'week_test_detail_state.dart';

class WeekTestDetailLogic extends GetxController {
  final WeekTestDetailState state = WeekTestDetailState();

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


  void getWeekTestDetail(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekTestDetailResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return WeekTestDetailResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekTestDetailResponse) {
      state.weekTestDetailResponse = cache!;
      update([GetBuilderIds.weekTestDetailList]);
    }
    WeekTestDetailResponse list = await weekTestRepository.getWeekTestDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekTestDetailResponse,
        labelId: id,
        list.toJson());
    state.weekTestDetailResponse = list!;
    update([GetBuilderIds.weekTestDetailList]);
  }
}
