import 'package:get/get.dart';

import '../../../../entity/QuestionListResponse.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/json_cache_util.dart';
import '../../../jingang/listening_practice/ListRepository.dart';
import 'question_list_state.dart';
import '../../../../entity/review/HomeSecondListDate.dart' as data;

class QuestionListLogic extends GetxController {
  final QuestionListState state = QuestionListState();
  ListRepository listData = ListRepository();
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

  void getQuestionList(int userId, dynamic classifyTypeValue,dynamic affiliatedGrade,
      int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["userId"] = userId;
    req["dictionaryId"] = classifyTypeValue;
    req["affiliatedGrade"] = affiliatedGrade;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.SecondListDate,
        labelId: classifyTypeValue.toString())
        .then((value) {
      if (value != null) {
        return data.HomeSecondListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 && cache?.obj != null && cache!.obj is data.Obj) {
      state.homeSecondListDate = cache!.obj!;
      if (state.homeSecondListDate.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      state.homeFinalListDate = extractCatalogueRecordVoLists(cache);

      update(
          [GetBuilderIds.getHomeSecondListDate + classifyTypeValue.toString()]);
    }

    data.HomeSecondListDate list = await listData.getListnerList(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.SecondListDate,
          labelId: classifyTypeValue.toString(),
          list.toJson());
    }
    if (list.obj == null) {
      if (current == 1) {
        state.homeSecondListDate.clear();
        state.homeFinalListDate.clear();
      }
    } else {
      if (current == 1) {
        state.homeSecondListDate = list.obj!;
        state.homeFinalListDate = extractCatalogueRecordVoLists(list);
      } else {
        state.homeSecondListDate.addAll(list.obj!);
        state.homeFinalListDate.addAll(extractCatalogueRecordVoLists(list));
      }
      if (list.obj!.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update(
        [GetBuilderIds.getHomeSecondListDate + classifyTypeValue.toString()]);
  }

  List<data.CatalogueRecordVoList> extractCatalogueRecordVoLists(data.HomeSecondListDate homeSecondListDate) {
    List<data.CatalogueRecordVoList> newList = [];

    // 遍历obj列表
    for (data.Obj obj in homeSecondListDate.obj!) {
      // 遍历catalogueMergeVo列表
      for (data.CatalogueMergeVo catalogueMergeVo in obj.catalogueMergeVo!) {
        // 将catalogueRecordVoList中的元素添加到新列表中
        newList.addAll(catalogueMergeVo.catalogueRecordVoList!);
      }
    }

    return newList;
  }




    /*Map<String,String> req= {};
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
  }*/
}
