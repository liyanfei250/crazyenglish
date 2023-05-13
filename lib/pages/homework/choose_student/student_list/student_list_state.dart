import '../../../../entity/HomeworkStudentResponse.dart';
import '../../../../entity/member_student_list.dart';
class StudentListState {
  List<Obj> myStudentList = [];
  bool hasMore = true;
  int pageNo = 1;
  StudentListState() {
    ///Initialize variables
  }
}
