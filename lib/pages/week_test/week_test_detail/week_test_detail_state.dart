import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';

class WeekTestDetailState {
  WeekDetailResponse weekDetailResponse = WeekDetailResponse();
  StartExam startExam = StartExam();
  String uuid = "";
  bool enterResult = false;
  bool isOffCurrentPage = false;
  WeekTestDetailState() {
    ///Initialize variables
  }
}
