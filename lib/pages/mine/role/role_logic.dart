import 'package:get/get.dart';

import '../../../entity/SendCodeResponseNew.dart';
import '../../../repository/user_repository.dart';
import '../../../routes/getx_ids.dart';
import 'role_state.dart';

class RoleLogic extends GetxController {
  final RoleState state = RoleState();

  UserRepository userRepository = UserRepository();

  void setUserInfo(int identity) async {
    SendCodeResponseNew sendCodeResponse = await userRepository
        .sendChangeGrade({"identity": identity});
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.choiceRole]);
  }

}
