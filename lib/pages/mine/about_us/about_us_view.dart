import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/entity/check_update_resp.dart';
import 'package:crazyenglish/pages/app_update_panel/app_update_panel_logic.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/updateApp/app_upgrade.dart';
import 'package:crazyenglish/utils/updateApp/download_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'about_us_logic.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUsPage extends BasePage {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<AboutUsPage> {
  final logic = Get.put(About_usLogic());
  final state = Get.find<About_usLogic>().state;
  final appUpdatePanelLogic = Get.put(AppUpdatePanelLogic());
  final appUpdatePanelState = Get.find<AppUpdatePanelLogic>().state;
  final TextStyle textStyle = TextStyle(
      fontSize: 14, color: Color(0xff4d3535), fontWeight: FontWeight.w500);
  final TextStyle textSenStyle = TextStyle(
      fontSize: 12, color: Color(0xff898a93), fontWeight: FontWeight.w500);
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  void onClickPosition(int position) {
    switch (position) {
      case 1: //意见反馈
        RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage,
            arguments: {'isFeedback': false});
        break;
      case 2: //关于我们
        RouterUtil.toNamed(AppRoutes.AboutUsPage);
        break;
      case 6:
        RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage,
            arguments: {'isFeedback': true});
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("关于我们"),
      backgroundColor: AppColors.theme_bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 50.w)),
          Image.asset(
            R.imagesAppIcon,
            width: 70.w,
            height: 70.w,
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(_packageInfo.appName,style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 16.sp,fontWeight: FontWeight.bold)),
          SizedBox(
            height: 60.w,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
            margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildItemType('版本信息', _packageInfo.version,false),
                Divider(height: 1.0.w,color: const Color(0xFFF7F8FA),),
                buildItemType('隐私协议'),
                Divider(height: 1.0.w,color: const Color(0xFFF7F8FA),),
                buildItemType('产品介绍'),
              ],
            ),
          )


        ],
      ),
    );
  }

  Widget buildItemType(String menu, [String? second,bool isArrowVisible = true]) {
    return GestureDetector(
      onTap: () {
        //todo 具体的跳转界面

        switch (menu) {
          case '版本信息':
            addListener();
            appUpdatePanelLogic.getAppVersion();
            break;
          case '隐私协议':
            RouterUtil.toWebPage(
              C.REGISTER_PRIVACY_POLICY_LAW,
              title: "隐私保护政策",
              showStatusBar: true,
              showAppBar: true,
              showH5Title: true,
            );
            break;
          case '产品介绍':
          RouterUtil.toNamed(AppRoutes.ProductIntroPage);
            break;
          default:
            return null;
        }
      },
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left:29.w,top: 20.w, bottom: 20.w,right: 25.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                menu,
                style: textStyle,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (second != null)
                      ? Text(
                    second,
                    style: textSenStyle,
                  )
                      : Text(''),
                  Visibility(visible: isArrowVisible,
                      child: Image.asset(
                        R.imagesHomeNextIcBlack,
                        height: 7.w,
                        width: 11.w,
                      ))
                ],
              ),
            ],
          )),
    );
  }

  @override
  void onCreate() {

  }

  void addListener(){
    appUpdatePanelLogic.addListenerId(GetBuilderIds.APPVERSION, () {
      if(appUpdatePanelState.checkUpdateResp!=null
          && _packageInfo.version.compareTo(appUpdatePanelState.checkUpdateResp!.newVersion??"")<0 ){
        showAppUpgrade(appUpdatePanelState.checkUpdateResp!);
      }
    });
  }

  void showAppUpgrade(CheckUpdateResp resp){
    int forceUpdateCount = resp.forceUpdate??0;
    if (forceUpdateCount>0) {
        AppUpgrade.appUpgrade(
          context,
          resp,
          // appMarketInfo: AppMarket.huaWei,
          onCancel: () {
            print('onCancel');
          },
          onOk: () {
            print('onOk');
          },
          downloadProgress: (count, total) {
            print('count:$count,total:$total');
          },
          downloadStatusChange: (DownloadStatus status, {dynamic error}) {
            print('status:$status,error:$error');
          },
        );
    }else{
      Util.toast("当前版本已是最新");
    }
  }


  @override
  void onDestroy() {
    Get.delete<AppUpdatePanelLogic>();
    Get.delete<About_usLogic>();

  }
}
