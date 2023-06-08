import 'package:crazyenglish/entity/teacher_home_tips_response.dart';

import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/teacher_week_list_response.dart';
import '../../entity/week_list_response.dart';

class TeacherIndexState {
  HomeKingNewDate paperDetailNew = HomeKingNewDate();
  TeacherWeekListResponse myJournalDetail = TeacherWeekListResponse();
  TeacherWeekListResponse recommendJournal = TeacherWeekListResponse();
  TeacherHomeTipsResponse number = TeacherHomeTipsResponse();
  TeacherIndexState() {
    ///Initialize variables
  }
}
