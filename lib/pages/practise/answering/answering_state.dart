import 'package:crazyenglish/entity/week_detail_response.dart';

import '../../../entity/commit_request.dart';

class AnsweringState {
  String pageChangeStr = "";
  // 提交答案时的数据
  CommitAnswer commitAnswer = CommitAnswer();

  // 下面两条数据 转换成list后 最后拼装到 commitAnswer中
  SubjectAnswerVo subjectAnswerVo = SubjectAnswerVo();
  // subtopicId SubtopicAnswerVo
  Map<String,SubtopicAnswerVo> subtopicAnswerVoMap = {};

  // 提交完答案返回的数据
  CommitResponse commitResponse = CommitResponse();

  AnsweringState() {
    ///Initialize variables
  }

}
