import 'package:crazyenglish/entity/home/PractiseDate.dart';

import '../../../entity/review/PractiseHistoryDate.dart';

class Practise_historyState {
  late PractiseHistoryDate paperDetail;
  List<Obj> list = [];
  late PractiseDate dateDetail;
  bool hasMore = true;
  int pageNo = 1;
  Practise_historyState() {
    ///Initialize variables
  }
}
