import '../../entity/home/HomeMyJournalListDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/review/HomeListDate.dart';

class IndexState {
  HomeListDate paperDetail = HomeListDate();
  HomeMyJournalListDate myJournalDetail = HomeMyJournalListDate();
  HomeMyTasksDate myTask = HomeMyTasksDate();
  IndexState() {
    ///Initialize variables
  }
}
