import 'package:crazyenglish/entity/HomeworkExamPaperResponse.dart';
import 'package:crazyenglish/pages/mine/ClassRepository.dart';
import 'package:get/get.dart';

import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'choose_exam_paper_state.dart';

class ChooseExamPaperLogic extends GetxController {
  final ChooseExamPaperState state = ChooseExamPaperState();
ClassRepository classRepository =ClassRepository();
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

  void getExampersList(String teacherId,int page,int pageSize) async{
    Map<String,dynamic> req= {};
    Map<String,dynamic> p= {};
    p["current"] = page;
    p["size"] = pageSize;
    req["teacherId"] = teacherId;
    req["p"] = p;

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.TeacherTestPagerList).then((value){
      if(value!=null){
        return HomeworkExamPaperResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is HomeworkExamPaperResponse && cache.obj != null) {
      state.list = cache.obj!.records!;
      if (state.list.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getExampersList]);
    }
    HomeworkExamPaperResponse list = await classRepository.getMyPaperPageList(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.TeacherTestPagerList,
          list.toJson());
    }
    if (list.obj == null) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.obj!.records!;
      } else {
        state.list.addAll(list.obj!.records!);
      }
      if (list.obj!.records!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getExampersList]);

  }
}
