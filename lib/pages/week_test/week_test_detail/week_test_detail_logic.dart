import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/review/ErrorNoteTabDate.dart';
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
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
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
  void getDetailAndStartExam(String id,{bool? enterResult = false,bool? isOffCurrentPage = false}) async {
    WeekDetailResponse weekDetailResponse = await getWeekTestDetailByCatalogId(id);
    if(weekDetailResponse!=null){
      jumpToStartExam(id,enterResult: enterResult,isOffCurrentPage: isOffCurrentPage);
    } else {
      Util.toast("获取试题详情数据失败");
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


  void jumpToStartExam(String id,{bool? enterResult = false,bool? isOffCurrentPage = false}) async{
    StartExam startExam = await weekTestRepository.getStartExam(id);
    state.startExam = startExam;
    state.uuid = id;
    state.enterResult = enterResult??false;
    state.isOffCurrentPage = isOffCurrentPage??false;
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
      state.weekDetailResponse.obj!.subjectVoList!.forEach((element) {
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
        }
      });
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



  // 跳转答题页监听
  void addJumpToStartExamListen(int parentIndex,int childIndex){
    disposeId(GetBuilderIds.startExam);
    addListenerId(GetBuilderIds.startExam, () {
      // TODO 区分一下 写作 还是 其它题
      if (state.weekDetailResponse != null &&
          state.weekDetailResponse.obj != null &&
          state.weekDetailResponse.obj!.subjectVoList!.length > 0 &&
          state.weekDetailResponse.obj!.subjectVoList![parentIndex].classifyValue == QuestionTypeClassify.writing) {

        if(state.isOffCurrentPage){
          RouterUtil.offAndToNamed(AppRoutes.WritingPage,
              arguments: {"detail": state.weekDetailResponse});
        }else{
          RouterUtil.toNamed(AppRoutes.WritingPage,
              arguments: {"detail": state.weekDetailResponse});
        }

      } else {
        // TODO state.startExam 开始作答数据可在此处理
        if(state.isOffCurrentPage){
          RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
              arguments: {AnsweringPage.examDetailKey: state.weekDetailResponse,
              AnsweringPage.catlogIdKey:state.uuid,
              AnsweringPage.parentIndexKey:parentIndex,
              AnsweringPage.childIndexKey:childIndex,
              AnsweringPage.LastFinishResult:state.startExam,
              AnsweringPage.answer_type:AnsweringPage.answer_normal_type,
              });
        }else{
          RouterUtil.toNamed(AppRoutes.AnsweringPage,
              arguments: {AnsweringPage.examDetailKey: state.weekDetailResponse,
              AnsweringPage.catlogIdKey:state.uuid,
              AnsweringPage.parentIndexKey:parentIndex,
              AnsweringPage.childIndexKey:childIndex,
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
      // TODO 区分一下 写作 还是 其它题
      if (state.weekDetailResponse != null &&
          state.weekDetailResponse.obj != null &&
          state.weekDetailResponse.obj!.subjectVoList!.length > 0 &&
          state.weekDetailResponse.obj!.subjectVoList![parentIndex].classifyValue == QuestionTypeClassify.writing) {

        if(state.isOffCurrentPage){
          RouterUtil.offAndToNamed(AppRoutes.ResultPage,
              arguments: {"detail": state.weekDetailResponse});
        } else {
          RouterUtil.toNamed(AppRoutes.ResultPage,
              arguments: {"detail": state.weekDetailResponse});
        }

      } else {
        if(state.startExam!.obj!=null){
          RouterUtil.toNamed(AppRoutes.ResultPage,
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
      }
    });
  }

  // 跳转答题页去纠正错题监听
  void addJumpToFixErrorListen({int parentIndex =0}){
    disposeId(GetBuilderIds.examToFix);
    addListenerId(GetBuilderIds.examToFix, () {
      // TODO 区分一下 写作 还是 其它题
      if (state.weekDetailResponse != null &&
          state.weekDetailResponse.obj != null &&
          state.weekDetailResponse.obj!.subjectVoList!.length > 0 &&
          state.weekDetailResponse.obj!.subjectVoList![parentIndex].classifyValue == QuestionTypeClassify.writing) {

        if(state.isOffCurrentPage){
          RouterUtil.offAndToNamed(AppRoutes.WritingPage,
              arguments: {"detail": state.weekDetailResponse});
        }else{
          RouterUtil.toNamed(AppRoutes.WritingPage,
              arguments: {"detail": state.weekDetailResponse});
        }

      } else {
        RouterUtil.toNamed(AppRoutes.AnsweringPage,
            arguments: {AnsweringPage.examDetailKey: state.weekDetailResponse,
              AnsweringPage.catlogIdKey:state.uuid,
              AnsweringPage.parentIndexKey:parentIndex,
              AnsweringPage.childIndexKey:state.childIndex,
              AnsweringPage.LastFinishResult:state.startExam,
              AnsweringPage.answer_type:AnsweringPage.answer_fix_type,
            });
      }
    });
  }
}
