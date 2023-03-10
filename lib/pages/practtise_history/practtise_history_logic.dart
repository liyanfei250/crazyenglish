import 'package:get/get.dart';

import '../../entity/practice_list_response.dart';
import '../../entity/week_detail_response.dart';
import '../../entity/week_test_detail_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../error/error_note_child_list/ErrorNoteRepository.dart';
import 'practtise_history_state.dart';

class Practtise_historyLogic extends GetxController {
  final Practtise_historyState state = Practtise_historyState();

  ErrorNoteRepository resposi = ErrorNoteRepository();

  void getPracCords(page, pageSize) async {
    PracticeListResponse sendCodeResponse =
        await resposi.getPracticerecords(page, pageSize);
    if (sendCodeResponse.data != null && sendCodeResponse.data!.rows != null) {
      state.list = sendCodeResponse.data!.rows!;
    }
    if (sendCodeResponse.data != null &&
        sendCodeResponse.data!.exercisesTotal != null) {
      state.totalNum = int.parse(sendCodeResponse.data!.exercisesTotal!);
    }
    state.pageNo = page;
    update([GetBuilderIds.getPracticeList]);
  }

  void getPracCordsDetail(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.PracticeListDetailResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return WeekDetailResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekTestDetailResponse) {
      state.weekTestDetailResponse = cache!;
      update([GetBuilderIds.getPracticeListDetail]);
    }
    WeekDetailResponse list = await resposi.getPracticerecordsDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PracticeListDetailResponse,
        labelId: id,
        list.toJson());
    state.weekTestDetailResponse = list!;
    update([GetBuilderIds.getPracticeListDetail]);
  }
}
