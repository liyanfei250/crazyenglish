import 'dart:convert';

import 'package:get/get.dart';

import '../../../../entity/home/ErrorNoteTab.dart';
import '../../../../entity/home/HomeKingDate.dart';
import '../../../../entity/review/ErrorNoteTabDate.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import '../../repository/ReviewRepository.dart';
import 'error_note_child_state.dart';

class ErrorNoteChildLogic extends GetxController {
  final ErrorNoteChildState state = ErrorNoteChildState();
  ReviewRepository recordData = ReviewRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //获取tab
  // void getErrorNoteTab(int id) async {
  //   ErrorNoteTab list = await recordData.getErrorNoteTab(id.toString());
  //   state.tabDetail = list!;
  //   update([GetBuilderIds.getErrorNoteTab]);
  // }

  // void getTabArrays(int userId,int isCorrect,int classify) async {
  // final jsonStr = '{"userId": $userId, "isCorrect": $isCorrect, "classify": $classify}';
  // final jsonMap = json.decode(jsonStr);
  //    var cache = await JsonCacheManageUtils.getCacheData(
  //           JsonCacheManageUtils.ErrorNateTabList,
  //           labelId: userId.toString())
  //       .then((value) {
  //     if (value != null) {
  //       return ErrorNoteTabDate.fromJson(value as Map<String, dynamic>?);
  //     }
  //   });
  //
  //   bool hasCache = false;
  //   if (cache is ErrorNoteTabDate) {
  //     state.paperDetail = cache!;
  //     hasCache = true;
  //     update([GetBuilderIds.getErrorNoteTabDate]);
  //   }
  //   ErrorNoteTabDate list = await recordData.getErrorNoteTabDate(jsonMap);
  //   JsonCacheManageUtils.saveCacheData(
  //       JsonCacheManageUtils.ErrorNateTabList,
  //       labelId: userId.toString(),
  //       list.toJson());
  //   state.paperDetail = list!;
  //   if (!hasCache) {
  //     update([GetBuilderIds.getErrorNoteTabDate]);
  //   }
  // }


}
