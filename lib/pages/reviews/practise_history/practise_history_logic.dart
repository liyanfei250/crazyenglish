import 'package:get/get.dart';

import '../../../entity/home/PractiseDate.dart';
import '../../../entity/review/PractiseHistoryDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../repository/ReviewRepository.dart';
import 'practise_history_state.dart';

class Practise_historyLogic extends GetxController {
  final Practise_historyState state = Practise_historyState();
  ReviewRepository recordData = ReviewRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getPracticeDateInfo(String id,String date) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.PracRecordInfoResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return PractiseDate.fromJson(value as Map<String,dynamic>?);
      }
    });

    bool hasCache = false;
    if(cache is PractiseDate) {
      state.dateDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.PracticeDate]);
    }
    PractiseDate list = await recordData.getPracticeDateList(id,date);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PracticeDate,
        labelId: id,
        list.toJson());
    state.dateDetail = list!;
    if(!hasCache){
      update([GetBuilderIds.PracticeDate]);
    }
  }

  void getRecordInfo(String id,String date) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.PracticeDate,labelId: id.toString()).then((value){
      if(value!=null){
        return PractiseHistoryDate.fromJson(value as Map<String,dynamic>?);
      }
    });

    bool hasCache = false;
    if(cache is PractiseHistoryDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getPracticeRecordList]);
    }
    PractiseHistoryDate list = await recordData.getPracticeRecordList(id,date);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PracRecordInfoResponse,
        labelId: id,
        list.toJson());
    state.paperDetail = list!;
    if(!hasCache){
      update([GetBuilderIds.getPracticeRecordList]);
    }
  }
}
