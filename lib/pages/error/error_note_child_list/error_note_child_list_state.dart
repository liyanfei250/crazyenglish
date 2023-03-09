import '../../../entity/error_note_response.dart' as errorData;
import '../../../entity/week_detail_response.dart';

class Error_note_child_listState {
  List<errorData.Rows> list = [];
  bool hasMore = true;
  int pageNo = 0;
  WeekDetailResponse weekTestDetailResponse = WeekDetailResponse();
  Error_note_child_listState() {
    ///Initialize variables
  }
}
