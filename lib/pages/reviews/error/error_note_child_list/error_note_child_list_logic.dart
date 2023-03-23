import 'package:get/get.dart';

import '../../../../entity/error_note_response.dart';
import '../../../../entity/week_detail_response.dart' as weekDetail;
import '../../../../entity/week_test_detail_response.dart' as weekTestDetail;
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import 'ErrorNoteRepository.dart';
import 'error_note_child_list_state.dart';

class Error_note_child_listLogic extends GetxController {
  final Error_note_child_listState state = Error_note_child_listState();
  final ErrorNoteRepository errorNoteResponse = ErrorNoteRepository();

  void getList(int correction, int type, int page, int pageSize) async {
    Map<String, String> req = {};
    req["correction"] = "$correction";
    req["type"] = "$type";
    req["page"] = "$page";
    req["pageSize"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.ErrorNoteResponse)
        .then((value) {
      if (value != null) {
        return Data.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is Data && cache.rows != null) {
      state.list = cache.rows!;
      if (state.list.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.errorNoteTestList + "$correction" + "$type"]);
    }
    Data list = await errorNoteResponse.getErrorTestList(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.ErrorNoteResponse, list.toJson());
    }
    if (list.rows == null) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.rows!;
      } else {
        state.list.addAll(list.rows!);
      }
      if (list.rows!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.errorNoteTestList + "$correction" + "$type"]);
  }

  void getWeekTestDetail(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.ErrorNoteDetailResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return weekDetail.WeekDetailResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is weekTestDetail.WeekTestDetailResponse) {
      state.weekTestDetailResponse = cache!;
      update([GetBuilderIds.errorDetailList]);
    }
    weekDetail.WeekDetailResponse list = await errorNoteResponse.getErrorNoteDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.ErrorNoteDetailResponse,
        labelId: id,
        list.toJson());
    state.weekTestDetailResponse = list!;
    update([GetBuilderIds.errorDetailList]);
  }
}
