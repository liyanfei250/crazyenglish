import 'package:get/get.dart';

import '../../../entity/SendCodeResponseNew.dart';
import '../../../repository/user_repository.dart';
import '../../../routes/getx_ids.dart';
import 'set_psd_state.dart';

class Set_psdLogic extends GetxController {
  final Set_psdState state = Set_psdState();
  UserRepository userRepository = UserRepository();

  void sendCode(String phone) async {
    SendCodeResponseNew sendCodeResponse =
    await userRepository.sendCodeNew({"mobile": phone});
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.sendCode]);
  }
}
