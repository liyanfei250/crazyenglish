import 'package:crazyenglish/entity/HomeworkHistoryResponse.dart';
import 'package:crazyenglish/entity/class_list_response.dart';

class Choose_history_new_homeworkState {
  List<History> list = [];
  bool hasMore = true;
  int pageNo = 1;
  ClassListResponse myClassList = ClassListResponse();
  Choose_history_new_homeworkState() {
    ///Initialize variables
  }
}
