import '../../../entity/review/HomeWeeklyChoiceDate.dart';
import '../../../entity/week_list_response.dart';

class WeekTestListState {

  List<Rows> list = [];
  bool hasMore = true;
  int pageNo = 0;
  HomeWeeklyChoiceDate paperDetail = HomeWeeklyChoiceDate();
  WeekTestListState() {
    ///Initialize variables
  }
}
