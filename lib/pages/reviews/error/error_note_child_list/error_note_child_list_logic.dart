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

  void getList(
      int userId, int isCorrect, int classify, int current, int size) async {
    //isCorrect是否订正 0 否 1 是
    //classify 题型value

    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["userId"] = userId;
    req["isCorrect"] = isCorrect;
    req["classify"] = classify;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.ErrorNoteResponse,labelId: isCorrect.toString()+classify.toString())
        .then((value) {
      if (value != null) {
        return ErrorNoteTabDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 && cache is ErrorNoteTabDate && cache.obj != null) {
      state.list = cache.obj!;
      if (state.list.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([
        GetBuilderIds.errorNoteTestList +
            isCorrect.toString() +
            classify.toString()
      ]);
    }
    ErrorNoteTabDate list =
        await errorNoteResponse.getErrorNoteTabDate(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.ErrorNoteResponse, list.toJson(),labelId: isCorrect.toString()+classify.toString());
    }
    if (list.obj == null) {
      if (current == 1) {
        state.list.clear();
      }
    } else {
      if (current == 1) {
        state.list = list.obj!;
      } else {
        state.list.addAll(list.obj!);
      }
      if (list.obj!.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([
      GetBuilderIds.errorNoteTestList +
          isCorrect.toString() +
          classify.toString()
    ]);
  }

  void getWeekTestDetail(String id) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.ErrorNoteDetailResponse,
            labelId: id.toString())
        .then((value) {
      if (value != null) {
        return weekDetail.WeekDetailResponse.fromJson(
            value as Map<String, dynamic>?);
      }
    });

    if (cache is WeekDetailResponse) {
      state.weekDetailResponse = cache!;
      update([GetBuilderIds.errorDetailList]);
    }
    weekDetail.WeekDetailResponse list =
        await errorNoteResponse.getErrorNoteDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.ErrorNoteDetailResponse,
        labelId: id,
        list.toJson());
    state.weekDetailResponse = list!;
    update([GetBuilderIds.errorDetailList]);
  }
}
