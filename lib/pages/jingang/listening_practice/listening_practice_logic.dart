import 'package:crazyenglish/pages/reviews/error/error_note_child_list/ErrorNoteRepository.dart';
import 'package:get/get.dart';

import '../../../entity/practice_list_response.dart';
import '../../../entity/review/HomeListChoiceDate.dart';
import '../../../entity/review/HomeSecondListDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'ListRepository.dart';
import 'listening_practice_state.dart';

class Listening_practiceLogic extends GetxController {
  final Listening_practiceState state = Listening_practiceState();
  ErrorNoteRepository resposi = ErrorNoteRepository();
  ListRepository listData = ListRepository();

  void getPracCords(page, pageSize) async {
    PracticeListResponse sendCodeResponse =
        await resposi.getPracticerecords(page, pageSize);
    state.practiceInfoResponse = sendCodeResponse;
    update([GetBuilderIds.getPracticeList]);
  }

  void getChoiceMap(String id) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeListChoiceDate,
        labelId: id.toString())
        .then((value) {
      if (value != null) {
        return HomeListChoiceDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeListChoiceDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
    HomeListChoiceDate list = await listData.getHomeListChoiceDate(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListChoiceDate, labelId: id, list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
  }

  void getList(String weekTime, int page, int pageSize) async {
    Map<String, String> req = {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.SecondListDate,
        labelId: weekTime.toString())
        .then((value) {
      if (value != null) {
        return HomeSecondListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is HomeSecondListDate && cache != null) {
      state.homeSecondListDate = cache!;
      //todo 具体的参数获取
      // if(state.homeSecondListDate.length < pageSize){
      //   state.hasMore = false;
      // } else {
      //   state.hasMore = true;
      // }
      update([GetBuilderIds.getHomeSecondListDate]);
    }

    HomeSecondListDate list = await listData.getListnerList(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.SecondListDate,
          labelId: weekTime.toString(),
          list.toJson());
    }
    //todo 具体的参数获取
    // if(list.rows==null) {
    //   if(page ==1){
    //     state.paperList.clear();
    //   }
    // } else {
    //   if(page ==1){
    //     state.paperList = list.rows!;
    //   } else {
    //     state.paperList.addAll(list.rows!);
    //   }
    //   if(list.rows!.length < pageSize){
    //     state.hasMore = false;
    //   } else {
    //     state.hasMore = true;
    //   }
    // }
    update([GetBuilderIds.getHomeSecondListDate]);
  }
}
