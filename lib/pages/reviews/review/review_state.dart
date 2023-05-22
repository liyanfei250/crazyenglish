import '../../../entity/home/HomeKingDate.dart';
import '../../../entity/review/ReviewHomeDetail.dart';

class ReviewState {
  late ReviewHomeDetail paperDetail;
  late HomeKingDate tabList;
  int cumulativeExercise = 0;
  int todayExercise = 0;
  int cumulativeError = 0;
  int correct = 0;
  int collected = 0;
  int histoty = 0;
  int practiceRecord = 0;
  ReviewState() {
    ///Initialize variables
  }
}
