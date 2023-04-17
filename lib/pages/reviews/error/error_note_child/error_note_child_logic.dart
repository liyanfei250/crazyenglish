import 'package:get/get.dart';

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

  void getTabArrays(int id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.ErrorNateTabList,labelId: id.toString()).then((value){
      if(value!=null){
        return ErrorNoteTabDate.fromJson(value as Map<String,dynamic>?);
      }
    });

    bool hasCache = false;
    if(cache is ErrorNoteTabDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getErrorNoteTabDate]);
    }
    ErrorNoteTabDate list = await recordData.getErrorNoteTabDate(id.toString());
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.ErrorNateTabList,
        labelId: id.toString(),
        list.toJson());
    state.paperDetail = list!;
    if(!hasCache){
      update([GetBuilderIds.getErrorNoteTabDate]);
    }
  }
}
