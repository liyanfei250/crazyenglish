import 'package:crazyenglish/entity/check_update_resp.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

import '../../entity/week_test_detail_response.dart';
import '../../repository/week_test_repository.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
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

  void getAppVersion() async {
    WeekTestDetailResponse list = await weekTestRepository.getAppVersion();
    String newVersion = "";
    String publishDate = "0";
    String updateDescription= "";
    bool isUpdate = false;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version= packageInfo.version;
    if(list!=null && list.data!=null && list.data!.length>0){
      String parseString = list.data![0].name??"";
      // parseString = "100;2022-1-11;1. asdfsd \n 2. asdfsd;";
      if(parseString.isNotEmpty){
        List<String> list = parseString.split(";");
        if(list.length>2){
          newVersion = list[0];
          publishDate = list[1];
          updateDescription = list[2];
          if(newVersion.compareTo(version) >0){
            isUpdate = true;
          }else{
            isUpdate = false;
          }
          CheckUpdateResp checkUpdateResp = CheckUpdateResp(
              apkUrl:"https://ps-1252082677.cos.ap-beijing.myqcloud.com/app-release.apk",
              newVersion:newVersion,
              publishDate:publishDate,
              updateDescription: updateDescription,
              forceUpdate:false,
              apkSize: 10000,
              isUpdate: isUpdate
          );
          state.checkUpdateResp = checkUpdateResp;
          update([GetBuilderIds.APPVERSION]);
        }
      }
    }

  }
}
