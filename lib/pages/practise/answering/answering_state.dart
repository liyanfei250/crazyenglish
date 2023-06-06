import 'package:crazyenglish/entity/week_detail_response.dart';

import '../../../entity/commit_request.dart';
import '../../../entity/start_exam.dart';

class AnsweringState {

  // 提交答案时的数据
  CommitAnswer commitAnswer = CommitAnswer();
  int countTime = 0;

  // 下面两条数据 转换成list后 最后拼装到 commitAnswer中
  SubjectAnswerVo subjectAnswerVo = SubjectAnswerVo();
  // subtopicId SubtopicAnswerVo
  Map<String,SubtopicAnswerVo> subtopicAnswerVoMap = {};

  // 提交完答案返回的数据 TODO 暂时未用到
  CommitResponse commitResponse = CommitResponse();

  int totalQuestionNum = 0;
  int currentQuestionNum = -1;

  String? operationId = "";
  String? operationStudentId = "";
  String? operationClassId = "";


  StartExam examResult = StartExam();
  AnsweringState() {
    ///Initialize variables
  }

}
