import 'package:crazyenglish/entity/QuestionListResponse.dart';
import '../../../../entity/review/HomeSecondListDate.dart' as listDate;
class QuestionListState {
  bool hasMore = true;
  int pageNo = 1;
  List<listDate.Obj> homeSecondListDate =[];
  List<listDate.CatalogueRecordVoList> homeFinalListDate =[];
  QuestionListState() {
    ///Initialize variables
  }
}
