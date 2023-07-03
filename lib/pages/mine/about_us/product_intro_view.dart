import 'package:crazyenglish/base/AppUtil.dart';
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

class ProductIntroPage extends BasePage {
  const ProductIntroPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ProductIntroPageState();
}

class _ProductIntroPageState extends BasePageState<ProductIntroPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("产品介绍"),
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
            height: 65.w,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.w),
            child: Text("       “数字英语”APP是英语周报数字化融媒体平台，是一款基于数字化的英语学习平台，该平台围绕周报内容课程化、教师教案工具化和用户体验智能化等内容，真正实现人机交互的学习方式。使学习者和教师能够更加便捷、高效、个性化的学习或教学，提升英语学习和教学的效果。",
            style: TextStyle(color: AppColors.c_FF898A93,fontSize: 14.sp),
            ),
          )


        ],
      ),
    );
  }

  Widget buildItemType(String menu, [String? second]) {
    return GestureDetector(
      onTap: () {
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
          case '产品介绍':
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
