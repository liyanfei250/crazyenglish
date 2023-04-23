import 'package:get/get.dart';

import '../../../entity/SendCodeResponseNew.dart';
import '../../../entity/login/LoginCodeResponse.dart';
import '../../../entity/login/LoginNewResponse.dart';
import '../../../entity/login_response.dart';
import '../../../entity/send_code_response.dart';
import '../../../entity/user_info_response.dart';
import '../../../repository/user_repository.dart';
import '../../../routes/getx_ids.dart';
import 'login_new_state.dart';

class Login_newLogic extends GetxController {
  final Login_newState state = Login_newState();
  UserRepository userRepository = UserRepository();

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

  void  mobileLogin(String phone, String phoneCode) async {
    LoginCodeResponse loginResponse = await userRepository
        .mobileNewLogin({"mobile": phone, "code": phoneCode});
    state.loginResponseTwo = loginResponse;
    update([GetBuilderIds.mobileLogin]);
  }

  void passwordLogin(String phone, String phoneCode) async {
    LoginNewResponse loginResponse = await userRepository
        .passwordLogin({"username": phone, "password": phoneCode});
    state.loginResponse = loginResponse;
    update([GetBuilderIds.passwordLogin]);
  }

  void sendCode(String phone) async {
    SendCodeResponseNew sendCodeResponse =
        await userRepository.sendCodeNew({"mobile": phone});
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.sendCode]);
  }

  void getUserinfo(String user) async {
    UserInfoResponse sendCodeResponse =
        await userRepository.getUserInfo(user);
    state.infoResponse = sendCodeResponse;
    update([GetBuilderIds.getUserInfo]);
  }
}
