import 'package:get/get.dart';

import '../../../entity/home/HomeKingDate.dart';
import '../../../../entity/review/HomeSecondListDate.dart' as listDate;
class ChooseQuestionState {
  late HomeKingDate tabList;
  HomeKingDate paperDetail = HomeKingDate();
  dynamic affiliatedGrade = null;
  dynamic dictionaryId = null;
  int selectedIndex = -1;
  int pageSize =20;
  int pageStartIndex =1;
  late List<String> items = [];
  var choiceText = "全部".obs;


  bool hasMore = true;
  int pageNo = 1;
  List<listDate.Obj> homeSecondListDate =[];
  List<listDate.CatalogueRecordVoList> homeFinalListDate =[];

  ChooseQuestionState() {
    ///Initialize variables
  }
}
