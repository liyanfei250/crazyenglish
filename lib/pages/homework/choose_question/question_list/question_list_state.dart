import 'package:crazyenglish/entity/QuestionListResponse.dart';

class QuestionListState {
  List<Questions> list = [];
  bool hasMore = true;
  int pageNo = 1;
  QuestionListState() {
    ///Initialize variables
  }
}
