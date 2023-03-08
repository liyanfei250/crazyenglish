import '../../../entity/error_note_response.dart' as errorData;

class Error_note_child_listState {
  List<errorData.Rows> list = [];
  bool hasMore = true;
  int pageNo = 0;
  Error_note_child_listState() {
    ///Initialize variables
  }
}
