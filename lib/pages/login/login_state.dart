import '../../entity/login_response.dart';
import '../../entity/send_code_response.dart';

class LoginState {
  late LoginResponse loginResponse;
  SendCodeResponse sendCodeResponse = SendCodeResponse("");

  LoginState() {
    ///Initialize variables
    loginResponse = LoginResponse();
  }
}
