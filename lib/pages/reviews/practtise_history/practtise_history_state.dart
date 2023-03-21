import '../../../entity/practice_list_response.dart';
import '../../../entity/week_detail_response.dart';

class Practtise_historyState {
  List<Rows> list = [];
  bool hasMore = true;
  int pageNo = 0;
  int totalNum = 0;
  WeekDetailResponse weekTestDetailResponse =  WeekDetailResponse();
  Practtise_historyState() {
    ///Initialize variables
  }
}
