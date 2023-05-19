import 'package:crazyenglish/entity/home/PractiseDate.dart';
import 'package:crazyenglish/entity/review/PractiseHistoryDate.dart';

class HomeworkHistoryState {
  late PractiseHistoryDate paperDetail;
  List<Obj> list = [];
  late PractiseDate dateDetail;
  bool hasMore = true;
  int pageNo = 1;
  HomeworkHistoryState() {
    ///Initialize variables
  }
}
