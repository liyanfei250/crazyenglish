import '../../../entity/practice_list_response.dart';
import '../../../entity/review/HomeListChoiceDate.dart';
import '../../../entity/review/HomeSecondListDate.dart' as listDate;

class Listening_practiceState {
  PracticeListResponse practiceInfoResponse = PracticeListResponse();
  HomeListChoiceDate paperDetail = HomeListChoiceDate();
  List<listDate.Obj> homeSecondListDate =[];
  bool hasMore = true;
  int pageNo = 0;
  Listening_practiceState() {
    ///Initialize variables
  }
}
