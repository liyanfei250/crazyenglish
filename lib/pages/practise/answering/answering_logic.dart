import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:get/get.dart';

import '../../../entity/commit_request.dart';
import '../../../entity/week_detail_response.dart';
import '../../../repository/week_test_repository.dart';
import 'answering_state.dart';

class AnsweringLogic extends GetxController {
  final AnsweringState state = AnsweringState();
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

  void updateUserAnswer(String subtopicId,SubtopicAnswerVo subtopicAnswerVo){
    state.subtopicAnswerVoMap[subtopicId] = subtopicAnswerVo;
  }

  void updateCurrentPage(int currentQuestion,{int totalQuestion = 0}){
    if(totalQuestion>0){
      state.totalQuestionNum = totalQuestion;
    }
    if(currentQuestion>=0){
      state.currentQuestionNum = currentQuestion;
    }

    update([GetBuilderIds.answerPageNum]);
  }

  void uploadWeekTest(SubjectVoList subjectVoList) async{


    List<SubtopicAnswerVo> subtopicAnswerVoList = [];
    state.subtopicAnswerVoMap.forEach((key, value) {
      subtopicAnswerVoList.add(value);
    });

    SubjectAnswerVo subjectAnswerVo = SubjectAnswerVo(
        subjectId: subjectVoList.id,
        isSubjectivity: subjectVoList.isSubjectivity,
        questionTypeStr: subjectVoList.questionTypeStr,
        subtopicAnswerVo: subtopicAnswerVoList);

    List<SubjectAnswerVo> subjectAnswerVoList = [];
    subjectAnswerVoList.add(subjectAnswerVo);

    CommitAnswer commitAnswer = CommitAnswer(journalId: subjectVoList.journalId,
        journalCatalogueId: subjectVoList.journalCatalogueId,
        type: "1",
        examId: 0,
        subjectAnswerVo:subjectAnswerVoList);

    CommitAnswer commitResponse = await weekTestRepository.uploadWeekTest(commitAnswer);
    state.commitResponse = commitResponse;
    update([GetBuilderIds.commitAnswer]);
  }
}
