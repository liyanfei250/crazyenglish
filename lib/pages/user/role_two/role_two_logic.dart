import 'package:get/get.dart';

import '../../../entity/SendCodeResponseNew.dart';
import '../../../repository/user_repository.dart';
import '../../../routes/getx_ids.dart';
import 'role_two_state.dart';

class Role_twoLogic extends GetxController {
  final Role_twoState state = Role_twoState();
  UserRepository userRepository = UserRepository();
  void setUserInfo(int identity,int grade) async {
    SendCodeResponseNew sendCodeResponse = await userRepository
        .sendChangeGrade({"identity": identity,"grade":grade});
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.choiceRole]);
  }

}
