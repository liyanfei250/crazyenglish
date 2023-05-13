import 'dart:convert';

import 'package:crazyenglish/pages/mine/ClassRepository.dart';
import 'package:get/get.dart';

import '../../../../entity/test_paper_look_response.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import 'exam_question_state.dart';

class ExamQuestionLogic extends GetxController {
  final ExamQuestionState state = ExamQuestionState();
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

  void getQuestionList(String tagId,int page,int pageSize) async{
    // Map<String,String> req= {};
    // // req["weekTime"] = weekTime;
    // req["current"] = "$page";
    // req["size"] = "$pageSize";
    String jsonString =
        '{"name":"英语测试2","teacherId":"1651539603655626753","deadline":"2023-05-15 15:37:19","classInfos":[{"schoolClassId":"1655395694170124290","studentUserIds":[1651531759961624578,1651533076075499521]}],"paperType":1,"isCreatePaper":true,"journalCatalogueIds":[1648128423083769857,1648138028814798850,1648159430713421825,1654759659150610434],"journalId":null,"paperId":"382","historyOperationId":1656205266858061825}';

    Map<String, dynamic> req = jsonDecode(jsonString);
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.TeacherTestPagerLook,labelId: tagId.toString()).then((value){
      if(value!=null){
        return TestPaperLookResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is TestPaperLookResponse && cache.obj != null) {
      state.list = cache.obj!;
      if (state.list.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      update([GetBuilderIds.getExamper+tagId]);
    }
    TestPaperLookResponse list = await classRepository.toPreviewOperation(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.TeacherTestPagerLook,
          list.toJson());
    }
    if (list.obj == null) {
      if (page == 1) {
        state.list.clear();
      }
    } else {
      if (page == 1) {
        state.list = list.obj!;
      } else {
        state.list.addAll(list.obj!);
      }
      if (list.obj!.length < pageSize) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update([GetBuilderIds.getExamper+tagId]);


    /*state.pageNo = page;
    if(page==1 && cache is QuestionListResponse && cache.data!=null && cache.data!.questions!=null) {
      state.list = cache.data!.questions!;
      if(state.list.length < pageSize){
        state.hasMore = false;
      }else{
        state.hasMore = true;
      }
      update([GetBuilderIds.getExamper+tagId]);
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
    update([GetBuilderIds.getExamper+tagId]);*/

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
    // update([GetBuilderIds.getExamper+tagId]);
  }
}
