import 'package:crazyenglish/repository/user_repository.dart';
import 'package:get/get.dart';

import '../../../entity/SendCodeResponseNew.dart';
import '../../../entity/home/CommentDate.dart';
import '../../../routes/getx_ids.dart';
import '../../index/HomeViewRepository.dart';
import 'change_phone_state.dart';

class Change_phoneLogic extends GetxController {
  final Change_phoneState state = Change_phoneState();
  UserRepository recordData = UserRepository();

  void toChangePhoneNum(String id) async {
    CommentDate collectResponse =
        await recordData.toChangePhoneNum({"mobile": id});
    state.pushDate = collectResponse;
    update([GetBuilderIds.toChangePhoneNumber]);
  }



  void sendCode(String phone,int type) async {
    SendCodeResponseNew sendCodeResponse =
        await recordData.sendCodeNew(phone,"$type");
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.sendCode]);
  }
}
