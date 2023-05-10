import '../../entity/class_bottom_info.dart';

class Student_listState {
  ClassBottomInfo myClassBottom = ClassBottomInfo();
  List<Records> list = [];
  bool hasMore = true;
  int pageNo = 1;

  Student_listState() {
    ///Initialize variables
  }
}
