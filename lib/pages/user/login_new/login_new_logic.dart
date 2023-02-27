import 'package:get/get.dart';

import '../../../entity/login_response.dart';
import '../../../entity/send_code_response.dart';
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


  void mobileLogin(String phone,String phoneCode) async{
    LoginResponse loginResponse = await userRepository.mobileLogin(
        {"mobile" : phone ,
          "code" : phoneCode ,
          "requestType" : "app"});
    state.loginResponse = loginResponse;
    update([GetBuilderIds.mobileLogin]);
  }



  void qqLogin(Map<String,String> req) async{
    req.addAll({"type":"0"});
    LoginResponse loginResponse = await userRepository.quickLogin(req);
    state.loginResponse = loginResponse;
    update([GetBuilderIds.quickLogin]);
  }

  void weixinLogin(Map<String,String> req) async{
    req.addAll({"type":"1"});
    LoginResponse loginResponse = await userRepository.quickLogin(req);
    state.loginResponse = loginResponse;
    update([GetBuilderIds.quickLogin]);
  }

  void sinaLogin(Map<String,String> req) async{
    req.addAll({"type":"4"});
    LoginResponse loginResponse = await userRepository.quickLogin(req);
    state.loginResponse = loginResponse;
    update([GetBuilderIds.quickLogin]);
  }

  void appleLogin(Map<String,String> req) async{
    req.addAll({"type":"5"});
    LoginResponse loginResponse = await userRepository.quickLogin(req);
    state.loginResponse = loginResponse;
    update([GetBuilderIds.quickLogin]);
  }

  void sendCode(String phone) async {
    SendCodeResponse sendCodeResponse = await userRepository.sendCode(phone);
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.sendCode]);
  }

  void getMobile() async{
    LoginResponse loginResponse = await userRepository.quickLogin({});
    state.loginResponse = loginResponse;
    update([GetBuilderIds.quickLogin]);
  }
}
