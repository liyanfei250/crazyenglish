import '../../../../entity/review/SearchCollectListDate.dart';
import '../../../../entity/review/SearchRecordDate.dart';

class Collect_practicState {
  SearchRecordDate paperDetail = SearchRecordDate();
  SearchCollectListDate paperList = SearchCollectListDate();
  bool hasMore = true;
  int pageNo = 0;
  Collect_practicState() {
    ///Initialize variables
  }
}
