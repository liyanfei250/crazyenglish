import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:get/get.dart';

import 'answering_state.dart';

class AnsweringLogic extends GetxController {
  final AnsweringState state = AnsweringState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void updatePageStr(String pageStr){
    state.pageChangeStr = pageStr;
    update([GetBuilderIds.answerPageNum]);
  }

  void initPageStr(String initPage){
    state.pageChangeStr = initPage;
    update([GetBuilderIds.answerPageInitNum]);
  }
}
