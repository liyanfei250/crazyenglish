import '../../../../entity/QuestionListResponse.dart';

class ExamQuestionState {

  List<Questions> list = [];
  bool hasMore = true;
  int pageNo = 1;

  ExamQuestionState() {
    ///Initialize variables
  }
}
