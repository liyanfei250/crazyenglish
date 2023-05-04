import '../../../../entity/home/HomeKingDate.dart';
import '../../../../entity/home/SearchCollectListDetail.dart';
import '../../../../entity/review/CancellCollectDate.dart';
import '../../../../entity/review/CollectDate.dart';
import '../../../../entity/review/SearchCollectListDate.dart' as date;
import '../../../../entity/review/SearchRecordDate.dart';

class Collect_practicState {
  SearchRecordDate paperDetail = SearchRecordDate();
  SearchCollectListDetail ListDetail = SearchCollectListDetail();
  List<date.Obj> paperList = [];
  CollectDate collectDate = CollectDate();
  HomeKingDate tabList = HomeKingDate();
  bool hasMore = true;
  int pageNo = 1;
  Collect_practicState() {
    ///Initialize variables
  }
}
