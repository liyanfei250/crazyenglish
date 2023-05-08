
import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/pages/jingang/result_overview/result_overview_view.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/review/ErrorNoteTabDate.dart';
import '../../../entity/review/HomeSecondListDate.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/json_cache_util.dart';
import 'week_test_detail_state.dart';

class WeekTestDetailLogic extends GetxController {
  final WeekTestDetailState state = WeekTestDetailState();

  final WeekTestRepository weekTestRepository = WeekTestRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 获取试题详情页数据
  Future<WeekDetailResponse> getWeekTestDetailByCatalogId(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekDetailResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return WeekDetailResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekDetailResponse) {
      state.weekDetailResponse = cache!;
      state.uuid = id;
      getWeekTestDetailByCatalogFromServer(id);
      return cache!;
    }
    return getWeekTestDetailByCatalogFromServer(id);
  }

  Future<WeekDetailResponse> getWeekTestDetailByCatalogFromServer(String id) async{
    WeekDetailResponse list = await weekTestRepository.getWeekTestDetailFromCatalogId(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekDetailResponse,
        labelId: id,
        list.toJson());
    state.weekDetailResponse = list!;
    state.uuid = id;
    return list;
  }


  // 获取试题详情页数据
  Future<WeekDetailResponse> getWeekTestDetailBySubjectId(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekDetailResponseFromSUBJECTID,labelId: id.toString()).then((value){
      if(value!=null){
        return WeekDetailResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekDetailResponse) {
      state.weekDetailResponse = cache!;
      state.uuid = id;
      getWeekTestDetailBySubjectIdFromServer(id);
      return cache!;
    }
    return getWeekTestDetailBySubjectIdFromServer(id);
  }

  Future<WeekDetailResponse> getWeekTestDetailBySubjectIdFromServer(String id) async{
    WeekDetailResponse list = await weekTestRepository.getWeekTestDetailFromSubjectId(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekDetailResponseFromSUBJECTID,
        labelId: id,
        list.toJson());
    state.weekDetailResponse = list!;
    state.uuid = id;
    return list;
  }


  // 正常作答 跳转到答题页
  void getDetailAndStartExam(String id,{bool? enterResult = false,bool? isOffCurrentPage = false,
    int jumpParentIndex = -1,int jumpChildIndex = -1,CancelFunc? hideLoading}) async {
    WeekDetailResponse weekDetailResponse = await getWeekTestDetailByCatalogId(id);
    if(weekDetailResponse!=null){
      if(weekDetailResponse.obj!=null){
        if(weekDetailResponse.obj!.subjectVoList==null || weekDetailResponse.obj!.subjectVoList!.length==0){
          Util.toast("目录下没有试题");
          if(hideLoading!=null){
            hideLoading.call();
          }
          return;
        }
      }
      jumpToStartExam(id,enterResult: enterResult,isOffCurrentPage: isOffCurrentPage,jumpParentIndex : jumpParentIndex,jumpChildIndex : jumpChildIndex);
    } else {
      Util.toast("获取试题详情数据失败");
      if(hideLoading!=null){
        hideLoading.call();
      }
    }
  }

  // 练习记录 跳转到结果页
  void getDetailAndEnterResult(String subjectId,String exerciseId) async {
    WeekDetailResponse weekDetailResponse = await getWeekTestDetailBySubjectId(subjectId);
    if(weekDetailResponse!=null){
      jumpToReviewAnswerResultDetail(exerciseId);
    } else {
      Util.toast("获取试题详情数据失败");
    }
  }

  // 已订正错题 收藏题目 跳转到浏览页
  void getDetailAndEnterBrowsePage(String subjectId,String subtopicId) async {
    WeekDetailResponse weekDetailResponse = await getWeekTestDetailBySubjectId(subjectId);
    if(weekDetailResponse!=null){
      jumpToReviewDetail(subjectId,subtopicId);
    } else {
    Util.toast("暂不能跳转");
    }
  }

  // 待订正错题 跳转到答题页
  void getDetailAndEnterFixPage(String subjectId,List<CorrectionNotebooks>? correctionNotebooks) async {
    WeekDetailResponse weekDetailResponse = await getWeekTestDetailBySubjectId(subjectId);
    if(weekDetailResponse!=null){
      jumpToFixErrorDetail(subjectId,correctionNotebooks);
    } else {
      Util.toast("暂不能跳转");
    }
  }


  void jumpToStartExam(String id,{bool? enterResult = false,bool? isOffCurrentPage = false,int jumpParentIndex = -1,int jumpChildIndex = -1}) async{
    StartExam startExam = await weekTestRepository.getStartExam(id);
    state.startExam = startExam;
    state.uuid = id;
    state.isOffCurrentPage = isOffCurrentPage??false;
    int maxLength = 0;
    if(state.weekDetailResponse.obj!.subjectVoList!=null){
      maxLength = state.weekDetailResponse.obj!.subjectVoList!.length;
    }
    if(jumpParentIndex>=0){
      // 直接跳到指定题目 开始作答
      state.parentIndex = jumpParentIndex;
      state.childIndex = (jumpChildIndex < 0 ? 0 :jumpChildIndex);
    } else {
      // 找到上次作答位置索引
      if(startExam!.obj==null || (startExam!.obj!.isFinish?? true)){
        // 已经做完 从第一道题开始即可
        state.parentIndex = 0;
        state.childIndex = 0;
      } else {
        // 未做完 从后台返回的索引开始
        state.parentIndex = (startExam!.obj!.parentIndex?? 0).toInt();
        state.childIndex = (startExam!.obj!.sublevelIndex?? 0).toInt();
        // 索引异常
        if(state.parentIndex > maxLength){
          state.parentIndex = 0;
          state.childIndex = 0;
        }
      }
    }
    if(enterResult??false){
      state.enterResult = enterResult??false;
      // 有结果才正真跳结果页 否则还是不行 进入作答页
      var nextHasResult = false;
      SubjectVoList? nextSubjectVoList = AnsweringPage.findJumpSubjectVoList(state.weekDetailResponse,state.parentIndex);
      if(nextSubjectVoList!=null){
        if(startExam!=null && startExam.obj!=null){
          ExerciseVos? exerciseVos = AnsweringPage.findExerciseResult(startExam.obj,nextSubjectVoList!.id??0);
          Map<String,ExerciseLists> nextSubtopicAnswerVoMap = AnsweringPage.makeExerciseResultToMap(exerciseVos);
          if(nextSubtopicAnswerVoMap.isEmpty){
            nextHasResult = false;
          }else{
            nextHasResult = true;
          }
        }else{
          nextHasResult = false;
        }
      }else{
        nextHasResult = false;
      }
      if(nextHasResult){
        state.enterResult = true;
      }else{
        state.enterResult = false;
      }
    }else{
      state.enterResult = false;
    }

    update([GetBuilderIds.startExam]);
  }

  // 跳转结果页 展示当次作答记录
  void jumpToReviewAnswerResultDetail(String exerciseId) async{
    StartExam startExam = await weekTestRepository.getExerciseDetail(exerciseId);
    state.startExam = startExam;
    update([GetBuilderIds.exerciseHistory]);
  }

  // 跳转结果页 直接展示正确答案
  void jumpToReviewDetail(String subjectId,String subtopicId) async{
    if(state.weekDetailResponse.obj!=null){
      List<ExerciseVos> exerciseVosList = [];
      state.weekDetailResponse.obj!.subjectVoList!.forEach((element) {
        if("${element.id}" == subjectId){
          List<ExerciseLists> exerciseListsList = [];
          int subtopicVoListLength = element.subtopicVoList!.length;
          if(subtopicVoListLength>0){
            for(int i =0;i<subtopicVoListLength;i++){
              SubtopicVoList subtopicVo = element.subtopicVoList![i];
              if(subtopicId == "${subtopicVo.id}"){
                state.childIndex = i;
              }
              ExerciseLists exerciseLists = ExerciseLists(
                isRight: true,
                subjectId:element.id,
                subtopicId:subtopicVo.id,
                answer: subtopicVo.answer,);
              exerciseListsList.add(exerciseLists);
            }
          }
          if(exerciseListsList.length >0){
            ExerciseVos exerciseVos = ExerciseVos(
                subjectId:element.id,
                exerciseLists: exerciseListsList
            );
            exerciseVosList.add(exerciseVos);
          }
        }
      });
      if(exerciseVosList.length>0){
        Exercise exercise = Exercise(exerciseVos: exerciseVosList);
        StartExam startExam = StartExam(code:0,obj: exercise);
        state.startExam = startExam;
        update([GetBuilderIds.exerciseHistory]);
      }else{
        Util.toast("正确作答拼装发生错误");
      }
    }else{
      Util.toast("正确作答拼装发生错误");
    }

  }


  // 跳转答题页 纠正错题
  void jumpToFixErrorDetail(String subjectId,List<CorrectionNotebooks>? correctionNotebooks) async{
    num? firstSubtopicId = 0;
    Set<num> correctNoteSubtopicIdSet = {};
    // 找到第一道错题索引
    if(correctionNotebooks!=null && correctionNotebooks!.length>0){
      firstSubtopicId = correctionNotebooks![0].subtopicId;
      correctionNotebooks.forEach((element) {
        if(element.subtopicId!=null){
          correctNoteSubtopicIdSet.add(element.subtopicId!);
        } else {
          print("题型有误 subtopicId不能为空");
        }
      });
    }
    if(state.weekDetailResponse.obj!=null){
      List<ExerciseVos> exerciseVosList = [];
      int totalSubject = state.weekDetailResponse.obj!.subjectVoList!.length;
      for(int subjectIndex = 0;subjectIndex < totalSubject; subjectIndex++){
        SubjectVoList element = state.weekDetailResponse.obj!.subjectVoList![subjectIndex];
        if("${element.id}" == subjectId){
          List<ExerciseLists> exerciseListsList = [];
          int subtopicVoListLength = element.subtopicVoList!.length;
          if(subtopicVoListLength>0){
            for(int i =0;i<subtopicVoListLength;i++){
              SubtopicVoList subtopicVo = element.subtopicVoList![i];
              if(firstSubtopicId == subtopicVo.id){
                state.childIndex = i;
              }
              if(correctNoteSubtopicIdSet.contains(subtopicVo.id)){
                // 已错题不展示正确答案
                continue;
              } else {
                ExerciseLists exerciseLists = ExerciseLists(
                  isRight: true,
                  subjectId:element.id,
                  subtopicId:subtopicVo.id,
                  answer: subtopicVo.answer,);
                exerciseListsList.add(exerciseLists);
              }
            }
          }
          if(exerciseListsList.length >0){
            ExerciseVos exerciseVos = ExerciseVos(
                subjectId:element.id,
                exerciseLists: exerciseListsList
            );
            exerciseVosList.add(exerciseVos);
          }
          state.parentIndex = subjectIndex;
          break;
        }
      }
      if(exerciseVosList.length>0){
        Exercise exercise = Exercise(exerciseVos: exerciseVosList);
        StartExam startExam = StartExam(code:0,obj: exercise);
        state.startExam = startExam;
        update([GetBuilderIds.examToFix]);
      }else{
        Util.toast("正确作答拼装发生错误");
      }
    }else{
      Util.toast("正确作答拼装发生错误");
    }

  }


  // 跳转期刊成绩页
  void jumpToResutOverView(String exerciseId,String classifyType,List<CatalogueMergeVo> list) async{
    JouralResultResponse jouralResultResponse = await weekTestRepository.getResultOverviewExercise(exerciseId,classifyType);
    state.jouralResultResponse = jouralResultResponse;
    state.catalogueRecordVoList = _processCatalogueRecordVoList(list);
    update([GetBuilderIds.resoultOverView]);
  }

  // 跳转答题页监听
  // TODO 到底是增加监听前 添加索引合适呢 还是 发起请求前添加索引合适呢
  // 接着上次作答 显然不适合增加监听时添加
  // 只能发起请求时指定了
  void addJumpToStartExamListen(){
    disposeId(GetBuilderIds.startExam);
    addListenerId(GetBuilderIds.startExam, () {
      // TODO state.startExam 开始作答数据可在此处理
      if(state.isOffCurrentPage){
        if(state.enterResult){
          RouterUtil.offAndToNamed(
              AppRoutes.ResultPage,
              isNeedCheckLogin:true,
              arguments: {
                AnsweringPage.examDetailKey: state.weekDetailResponse,
                AnsweringPage.catlogIdKey:state.uuid,
                AnsweringPage.parentIndexKey:state.parentIndex,
                AnsweringPage.childIndexKey:state.childIndex,
                AnsweringPage.LastFinishResult: state.startExam,
              });
        }else{
          RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
              isNeedCheckLogin:true,
              arguments: {AnsweringPage.examDetailKey: state.weekDetailResponse,
                AnsweringPage.catlogIdKey:state.uuid,
                AnsweringPage.parentIndexKey:state.parentIndex,
                AnsweringPage.childIndexKey:state.childIndex,
                AnsweringPage.LastFinishResult:state.startExam,
                AnsweringPage.answer_type:AnsweringPage.answer_normal_type,
              });
        }

      }else{
        if(state.enterResult){
          RouterUtil.toNamed(
              AppRoutes.ResultPage,
              isNeedCheckLogin:true,
              arguments: {
                AnsweringPage.examDetailKey: state.weekDetailResponse,
                AnsweringPage.catlogIdKey:state.uuid,
                AnsweringPage.parentIndexKey:state.parentIndex,
                AnsweringPage.childIndexKey:state.childIndex,
                AnsweringPage.LastFinishResult: state.startExam,
              });
        }else{
          RouterUtil.toNamed(AppRoutes.AnsweringPage,
              isNeedCheckLogin:true,
              arguments: {AnsweringPage.examDetailKey: state.weekDetailResponse,
                AnsweringPage.catlogIdKey:state.uuid,
                AnsweringPage.parentIndexKey:state.parentIndex,
                AnsweringPage.childIndexKey:state.childIndex,
                AnsweringPage.LastFinishResult:state.startExam,
                AnsweringPage.answer_type:AnsweringPage.answer_normal_type,
              });
        }
      }
    });
  }

  // 跳转直接显示正确答案 结果页监听
  void addJumpToReviewDetailListen({int parentIndex = 0,int resultType = AnsweringPage.result_normal_type}){
    disposeId(GetBuilderIds.exerciseHistory);
    addListenerId(GetBuilderIds.exerciseHistory, () {
      if(state.startExam!.obj!=null){
        RouterUtil.toNamed(AppRoutes.ResultPage,
            isNeedCheckLogin:true,
            arguments: {AnsweringPage.examDetailKey: state.weekDetailResponse,
              AnsweringPage.catlogIdKey:state.uuid,
              AnsweringPage.parentIndexKey:parentIndex,
              AnsweringPage.childIndexKey:state.childIndex,
              AnsweringPage.examResult:state.startExam!.obj!,
              AnsweringPage.result_type:resultType,
            });
      }else{
        Util.toast("已获取作答数据为空");
      }
    });
  }

  // 跳转答题页去纠正错题监听
  void addJumpToFixErrorListen(){
    disposeId(GetBuilderIds.examToFix);
    addListenerId(GetBuilderIds.examToFix, () {
      RouterUtil.toNamed(AppRoutes.AnsweringPage,
          isNeedCheckLogin:true,
          arguments: {AnsweringPage.examDetailKey: state.weekDetailResponse,
            AnsweringPage.catlogIdKey:state.uuid,
            AnsweringPage.parentIndexKey:state.parentIndex,
            AnsweringPage.childIndexKey:state.childIndex,
            AnsweringPage.LastFinishResult:state.startExam,
            AnsweringPage.answer_type:AnsweringPage.answer_fix_type,
          });
    });
  }


  // 跳转期刊成绩页
  void addJumpToResutOverViewListen(){
    disposeId(GetBuilderIds.resoultOverView);
    addListenerId(GetBuilderIds.resoultOverView, () {
      RouterUtil.toNamed(AppRoutes.ResultOverviewPage,
          isNeedCheckLogin:true,
          arguments: {
            ResultOverviewPage.exerciseOverView: state.jouralResultResponse,
            ResultOverviewPage.listCatalogueMergeVo: state.catalogueRecordVoList,
          });
    });
  }

  List<CatalogueRecordVoList> _processCatalogueRecordVoList(List<CatalogueMergeVo> list){
    List<CatalogueRecordVoList> catalogueRecordVoList =  [];
    if(list!=null){
      int listLenth = list.length;
      for(int j = 0;j<listLenth;j++){
        CatalogueMergeVo element = list[j];
        if(element.catalogueRecordVoList!=null && element.catalogueRecordVoList!.length>0){
          int total = element.catalogueRecordVoList!.length;
          for(int i = 0;i<total;i++){
            CatalogueRecordVoList catalogueRecord = element.catalogueRecordVoList![i];
            catalogueRecord.catalogueMergeName = element.catalogueMergeName;
            catalogueRecordVoList.add(catalogueRecord);
          }
        }
      }
    }
    return catalogueRecordVoList;
  }
}
