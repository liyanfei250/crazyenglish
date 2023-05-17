import 'package:crazyenglish/blocs/login_change_bloc.dart';
import 'package:crazyenglish/blocs/login_change_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void onCreate() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("设置"),
        backgroundColor: AppColors.theme_bg,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if(isLogin){
              showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("提示"),
                    content: Text("您确定要退出吗？"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("取消"),
                        onPressed: () => Navigator.of(context).pop(), // 关闭对话框
                      ),
                      TextButton(
                        child: Text("确定"),
                        onPressed: () {
                          Navigator.of(context).pop(true); //关闭对话框
                          // ... 执行
                          //退出
                          SpUtil.putBool(BaseConstant.ISLOGING, false);
                          SpUtil.putString(BaseConstant.loginTOKEN, '');
                          SpUtil.putString(BaseConstant.USER_NAME, '');
                          BlocProvider.of<LoginChangeBloc>(context)
                              .add(SendLoginChangeEvent());
                          //直接去首页
                          Get.back();

                        },
                      ),
                    ],
                  );
                },
              );
            }else{
              RouterUtil.toNamed(AppRoutes.LoginNew);
            }
          },
          child: Container(
            height: 47.w,
            margin: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                color: AppColors.THEME_COLOR,
                borderRadius: const BorderRadius.all(Radius.circular(22))),
            child: Center(
              child: Text(
                isLogin? "退出登录":"登录",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ));
  }


  @override
  void onDestroy() {}
}
