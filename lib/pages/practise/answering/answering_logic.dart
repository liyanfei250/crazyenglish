import 'package:crazyenglish/entity/common_response.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../repository/week_test_repository.dart';
import 'answering_state.dart';

class AnsweringLogic extends GetxController {
  final AnsweringState state = AnsweringState();
  final WeekTestRepository weekTestRepository = WeekTestRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateTime( {int countTime = 0} ){
    if(countTime>0){
      state.countTime = countTime;
    }else{
      state.countTime++;
      update([GetBuilderIds.answerPeriodTime]);
    }
  }

  void updateOperationInfo(String? operationId,String? operationStudentId,String? operationClassId){
    state.operationId = operationId;
    state.operationStudentId = operationStudentId;
    state.operationClassId = operationClassId;
  }

  void updateUserAnswer(String subtopicId,SubtopicAnswerVo subtopicAnswerVo){
    state.subtopicAnswerVoMap[subtopicId] = subtopicAnswerVo;
  }

  void updateUserWritAnswer(String subjectId,SubjectAnswerVo subjectAnswerVo){
    state.subjectAnswerVo = subjectAnswerVo;
  }

  void updateCurrentPage(int currentQuestion,{int totalQuestion = 0,bool isInit = false}){
    if(totalQuestion>0){
      state.totalQuestionNum = totalQuestion;
    }
    if(currentQuestion>=0){
      state.currentQuestionNum = currentQuestion;
    }

    print("updateCurrentPage == ${currentQuestion} ${totalQuestion}");
    print("updateCurrentPage state== ${state.currentQuestionNum} ${state.totalQuestionNum}");
    if(!isInit){
      update([GetBuilderIds.answerPageNum]);
    }

  }

  void uploadWrite(){
    update([GetBuilderIds.uploadWrite]);
  }

  // "type": "1: 学生练习 2: 练习保存草稿 3：错题本提交 4：老师作业 5: 模拟考试"
  void uploadWeekTest(SubjectVoList subjectVoList,int examType,{ExerciseVos? exerciseVos,num? lastSubjectId, num? lastSubtopicId}) async{
    List<SubtopicAnswerVo> subtopicAnswerVoList = [];

    // 填充已做答的数据
    state.subtopicAnswerVoMap.forEach((key, value) {
      subtopicAnswerVoList.add(value);
    });
    //填充未作答的数据
    if(subjectVoList.subtopicVoList!=null){
      subjectVoList.subtopicVoList!.forEach((element) {
        if(!state.subtopicAnswerVoMap.containsKey("${element.id}")){
          SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(subtopicId: element.id,userAnswer: "",answer: element.answer,optionId: 0,isCorrect: false);
          subtopicAnswerVoList.add(subtopicAnswerVo);
        }
      });
    }


    num? exerciseId= 0;
    if(exerciseVos!=null && !(exerciseVos!.isFinish??false)){
      exerciseId = exerciseVos.id;
    }
    SubjectAnswerVo subjectAnswerVo = SubjectAnswerVo(
        subjectId: subjectVoList.id,
        answerTime: state.countTime,
        answer: state.subjectAnswerVo.answer??"",
        isSubjectivity: subjectVoList.isSubjectivity,
        questionTypeStr: subjectVoList.questionTypeStr,
        exerciseId: exerciseId,
        isOperation: examType == AnsweringPage.answer_homework_draft_type || examType == AnsweringPage.answer_continue_type,
        subtopicAnswerVo: subtopicAnswerVoList);

    List<SubjectAnswerVo> subjectAnswerVoList = [];
    subjectAnswerVoList.add(subjectAnswerVo);

    CommitAnswer commitAnswer = CommitAnswer(journalId: subjectVoList.journalId,
        journalCatalogueId: subjectVoList.journalCatalogueId,
        type: "${examType}",
        examId: 0,
        operationClassId:state.operationClassId,
        operationId:state.operationId??"",
        operationStudentId:state.operationStudentId,
        lastSubjectId: (lastSubjectId??0).toString(),
        lastSubtopicId: (lastSubtopicId??0).toString(),
        userId: SpUtil.getInt(BaseConstant.USER_ID),
        subjectAnswerVo:subjectAnswerVoList);

    CommitResponse commitResponse = await weekTestRepository.uploadWeekTest(commitAnswer);
    state.commitResponse = commitResponse;
    if(examType == AnsweringPage.answer_fix_type){
      update([GetBuilderIds.examResult]);
    }else if(examType == AnsweringPage.answer_homework_type){
      update([GetBuilderIds.answerHomework]);
      // getHomeworkResult("${subjectVoList.journalCatalogueId}",state.operationStudentId??"");
    }else if(examType== AnsweringPage.answer_normal_type){
      getResult(subjectVoList);
    }
    // update([GetBuilderIds.commitAnswer]);

  }

  void uploadCorrectionOperation() async{

  }


  void getResult(SubjectVoList subjectVoList) async{
    StartExam startExam = await weekTestRepository.getExamResult("${subjectVoList.journalCatalogueId}");
    state.examResult = startExam;
    update([GetBuilderIds.examResult]);
  }

  void getHomeworkResult(String catalogId,String operationStudentId) async{
    StartExam startExam = await weekTestRepository.getStartHomework(catalogId,operationStudentId);
    state.examResult = startExam;
    update([GetBuilderIds.examResult]);
  }

  void getToCorrect(
      num? exerciseId, String remark,String operationClassId,String operationStudentId) async {
    Map<String, dynamic> req = {};
    req["exerciseId"] = exerciseId??0;
    req["correctionType"] = "1";// 答题1 小题2
    req["operationClassId"] = operationClassId;
    req["operationStudentId"] = operationStudentId;
    req["remark"] = remark;
    CommonResponse list = await weekTestRepository.toCorrectionOperation(req);
    if(list.success!){
      update([GetBuilderIds.getToCoorectWriting]);
    }
  }

}
