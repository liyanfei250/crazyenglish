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
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  void getAppUserInfo() async {
    UserInfoResponse infoResponse = await weekTestRepository
        .getUserInfo();
    state.infoResponse = infoResponse;
    update([GetBuilderIds.getUserInfo]);
  }


  void getAppVersion() async {
    CheckUpdateResp checkUpdateResp = await weekTestRepository.getAppVersion();
    String newVersion = "";
    String publishDate = "0";
    String updateDescription= "";
    bool isUpdate = false;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version= packageInfo.version;
    if(checkUpdateResp!=null){
          // CheckUpdateResp checkUpdateResp = CheckUpdateResp(
          //     apkUrl:"https://ps-1252082677.cos.ap-beijing.myqcloud.com/app-release.apk",
          //     newVersion:newVersion,
          //     publishDate:publishDate,
          //     updateDescription: updateDescription,
          //     forceUpdate:false,
          //     apkSize: 10000,
          //     isUpdate: isUpdate
          // );
          state.checkUpdateResp = checkUpdateResp;
          update([GetBuilderIds.APPVERSION]);
    }

  }
}
