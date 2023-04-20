import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:get/get.dart';

import '../../../entity/commit_request.dart';
import '../../../repository/week_test_repository.dart';
import 'answering_state.dart';

class AnsweringLogic extends GetxController {
  final AnsweringState state = AnsweringState();
  final WeekTestRepository weekTestRepository = WeekTestRepository();

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

  void uploadWeekTest(CommitAnswer commitRequest) async{
    CommitAnswer commitResponse = await weekTestRepository.uploadWeekTest(commitRequest);
    state.commitAnswer = commitResponse;
    update([GetBuilderIds.commitAnswer]);
  }
}
