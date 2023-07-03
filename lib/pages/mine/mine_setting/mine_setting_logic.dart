import 'package:crazyenglish/repository/user_repository.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:get/get.dart';

import 'mine_setting_state.dart';

class Mine_settingLogic extends GetxController {
  final Mine_settingState state = Mine_settingState();
  UserRepository userRepository = UserRepository();


  void delRemoveInfo(){

    // GetBuilderIds.delRemoveInfo
    userRepository.delRemoveInfo();
    update([GetBuilderIds.delRemoveInfo]);
  }
}
