import '../../../../entity/HomeworkStudentResponse.dart';

class StudentListState {
  List<Students> list = [];
  bool hasMore = true;
  int pageNo = 0;
  StudentListState() {
    ///Initialize variables
  }
}
