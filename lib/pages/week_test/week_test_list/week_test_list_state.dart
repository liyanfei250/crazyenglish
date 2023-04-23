import '../../../entity/home/HomeKingDate.dart';
import '../../../entity/review/HomeWeeklyChoiceDate.dart';
import '../../../entity/week_list_response.dart' as Date;

class WeekTestListState {

  List<Date.Obj> list = [];
  bool hasMore = true;
  int pageNo = 0;
  HomeWeeklyChoiceDate paperDetail = HomeWeeklyChoiceDate();
  HomeKingDate paperDetailNew = HomeKingDate();
  WeekTestListState() {
    ///Initialize variables
  }
}
