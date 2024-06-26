import 'package:crazyenglish/pages/mine/auth_code/CodeWidget.dart';
import 'package:crazyenglish/pages/mine/auth_code/auth_code_view.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../net/net_manager.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import 'set_psd_logic.dart';

class SetPsdPage extends BasePage {
  const SetPsdPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToSetPsdPageState();
}

class _ToSetPsdPageState extends BasePageState<SetPsdPage> {
  final logic = Get.put(Set_psdLogic());
  final state = Get.find<Set_psdLogic>().state;
  late bool isPhoneLog;
  late bool isShowPsd;
  var phoneCodeStr = "".obs;
  var phoneNumStr = "".obs;
  TextEditingController? _phoneController;
  var map = new Map();

  @override
  void initState() {
    super.initState();
    isPhoneLog = false;
    isShowPsd = false;
    _phoneController = TextEditingController();

    logic.addListenerId(GetBuilderIds.sendCode, () {
      // Util.toast(state.sendCodeResponse.data??"");
      hideLoading();
      if (state.sendCodeResponse.code == ResponseCode.status_success) {
        var date = {
          AuthCodePage.PHONE: _phoneController!.text,
          AuthCodePage.USER_PWD: phoneCodeStr.value,
          AuthCodePage.SMS_TYPE: SmsCodeType.resetPwd
        };
        RouterUtil.offAndToNamed(AppRoutes.AuthCodePage, arguments: date);
      } else {
        Util.toast(state.sendCodeResponse.message!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("重设密码"),
        backgroundColor: AppColors.theme_bg,
        body: SafeArea(
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                hideKeyBoard();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 30.w)),
                  Container(
                    margin: EdgeInsets.only(left: 14.w, right: 14.w),
                    child: Text('请设置登录密码，需8-20位字符，必须包含字母/数字/字符中两种以上组合',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff898a93),
                        )),
                  ),
                  _getLoginInput(),
                  Padding(padding: EdgeInsets.only(top: 10.w)),
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 46.w, right: 46.w, bottom: 43.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

  ///收起键盘
  hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

//用户名密码登录，总编辑框
  Widget _getLoginInput() {
    return Container(
      margin: EdgeInsets.only(top: 60.w, left: 14.w, right: 14.w),
      child: Column(
        children: [
          _getInputPhoneView(),
          _getInputPsdView(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              hideKeyBoard();
              if (_phoneController!.text.isEmpty) {
                Util.toast("请输入手机号");
                return;
              }
              if (phoneCodeStr.value.isEmpty) {
                Util.toast("请输入新密码");
                return;
              }
              //密码的格式是否通过？
              if (!Util.isLoginPassword(phoneCodeStr.value)) {
                print('密码无效');
                Util.toast("密码长度为6-18位，满足字母大小写、数字、符号三类中其中两类");
                return;
              }
              logic.mobileExists(_phoneController!.text,SmsCodeType.resetPwd);
            },
            child: Obx(() {
              return Container(
                height: 47.w,
                decoration: BoxDecoration(
                    color: getColor(),
                    borderRadius: const BorderRadius.all(Radius.circular(22))),
                child: const Center(
                  child: Text(
                    "下一步",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

//用户名密码登录，输入用户名编辑框
  Widget _getInputPhoneView() {
    return Container(
      width: double.infinity,
      height: 47.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          color: AppColors.c_4DD9D9D9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15.w)),
          Container(
            width: 300.w,
            alignment: Alignment.centerLeft,
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              style: TextStyle(fontSize: 15, color: Color(0xff32374e)),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String str) {
                phoneNumStr.value = str;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '请输入手机号',
                hintStyle: TextStyle(fontSize: 15, color: Color(0xff717171)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getInputPsdView() {
    return Container(
        width: double.infinity,
        height: 47.w,
        margin: EdgeInsets.only(top: 18.w, bottom: 50.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
            color: AppColors.c_4DD9D9D9),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 15.w)),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.text,
              obscureText: isShowPsd,
              style: TextStyle(fontSize: 15.sp, color: Color(0xff32374e)),
              onChanged: (String str) {
                phoneCodeStr.value = str;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '请输入密码',
                hintStyle: TextStyle(fontSize: 15, color: Color(0xff717171)),
              ),
            )),
            InkWell(
              onTap: () {
                toPsdShow();
              },
              child: Container(
                width: 47.w,
                height: 47.w,
                padding: EdgeInsets.all(15.w),
                margin: EdgeInsets.only(right: 4.w),
                child: Image.asset(
                  isShowPsd ? R.imagesLoginEyeClose : R.imagesLoginEyeOpen,
                  width: 17.w,
                  height: 17.w,
                ),
              ),
            )
          ],
        ));
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  toPsdShow() {
    setState(() {
      isShowPsd = !isShowPsd;
    });
  }

  toPsdLogin() {
    if (isPhoneLog) {
      Util.toast("切换账号密码登录");
    } else {
      Util.toast("切换手机号登录");
    }
    setState(() {
      isPhoneLog = !isPhoneLog;
    });
  }

  Color getColor() {
    return phoneNumStr.value.isEmpty || phoneCodeStr.value.isEmpty
        ? Color(0xfff6c9c6)
        : AppColors.THEME_COLOR;
  }
}
