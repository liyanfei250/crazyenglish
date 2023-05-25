import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/blocs/login_change_bloc.dart';
import 'package:crazyenglish/blocs/login_change_event.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
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
  TextEditingController? _phoneController;
  String willDeleteUser = "";
  @override
  void onCreate() {
    _phoneController = TextEditingController();
    logic.addListenerId(GetBuilderIds.delRemoveInfo, () {
      // ... 执行
      //退出
      SpUtil.putBool(BaseConstant.ISLOGING, false);
      SpUtil.putString(BaseConstant.loginTOKEN, '');
      SpUtil.putString(BaseConstant.USER_NAME, '');
      BlocProvider.of<LoginChangeBloc>(context)
          .add(SendLoginChangeEvent());
      //直接去首页
      Get.back();
    });
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
              if(Util.isLogin()){
                showNotVipDialog();
              }else{
                Util.toast("登录后才能注销账户");
              }
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
    String content = "您确定要注销账户吗？注销账户将从此设备中删除您的个人数据。请确保在注销前备份您的数据";
    Get.defaultDialog(
      title: "温馨提示",
      content:Text(content,
        style: TextStyle(color: AppColors.TEXT_COLOR,fontSize: 15.sp),),
      confirm: InkWell(
        onTap: (){
          Get.back();
          showRemoveDialog();
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 30.w,
          margin: EdgeInsets.only(right: 10.w,bottom: 15.w),
          decoration: BoxDecoration(
            color: AppColors.THEME_COLOR,
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            //设置四周边框
            border: Border.all(width: 0.5, color: AppColors.THEME_COLOR),
          ),
          child: Text("去注销",style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 13.sp),),
        ),
      ),
      cancel: InkWell(
        onTap: (){
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 30.w,
          margin: EdgeInsets.only(left: 10.w,bottom: 15.w),
          decoration: BoxDecoration(
            color: AppColors.c_FFFFFFFF,
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            //设置四周边框
            border: Border.all(width: 0.5, color: AppColors.THEME_COLOR),
          ),
          child: Text("知道了",style: TextStyle(color: AppColors.THEME_COLOR,fontSize: 13.sp),),
        ),
      ),
    );
  }

  // delRemoveInfo

  Future<void> showRemoveDialog() async{
    String content = "请输入您的用户名进行注销";
    Get.defaultDialog(
      title: "确认用户名注销",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content,
            style: TextStyle(color: AppColors.TEXT_COLOR,fontSize: 15.sp),),
          Padding(padding: EdgeInsets.only(top: 10.w)),
          Container(
            width: 329.w,
            height: 47.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                color: AppColors.c_4DD9D9D9),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _phoneController,
              style: TextStyle(fontSize: 15, color: Color(0xff32374e)),
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String str) {
                willDeleteUser = str;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '请输入登录用户名注销账户',
                hintStyle:
                TextStyle(fontSize: 15, color: Color(0xff717171)),
              ),
            ),
          ),
        ],
      ),
      confirm: InkWell(
        onTap: (){
          if(willDeleteUser.isEmpty || willDeleteUser != SpUtil.getString(BaseConstant.USER_NAME)){
            Util.toast("用户名输入有误");
          }if(willDeleteUser == "guest"){
            Util.toast("游客账户不支持注销");
          }else{
            Get.back();
            showEnsureRemoveDialog();
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 30.w,
          margin: EdgeInsets.only(right: 10.w,bottom: 15.w),
          decoration: BoxDecoration(
            color: AppColors.THEME_COLOR,
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            //设置四周边框
            border: Border.all(width: 0.5, color: AppColors.THEME_COLOR),
          ),
          child: Text("注销",style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 13.sp),),
        ),
      ),
      cancel: InkWell(
        onTap: (){
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 30.w,
          margin: EdgeInsets.only(left: 10.w,bottom: 15.w),
          decoration: BoxDecoration(
            color: AppColors.c_FFFFFFFF,
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            //设置四周边框
            border: Border.all(width: 0.5, color: AppColors.THEME_COLOR),
          ),
          child: Text("放弃注销",style: TextStyle(color: AppColors.THEME_COLOR,fontSize: 13.sp),),
        ),
      ),
    );
  }



  Future<void> showEnsureRemoveDialog() async{
    String content = "注销后将会退出登录，并清除用户信息！\n 是否注销";
    Get.defaultDialog(
      title: "确认注销",
      content: Text(content,
        style: TextStyle(color: AppColors.TEXT_COLOR,fontSize: 15.sp),),
      confirm: InkWell(
        onTap: (){
          Get.back();
          logic.delRemoveInfo();
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 30.w,
          margin: EdgeInsets.only(right: 10.w,bottom: 15.w),
          decoration: BoxDecoration(
            color: AppColors.THEME_COLOR,
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            //设置四周边框
            border: Border.all(width: 0.5, color: AppColors.THEME_COLOR),
          ),
          child: Text("确认",style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 13.sp),),
        ),
      ),
      cancel: InkWell(
        onTap: (){
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 30.w,
          margin: EdgeInsets.only(left: 10.w,bottom: 15.w),
          decoration: BoxDecoration(
            color: AppColors.c_FFFFFFFF,
            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            //设置四周边框
            border: Border.all(width: 0.5, color: AppColors.THEME_COLOR),
          ),
          child: Text("取消",style: TextStyle(color: AppColors.THEME_COLOR,fontSize: 13.sp),),
        ),
      ),
    );
  }

  @override
  void onDestroy() {}
}
