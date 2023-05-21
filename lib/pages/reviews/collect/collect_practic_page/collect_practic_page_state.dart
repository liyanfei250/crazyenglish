import '../../../../entity/home/HomeKingDate.dart';
import '../../../../entity/home/SearchCollectListDetail.dart';
import '../../../../entity/review/SearchCollectListDate.dart' as date;
import '../../../../entity/review/SearchRecordDate.dart';
class Collect_practic_pageState {
  SearchRecordDate paperDetail = SearchRecordDate();
  SearchCollectListDetail ListDetail = SearchCollectListDetail();
  List<date.Obj> paperList = [];
  bool hasMore = true;
  int pageNo = 1;
  Map<String,bool> collectMap = {};
  Collect_practic_pageState() {
    ///Initialize variables
  }
}
