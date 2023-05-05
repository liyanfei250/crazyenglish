import '../../../../entity/review/ErrorNoteTabDate.dart'as date;
import '../../../../entity/week_detail_response.dart';

class Error_note_child_listState {
  List<date.Obj> list = [];
  bool hasMore = true;
  int pageNo = 1;
  WeekDetailResponse weekDetailResponse = WeekDetailResponse();
  Error_note_child_listState() {
    ///Initialize variables
  }
}
