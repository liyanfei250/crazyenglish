import 'package:get/get.dart';

import '../../entity/commit_request.dart';
import '../../repository/week_test_repository.dart';
import '../../routes/getx_ids.dart';
import 'writing_state.dart';

class WritingLogic extends GetxController {
  final WritingState state = WritingState();
  final WeekTestRepository weekTestRepository = WeekTestRepository();
  void uploadWritingTest(CommitRequest commitRequest) async{
    CommitRequest commitResponse = await weekTestRepository.uploadWeekTest(commitRequest);
    state.commitRequest = commitResponse;
    update([GetBuilderIds.commitAnswerWriting]);
  }
}
