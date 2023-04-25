import '../../../../entity/home/SearchCollectListDetail.dart';
import '../../../../entity/review/CancellCollectDate.dart';
import '../../../../entity/review/CollectDate.dart';
import '../../../../entity/review/SearchCollectListDate.dart';
import '../../../../entity/review/SearchRecordDate.dart';

class Collect_practicState {
  SearchRecordDate paperDetail = SearchRecordDate();
  SearchCollectListDetail ListDetail = SearchCollectListDetail();
  SearchCollectListDate paperList = SearchCollectListDate();
  CollectDate collectDate = CollectDate();
  CancellCollectDate cancellCollectDate = CancellCollectDate();
  bool hasMore = true;
  int pageNo = 0;
  Collect_practicState() {
    ///Initialize variables
  }
}
