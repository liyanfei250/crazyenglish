import 'package:crazyenglish/entity/HomeworkExamPaperResponse.dart';
import 'package:get/get.dart';

import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'choose_exam_paper_state.dart';

class ChooseExamPaperLogic extends GetxController {
  final ChooseExamPaperState state = ChooseExamPaperState();

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

  void getExampersList(int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.JournalListResponse).then((value){
      if(value!=null){
        return HomeworkExamPaperResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is HomeworkExamPaperResponse && cache.data!=null && cache.data!.exampapers!=null) {
      state.list = cache.data!.exampapers!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      }else{
        state.hasMore = true;
      }
      update([GetBuilderIds.getExampersList]);
    }

    List<Exampapers> exampers = [];
    for(int i = 0;i<13;i++){
      Exampapers student = Exampapers(id: page*100+i,name: "初二阅读：${page*100+i}期");
      exampers.add(student);
    }
    state.list = exampers!;
    if(state.list.length < pageSize){
      state.hasMore = false;
    }else{
      state.hasMore = true;
    }
    update([GetBuilderIds.getExampersList]);

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
    update([GetBuilderIds.getExampersList]);
  }
}
