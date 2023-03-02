import '../../../entity/login/LoginCodeResponse.dart';
import '../../../entity/login/LoginNewResponse.dart';
import '../../../entity/send_code_response.dart';

class Login_newState {
  late LoginNewResponse loginResponse;
  late LoginCodeResponse loginResponseTwo;
  SendCodeResponse sendCodeResponse = SendCodeResponse();

  LoginState() {
    ///Initialize variables
    loginResponse = LoginNewResponse();
    loginResponseTwo = LoginCodeResponse();
  }
}
