import 'package:get/get.dart';

import '../../../entity/HomeworkStudentResponse.dart';
import '../../../repository/home_work_repository.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'school_report_list_state.dart';

class SchoolReportListLogic extends GetxController {
  final SchoolReportListState state = SchoolReportListState();
  HomeworkRepository homeworkRepository = HomeworkRepository();

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


  // 1 待提醒 2 待批改
  void getStudentList(num homeworkId,int page,int pageSize,int status) async{

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.StudentListResponse,labelId: "$homeworkId$status").then((value){
      if(value!=null){
        return HomeworkStudentResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is HomeworkStudentResponse && cache.obj!=null) {
      state.list = cache.obj!.records!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update(["${GetBuilderIds.getStudentList}$homeworkId$status"]);
    }


    HomeworkStudentResponse homeworkStudentResponse = await homeworkRepository.getHomeworkScoreStudentList(status,homeworkId, page, pageSize);

    if(homeworkRepository!=null){
      state.list = homeworkStudentResponse.obj!.records!;
    }

    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.WeekTestListResponse,
          labelId: "$homeworkId$status",
          homeworkStudentResponse.toJson());
    }
    if (homeworkStudentResponse.obj == null) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = homeworkStudentResponse.obj!.records!;
      } else {
        state.list.addAll(homeworkStudentResponse.obj!.records!);
      }
      if (homeworkStudentResponse.obj!.records!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update(["${GetBuilderIds.getStudentList}$homeworkId$status"]);

  }

}
