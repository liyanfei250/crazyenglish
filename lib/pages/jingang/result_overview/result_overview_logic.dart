import 'package:get/get.dart';

import '../../../entity/QuestionListResponse.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'result_overview_state.dart';

class ResultOverviewLogic extends GetxController {
  final ResultOverviewState state = ResultOverviewState();

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
        JsonCacheManageUtils.ResultListResponse,labelId: tagId.toString()).then((value){
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
      update([tagId]);
    }

    QuestionListResponse questionListResponse = QuestionListResponse();
    List<Questions> questions = [];
    for(int i = 0;i<2;i++){
        Questions question = Questions(id: i*100,name: "sd",groupId: i,groupName: "${i+1}.情景反应");
        questions.add(question);
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
    update([tagId]);

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
    update([tagId]);
  }
}
