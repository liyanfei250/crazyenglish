import 'package:crazyenglish/base/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/common.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
              child: Image.asset(
            R.imagesIconHomeMeDefaultHead,
            width: 54.w,
            height: 54.w,
          )),
          SizedBox(
            height: 10.w,
          ),
          Text(_packageInfo.appName),
          SizedBox(
            height: 60.w,
          ),
          buildItemType('版本信息', _packageInfo.version),
          buildItemType('隐私协议'),
        ],
      ),
    );
  }

  Widget buildItemType(String menu, [String? second]) {
    return GestureDetector(
      onTap: () {
        //todo 具体的跳转界面

        switch (menu) {
          case '版本信息':
            Util.toast(_packageInfo.version);
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
          default:
            return null;
        }
      },
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
          margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 29.w,
              ),
              Text(
                menu,
                style: textStyle,
              ),
              SizedBox(
                width: 38.w,
              ),
              Expanded(
                child: (second != null)
                    ? Text(
                        second,
                        style: textSenStyle,
                      )
                    : Text(''),
              ),
              Image.asset(
                R.imagesHomeNextIcBlack,
                height: 7.w,
                width: 11.w,
              ),
              SizedBox(
                width: 25.w,
              ),
            ],
          )),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
