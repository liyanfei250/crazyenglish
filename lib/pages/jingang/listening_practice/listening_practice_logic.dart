import 'package:crazyenglish/pages/reviews/error/error_note_child_list/ErrorNoteRepository.dart';
import 'package:get/get.dart';

import '../../../entity/home/HomeKingDate.dart';
import '../../../entity/practice_list_response.dart';
import '../../../entity/review/HomeListChoiceDate.dart';
import '../../../entity/review/HomeSecondListDate.dart' as data;
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../../repository/other_repository.dart';
import 'listening_practice_state.dart';

class Listening_practiceLogic extends GetxController {
  final Listening_practiceState state = Listening_practiceState();
  ErrorNoteRepository resposi = ErrorNoteRepository();
  OtherRepository listData = OtherRepository();

  void getPracCords(page, pageSize) async {
    PracticeListResponse sendCodeResponse =
        await resposi.getPracticerecords(page, pageSize);
    state.practiceInfoResponse = sendCodeResponse;
    update([GetBuilderIds.getPracticeList]);
  }

  void getChoiceMap(String dictionaryType) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeListChoiceDate,
            labelId: dictionaryType.toString())
        .then((value) {
      if (value != null) {
        return HomeKingDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
    HomeKingDate list = await listData.getDictionaryDataByType(dictionaryType);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListChoiceDate, labelId: dictionaryType, list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
  }

  void getList(int userId, dynamic classifyTypeValue,dynamic affiliatedGrade,
      int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["userId"] = userId;
    req["dictionaryId"] = classifyTypeValue;
    req["affiliatedGrade"] = affiliatedGrade;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.SecondListDate,
            labelId: classifyTypeValue.toString())
        .then((value) {
      if (value != null) {
        return data.HomeSecondListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 && cache?.obj != null && cache!.obj is data.Obj) {
      state.homeSecondListDate = cache!.obj!;
      if (state.homeSecondListDate.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update(
          [GetBuilderIds.getHomeSecondListDate + classifyTypeValue.toString()]);
    }

    data.HomeSecondListDate list = await listData.getListnerList(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.SecondListDate,
          labelId: classifyTypeValue.toString(),
          list.toJson());
    }
    if (list.obj == null) {
      if (current == 1) {
        state.homeSecondListDate.clear();
      }
    } else {
      if (current == 1) {
        state.homeSecondListDate = list.obj!;
      } else {
        state.homeSecondListDate.addAll(list.obj!);
      }
      if (list.obj!.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update(
        [GetBuilderIds.getHomeSecondListDate + classifyTypeValue.toString()]);
  }
}
