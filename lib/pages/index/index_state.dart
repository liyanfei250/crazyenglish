import '../../entity/home/HomeKingDate.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyJournalListDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/review/HomeListDate.dart';

class IndexState {
  HomeKingDate paperDetail = HomeKingDate();
  HomeKingNewDate paperDetailNew = HomeKingNewDate();
  HomeMyJournalListDate myJournalDetail = HomeMyJournalListDate();
  HomeMyTasksDate myTask = HomeMyTasksDate();
  IndexState() {
    ///Initialize variables
  }
}
