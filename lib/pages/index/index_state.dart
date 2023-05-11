import '../../entity/home/HomeKingDate.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/review/HomeListDate.dart';
import '../../entity/week_list_response.dart';

class IndexState {
  HomeKingDate paperDetail = HomeKingDate();
  HomeKingNewDate paperDetailNew = HomeKingNewDate();
  WeekListResponse myJournalDetail = WeekListResponse();
  HomeMyTasksDate myTask = HomeMyTasksDate();
  IndexState() {
    ///Initialize variables
  }
}
