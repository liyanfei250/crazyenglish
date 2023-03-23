import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../utils/sp_util.dart';
import 'mine_setting_logic.dart';

class SettingPage extends BasePage {
  const SettingPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMySettingPageState();
}

class _ToMySettingPageState extends BasePageState<SettingPage> {
  final logic = Get.put(Mine_settingLogic());
  final state = Get.find<Mine_settingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("设置"),
        backgroundColor: AppColors.theme_bg,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            //退出
            SpUtil.putBool(BaseConstant.ISLOGING, false);
            SpUtil.putString(BaseConstant.loginTOKEN, '');
            //直接去首页
            RouterUtil.offAndToNamed(AppRoutes.HOME);
          },
          child: Container(
            height: 47.w,
            margin: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                color: AppColors.THEME_COLOR,
                borderRadius: const BorderRadius.all(Radius.circular(22))),
            child: const Center(
              child: Text(
                "退出登录",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ));
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
