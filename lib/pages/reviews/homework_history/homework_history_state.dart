import 'package:crazyenglish/entity/history_homework_date.dart';
import 'package:crazyenglish/entity/home/PractiseDate.dart';

class HomeworkHistoryState {
  late HistoryHomeworkDate paperDetail;
  List<Records> list = [];
  late PractiseDate dateDetail;
  bool hasMore = true;
  int pageNo = 1;
  HomeworkHistoryState() {
    ///Initialize variables
  }
}
