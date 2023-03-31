import 'package:get/get.dart';

import '../../../../entity/QuestionListResponse.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import 'question_list_state.dart';

class QuestionListLogic extends GetxController {
  final QuestionListState state = QuestionListState();

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

  void getQuestionList(String tagId,int page,int pageSize) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    req["current"] = "$page";
    req["size"] = "$pageSize";

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.QuestionListResponse,labelId: tagId.toString()).then((value){
      if(value!=null){
        return QuestionListResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if(page==1 && cache is QuestionListResponse && cache.data!=null && cache.data!.questions!=null) {
      state.list = cache.data!.questions!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      }else{
        state.hasMore = true;
      }
      update([GetBuilderIds.getQuestionList+tagId]);
    }

    QuestionListResponse questionListResponse = QuestionListResponse();
    List<Questions> questions = [];
    for(int i = 0;i<13;i++){
      for(int j = 0;j<4;j++){
        String txt = "";
        switch(j){
          case 0: txt = "情景反应";
          break;
          case 1: txt = "对话理解";
          break;
          case 3: txt = "语篇理解";
          break;
          case 2: txt = "听力填空";
          break;
        }
        Questions question = Questions(id: i*100+j,name: "${j+1}.${txt}",groupId: i+1,groupName: "七年级新课程 第${j+1}期");
        questions.add(question);
      }


    }
    Data data = Data();
    data = data.copyWith(questions: questions);
    questionListResponse = questionListResponse.copyWith(code: 1,msg: "",data: data);

    state.list = questions!;
    if(state.list.length < pageSize){
      state.hasMore = false;
    }else{
      state.hasMore = true;
    }
    update([GetBuilderIds.getQuestionList+tagId]);

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
    update([GetBuilderIds.getQuestionList+tagId]);
  }
}
