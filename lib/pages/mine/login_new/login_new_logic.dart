import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/SendCodeResponseNew.dart';
import '../../../entity/login/LoginNewResponse.dart';
import '../../../entity/user_info_response.dart';
import '../../../net/net_manager.dart';
import '../../../repository/user_repository.dart';
import '../../../routes/getx_ids.dart';
import 'login_new_state.dart';

class Login_newLogic extends GetxController {
  final Login_newState state = Login_newState();
  UserRepository userRepository = UserRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void  mobileLogin(String phone, String phoneCode) async {
    LoginNewResponse loginResponse = await userRepository
        .passwordLogin({"username": phone, "code": phoneCode,"type": "1"});

    if(state.loginResponse.code
        == ResponseCode.status_success){
      state.loginResponse = loginResponse;
      update([GetBuilderIds.mobileLogin]);
    } else {
      Util.toast("${state.loginResponse.message}");
    }

  }

  void updateNativeUserInfo(UserInfoResponse infoResponse){
    SpUtil.putInt(BaseConstant.USER_ID, infoResponse.obj!.id!.toInt());
    SpUtil.putString(BaseConstant.USER_NAME, infoResponse.obj!.username);
    SpUtil.putString(BaseConstant.NICK_NAME, infoResponse.obj!.nickname);
    SpUtil.putBool(BaseConstant.ISLOGING, true);
    SpUtil.putObject(BaseConstant.USER_INFO, infoResponse);
  }

  void passwordLogin(String phone, String phoneCode) async {
    LoginNewResponse loginResponse = await userRepository
        .passwordLogin({"username": phone, "password": phoneCode,"type": "0"});
    state.loginResponse = loginResponse;
    update([GetBuilderIds.passwordLogin]);
  }

  void sendCode(String phone,int smsType) async {
    SendCodeResponseNew sendCodeResponse =
        await userRepository.sendCodeNew(phone,"$smsType");
    if(sendCodeResponse.code
        == ResponseCode.status_success){
      state.sendCodeResponse = sendCodeResponse;
      update([GetBuilderIds.sendCode]);
    } else {
      Util.toast("${sendCodeResponse.message}");
    }

  }

  void getUserinfo(String user) async {
    UserInfoResponse sendCodeResponse =
        await userRepository.getUserInfo(user);
    if(state.loginResponse.code
        == ResponseCode.status_success){
      state.infoResponse = sendCodeResponse;
      update([GetBuilderIds.getUserInfo]);
    } else {
      Util.toast("${state.loginResponse.message}");
    }
  }


}
