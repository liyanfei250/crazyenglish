import 'package:get/get.dart';

import '../../entity/practice_list_response.dart';
import '../../routes/getx_ids.dart';
import '../error/error_note_child_list/ErrorNoteRepository.dart';
import 'practtise_history_state.dart';

class Practtise_historyLogic extends GetxController {
  final Practtise_historyState state = Practtise_historyState();

  ErrorNoteRepository resposi = ErrorNoteRepository();

  void getPracCords(page, pageSize) async {
    PracticeListResponse sendCodeResponse =
    await resposi.getPracticerecords(page, pageSize);
    if(sendCodeResponse.data!=null&&sendCodeResponse.data!.rows!=null){
      state.list = sendCodeResponse.data!.rows!;
    }
    if(sendCodeResponse.data!=null&&sendCodeResponse.data!.exercisesTotal!=null){
      state.totalNum = sendCodeResponse.data!.exercisesTotal!.toInt();
    }
    state.pageNo = page;
    update([GetBuilderIds.getPracticeList]);
  }
}
