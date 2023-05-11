import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/SendCodeResponseNew.dart';
import '../../../entity/base_resp.dart';
import '../../../net/net_manager.dart';
import '../../../repository/user_repository.dart';
import '../../../routes/getx_ids.dart';
import 'set_psd_state.dart';

class Set_psdLogic extends GetxController {
  final Set_psdState state = Set_psdState();
  UserRepository userRepository = UserRepository();

  void sendCode(String phone,int smsType) async {
    SendCodeResponseNew sendCodeResponse =
    await userRepository.sendCodeNew(phone,"$smsType");
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.sendCode]);
  }

  void mobileExists(String phone,int smsType) async {
    BaseResp baseResponse =
    await userRepository.mobileExists(phone);
    state.baseResponse = baseResponse;
    if(baseResponse.code == ResponseCode.status_success){
      sendCode(phone,smsType);
    } else {
      Util.toast("手机号不存在");
    }
    // update([GetBuilderIds.mobileExists]);
  }
}
