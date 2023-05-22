import 'package:crazyenglish/entity/home/banner.dart';
import 'package:crazyenglish/entity/teacher_week_list_response.dart';

import '../../entity/home/HomeKingDate.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/review/HomeListDate.dart';
import '../../entity/week_list_response.dart';

class IndexState {
  HomeKingDate paperDetail = HomeKingDate();
  HomeKingNewDate paperDetailNew = HomeKingNewDate();
  Banner banner = Banner();
  TeacherWeekListResponse myJournalDetail = TeacherWeekListResponse();
  HomeMyTasksDate myTask = HomeMyTasksDate();
  IndexState() {
    ///Initialize variables
  }
}
