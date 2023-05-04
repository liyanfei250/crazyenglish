import '../../../entity/HomeworkStudentResponse.dart';

class SchoolReportListState {
  List<Students> list = [];
  bool hasMore = true;
  int pageNo = 1;
  SchoolReportListState() {
    ///Initialize variables
  }
}
