import 'package:crazyenglish/entity/QuestionListResponse.dart';
import '../../../../entity/review/HomeSecondListDate.dart' as listDate;
class QuestionListState {
  List<Questions> list = [];
  bool hasMore = true;
  int pageNo = 1;
  List<listDate.Obj> homeSecondListDate =[];
  QuestionListState() {
    ///Initialize variables
  }
}
