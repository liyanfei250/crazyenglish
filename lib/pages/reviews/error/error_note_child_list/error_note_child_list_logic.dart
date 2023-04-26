import 'dart:convert';

import 'package:get/get.dart';

import '../../../../entity/error_note_response.dart';
import '../../../../entity/review/ErrorNoteTabDate.dart';
import '../../../../entity/week_detail_response.dart' as weekDetail;
import '../../../../entity/week_detail_response.dart';
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

    final jsonStr = '{"userId": 1, "isCorrect": 1, "classify": 1646439861824098307}';
    final jsonMap = json.decode(jsonStr);

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.ErrorNoteResponse)
        .then((value) {
      if (value != null) {
        return ErrorNoteTabDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is ErrorNoteTabDate && cache.obj!= null) {
      state.list = cache.obj!;
      if (state.list.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.errorNoteTestList + "$correction" + "$type"]);
    }
    ErrorNoteTabDate list = await errorNoteResponse.getErrorNoteTabDate(jsonMap);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.ErrorNoteResponse, list.toJson());
    }
    if (list.obj == null) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.obj!;
      } else {
        state.list.addAll(list.obj!);
      }
      if (list.obj!.length < pageSize) {
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

    if(cache is WeekDetailResponse) {
      state.weekDetailResponse = cache!;
      update([GetBuilderIds.errorDetailList]);
    }
    weekDetail.WeekDetailResponse list = await errorNoteResponse.getErrorNoteDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.ErrorNoteDetailResponse,
        labelId: id,
        list.toJson());
    state.weekDetailResponse = list!;
    update([GetBuilderIds.errorDetailList]);
  }
}
