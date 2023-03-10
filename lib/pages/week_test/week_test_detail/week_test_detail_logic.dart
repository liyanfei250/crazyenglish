import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../../entity/week_detail_response.dart';
import '../../../entity/week_test_detail_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
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
        JsonCacheManageUtils.WeekDetailResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return WeekDetailResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekTestDetailResponse) {
      state.weekTestDetailResponse = cache!;
      state.uuid = id;
      update([GetBuilderIds.weekTestDetailList]);
    }
    WeekDetailResponse list = await weekTestRepository.getWeekTestDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekDetailResponse,
        labelId: id,
        list.toJson());
    state.weekTestDetailResponse = list!;
    state.uuid = id;
    update([GetBuilderIds.weekTestDetailList]);
  }
}
