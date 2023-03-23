import 'package:crazyenglish/entity/SendCodeResponseNew.dart';

import '../../../entity/login/LoginCodeResponse.dart';
import '../../../entity/login/LoginNewResponse.dart';
import '../../../entity/send_code_response.dart';
import '../../../entity/user_info_response.dart';

class Login_newState {
  late LoginNewResponse loginResponse;
  late LoginCodeResponse loginResponseTwo;
  SendCodeResponseNew sendCodeResponse = SendCodeResponseNew();
  UserInfoResponse infoResponse = UserInfoResponse();

  LoginState() {
    ///Initialize variables
    loginResponse = LoginNewResponse();
    loginResponseTwo = LoginCodeResponse();
  }
}
