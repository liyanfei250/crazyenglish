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
        body: Column(
          children: [
            const Divider(height: 1),
            _buildItem(context, "账户注销与停用", "",onTap: (){
              showNotVipDialog();
            }),
            GestureDetector(
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
            )
          ],
        ));
  }

  Widget _buildItem(
      BuildContext context, String title, String linkTo,
      {VoidCallback? onTap}) =>
      ListTile(
        title: Stack(
          children: [
            Text(title),
          ],
        ),
        trailing:
        Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
        onTap: () {
          if (linkTo.isNotEmpty) {
            RouterUtil.toNamed(linkTo);
          }
          if (onTap != null) onTap();
        },
      );



  void showNotVipDialog(){
    String content = "您当前的账户情况暂不满足自助注销条件，为了您的账户安全，可采用下面两种方式进行账户注销\n 1. 发送邮件：fkyy_develop@163.com ，并提供您'数字英语'App 账户登录用户名和密码，我们会在24小时内处理并回复!\n 2. 联系客服（13901119887）申请注销账户";
    Get.defaultDialog(
      title: "温馨提示",
      content:Text(content,
        style: TextStyle(color: AppColors.TEXT_COLOR,fontSize: 15.sp),),
      cancel: InkWell(
        onTap: (){
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          width: 200.w,
          height: 30.w,
          margin: EdgeInsets.only(left: 10.w,bottom: 15.w),
          decoration: BoxDecoration(
            color: AppColors.c_FFFFFFFF,
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            //设置四周边框
            border: Border.all(width: 0.5, color: AppColors.THEME_COLOR),
          ),
          child: Text("知道了，去打电话(或发邮件)",style: TextStyle(color: AppColors.THEME_COLOR,fontSize: 13.sp),),
        ),
      ),
    );
  }

  @override
  void onDestroy() {}
}
