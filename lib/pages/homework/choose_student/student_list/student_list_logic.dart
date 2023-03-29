import 'package:crazyenglish/entity/HomeworkStudentResponse.dart';
import 'package:get/get.dart';

import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import 'student_list_state.dart';

class StudentListLogic extends GetxController {
  final StudentListState state = StudentListState();

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

  void getStudentList(String classId,int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.StudentListResponse,labelId: classId.toString()).then((value){
      if(value!=null){
        return HomeworkStudentResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is HomeworkStudentResponse && cache.data!=null && cache.data!.students!=null) {
      state.list = cache.data!.students!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      }else{
        state.hasMore = true;
      }
      update([GetBuilderIds.getStudentList+classId]);
    }

    HomeworkStudentResponse homeworkStudentResponse = HomeworkStudentResponse();
    List<Students> students = [];
    for(int i = 0;i<13;i++){
      Students student = Students(id: page*100+i,name: "学生：${page*100+i}");
      students.add(student);
    }
    Data data = Data();
    data = data.copyWith(students: students);
    homeworkStudentResponse = homeworkStudentResponse.copyWith(code: 1,msg: "",data: data);

    state.list = students!;
    if(state.list.length < pageSize){
      state.hasMore = false;
    }else{
      state.hasMore = true;
    }
    update([GetBuilderIds.getStudentList+classId]);

    // WeekPaper list = await weekRepository.getWeekPaperList(req);
    // if(page ==1){
    //   JsonCacheManageUtils.saveCacheData(
    //       JsonCacheManageUtils.WeekPaperResponse,
    //       labelId: weekTime.toString(),
    //       list.toJson());
    // }
    // if(list.records==null) {
    //   if(page ==1){
    //     state.list.clear();
    //   }
    // } else {
    //   if(page ==1){
    //     state.list = list.records!;
    //   } else {
    //     state.list.addAll(list.records!);
    //   }
    //   if(list.records!.length < pageSize){
    //     state.hasMore = false;
    //   } else {
    //     state.hasMore = true;
    //   }
    // }
    update([GetBuilderIds.getStudentList+classId]);
  }

}
