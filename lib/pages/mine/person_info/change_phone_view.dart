import 'package:crazyenglish/pages/mine/auth_code/auth_code_view.dart';
import 'package:crazyenglish/pages/mine/person_info/person_info_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';

class ChangePhonePage extends BasePage {
  const ChangePhonePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<ChangePhonePage> {
  final logic = Get.find<Person_infoLogic>();
  TextEditingController? _phoneController;
  var phoneCodeStr = "".obs;
  var phoneNumStr = "".obs;
  late bool isShowPsd;

  @override
  void initState() {
    super.initState();
    isShowPsd = false;
    _phoneController = TextEditingController();

    logic.addListenerId(GetBuilderIds.sendCode, () {
      // Util.toast(state.sendCodeResponse.data??"");
      hideLoading();
      // Util.toast(state.sendCodeResponse.data??"");
      if (logic.state.sendCodeResponse.code == 1) {
        var date = {
          AuthCodePage.PHONE: _phoneController!.text,
          AuthCodePage.SMS_CODE: phoneCodeStr.value,
          AuthCodePage.SMS_TYPE: SmsCodeType.changeMobile
        };
        RouterUtil.offAndToNamed(AppRoutes.AuthCodePage, arguments: date);
      } else {
        Util.toast(logic.state.sendCodeResponse.message!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("修改手机号"),
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
                  Padding(padding: EdgeInsets.only(top: 25.w)),
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
      margin: EdgeInsets.only(top: 0.w, left: 14.w, right: 14.w),
      child: Column(
        children: [
          _getInputPhoneView(),
          SizedBox(
            height: 18.w,
          ),
          _getInputPsdView(),
          SizedBox(
            height: 60.w,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              hideKeyBoard();
              if (phoneCodeStr.value.isEmpty) {
                Util.toast("请输入新的手机号");
                return;
              }
              //手机号的格式是否通过？
              if (Util.isPhoneNumberInChina(phoneCodeStr.value)) {
                Util.toast("手机号格式不对");
                return;
              }
              logic.sendCode(_phoneController!.text,SmsCodeType.changeMobile);
            },
            child: Container(
              height: 47.w,
              decoration: BoxDecoration(
                  color: AppColors.c_FFFFFFFF,
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: const Center(
                child: Text(
                  "下一步",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//用户名密码登录，输入用户名编辑框
  Widget _getInputPhoneView() {
    return Container(
      height: 47.w,
      padding: EdgeInsets.only(left: 20.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          color: AppColors.c_FFFFFFFF),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('绑定手机号: '),
          SizedBox(
            width: 14.w,
          ),
          Expanded(
              child: Text(Util.formatPhoneNumber('13299195686'),
                  style: TextStyle(fontSize: 15, color: Color(0xff898a93))))
        ],
      ),
    );
  }

  Widget _getInputPsdView() {
    return Container(
      height: 47.w,
      padding: EdgeInsets.only(left: 20.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          color: AppColors.c_FFFFFFFF),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('更换手机号: '),
          SizedBox(
            width: 14.w,
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.number,
                obscureText: isShowPsd,
                style: TextStyle(fontSize: 15.sp, color: Color(0xff32374e)),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (String str) {
                  phoneCodeStr.value = str;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '请输入要更换的手机号',
                  hintStyle: TextStyle(fontSize: 15, color: Color(0xff717171)),
                ),
              )),
            ],
          ))
        ],
      ),
    );
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
}
