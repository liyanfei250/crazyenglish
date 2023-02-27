import '../../../entity/login_response.dart';
import '../../../entity/send_code_response.dart';

class Login_newState {
  late LoginResponse loginResponse;
  SendCodeResponse sendCodeResponse = SendCodeResponse();

  LoginState() {
    ///Initialize variables
    loginResponse = LoginResponse();
  }
}
