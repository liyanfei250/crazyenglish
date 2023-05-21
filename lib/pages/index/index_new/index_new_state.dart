import 'package:crazyenglish/entity/home/HomeKingDate.dart';
import 'package:crazyenglish/entity/home/HomeKingNewDate.dart';
import 'package:crazyenglish/entity/home/HomeMyTasksDate.dart';
import 'package:crazyenglish/entity/week_list_response.dart';

class Index_newState {
  HomeKingDate paperDetail = HomeKingDate();
  HomeKingNewDate paperDetailNew = HomeKingNewDate();
  WeekListResponse myJournalDetail = WeekListResponse();
  HomeMyTasksDate myTask = HomeMyTasksDate();
  Index_newState() {
    ///Initialize variables
  }
}
