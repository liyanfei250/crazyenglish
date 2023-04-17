import '../../../entity/practice_list_response.dart';
import '../../../entity/review/HomeListChoiceDate.dart';
import '../../../entity/review/HomeSecondListDate.dart';

class Listening_practiceState {
  PracticeListResponse practiceInfoResponse = PracticeListResponse();
  HomeListChoiceDate paperDetail = HomeListChoiceDate();
  HomeSecondListDate homeSecondListDate = HomeSecondListDate();
  bool hasMore = true;
  int pageNo = 0;
  Listening_practiceState() {
    ///Initialize variables
  }
}
