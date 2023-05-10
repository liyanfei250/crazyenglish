import '../../entity/student_work_list_response.dart';

class Watting_pushState {
  StudentWorkListResponse workList = StudentWorkListResponse();
  List<Obj> list = [];
  bool hasMore = true;
  int pageNo = 1;
  Watting_pushState() {
    ///Initialize variables
  }
}
