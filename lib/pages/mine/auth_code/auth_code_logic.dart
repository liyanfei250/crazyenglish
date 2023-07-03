import 'package:get/get.dart';
import '../../../entity/SendCodeResponseNew.dart';

import '../../../repository/user_repository.dart';
import '../../../routes/getx_ids.dart';
import 'auth_code_state.dart';

class Auth_codeLogic extends GetxController {
  final Auth_codeState state = Auth_codeState();
  UserRepository userRepository = UserRepository();

  void sendResetPsd(String phone, String code, String password) async {
    SendCodeResponseNew sendCodeResponse = await userRepository
        .sendResetPsd({"phone": phone, "code": code, "password": password});
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.resetPassword]);
  }

  void sendCode(String phone,int smsType) async {
    SendCodeResponseNew sendCodeResponse =
    await userRepository.sendCodeNew(phone,"$smsType");
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.sendCode]);
  }
}
