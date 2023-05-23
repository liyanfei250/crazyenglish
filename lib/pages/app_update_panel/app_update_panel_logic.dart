import 'package:crazyenglish/entity/check_update_resp.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import '../../api/api.dart';
import '../../entity/SendCodeResponseNew.dart';
import '../../entity/base_resp.dart';
import '../../entity/user_info_response.dart';
import '../../net/net_manager.dart';
import '../../repository/week_test_repository.dart';
import '../../routes/getx_ids.dart';
import 'app_update_panel_state.dart';

class AppUpdatePanelLogic extends GetxController {
  final AppUpdatePanelState state = AppUpdatePanelState();
  final WeekTestRepository weekTestRepository = WeekTestRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void getAppUserInfo() async {
    // UserInfoResponse infoResponse = await weekTestRepository
    //     .getUserInfo();
    // state.infoResponse = infoResponse;
    // update([GetBuilderIds.getUserInfo]);
  }


  void getAppVersion() async {
    CheckUpdateResp checkUpdateResp = await weekTestRepository.getAppVersion();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if(checkUpdateResp!=null){
    state.checkUpdateResp = checkUpdateResp;
    update([GetBuilderIds.APPVERSION]);
    }

  }
}
