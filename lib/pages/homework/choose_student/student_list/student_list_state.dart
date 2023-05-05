import '../../../../entity/HomeworkStudentResponse.dart';

class StudentListState {
  List<Students> list = [];
  bool hasMore = true;
  int pageNo = 1;
  StudentListState() {
    ///Initialize variables
  }
}
