import 'package:flutter/material.dart';
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
      body: Container(
          child: ElevatedButton(
        onPressed: () {
          //退出
          SpUtil.putBool(BaseConstant.ISLOGING, false);
          SpUtil.putString(BaseConstant.loginTOKEN, '');
          //直接去首页
          RouterUtil.offAndToNamed(AppRoutes.HOME);
        },
        child: const Text(
          '退出登录',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        style: ButtonStyle(
          //去除阴影
          elevation: MaterialStateProperty.all(0),
          //将按钮背景设置为透明
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
      )),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
