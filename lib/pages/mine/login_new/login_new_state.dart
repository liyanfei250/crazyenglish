import 'package:crazyenglish/entity/SendCodeResponseNew.dart';
import 'package:crazyenglish/entity/user_info_response.dart';

import '../../../entity/login/LoginNewResponse.dart';

class Login_newState {
  late LoginNewResponse loginResponse;
  SendCodeResponseNew sendCodeResponse = SendCodeResponseNew();
  UserInfoResponse infoResponse = UserInfoResponse();

  LoginState() {
    ///Initialize variables
    loginResponse = LoginNewResponse();
  }
}
