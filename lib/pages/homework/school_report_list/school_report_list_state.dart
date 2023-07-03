import '../../../entity/HomeworkStudentResponse.dart';

class SchoolReportListState {
  List<Records> list = [];
  bool hasMore = true;
  int pageNo = 1;
  SchoolReportListState() {
    ///Initialize variables
  }
}
