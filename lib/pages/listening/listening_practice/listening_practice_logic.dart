import 'package:crazyenglish/pages/error/error_note_child_list/ErrorNoteRepository.dart';
import 'package:get/get.dart';

import '../../../entity/practice_list_response.dart';
import '../../../routes/getx_ids.dart';
import 'listening_practice_state.dart';

class Listening_practiceLogic extends GetxController {
  final Listening_practiceState state = Listening_practiceState();
  ErrorNoteRepository resposi = ErrorNoteRepository();

  void getPracCords(page, pageSize) async {
    PracticeListResponse sendCodeResponse =
        await resposi.getPracticerecords(page, pageSize);
    state.practiceInfoResponse = sendCodeResponse;
    update([GetBuilderIds.getPracticeList]);
  }
}
