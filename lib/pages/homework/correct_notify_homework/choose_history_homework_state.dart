import 'package:crazyenglish/entity/class_list_response.dart';

import '../../../entity/HomeworkHistoryResponse.dart';

class ChooseHistoryHomeworkState {
  List<History> list = [];
  bool hasMore = true;
  int pageNo = 1;
  ClassListResponse myClassList = ClassListResponse();
  ChooseHistoryHomeworkState() {
    ///Initialize variables
  }
}
