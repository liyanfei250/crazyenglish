import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import 'change_phone_logic.dart';

class ChangePhonePage extends BasePage {
  const ChangePhonePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<ChangePhonePage> {
  final logic = Get.put(Change_phoneLogic());
  final state = Get.find<Change_phoneLogic>().state;
  TextEditingController? _phoneController;
  var phoneCodeStr = "".obs;
  var phoneNumStr = "".obs;
  late bool isShowPsd;

  @override
  void initState() {
    super.initState();
    isShowPsd = false;
    _phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("更改手机号"),
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
                    child: Text('请输入新绑定的手机号',
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
          SizedBox(height: 20.w,),
          _getInputPsdView(),
          SizedBox(height: 60.w,),
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
              //todo 发送验证码，去验证码界面
              // logic.sendCode(_phoneController!.text);
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
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('绑定手机号: '),
        Expanded(
            child: Container(
          height: 47.w,
          margin: EdgeInsets.only(left: 20.w),
          padding: EdgeInsets.only(left: 20.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              color: AppColors.c_4DD9D9D9),
          child: Text(Util.formatPhoneNumber('13299195686'),
              style: TextStyle(fontSize: 15, color: Color(0xff32374e))),
        ))
      ],
    );
  }

  Widget _getInputPsdView() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('更换手机号: '),
        Expanded(
            child: Container(
                height: 47.w,
                margin: EdgeInsets.only(left: 20.w),
                padding: EdgeInsets.only(left: 20.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    color: AppColors.c_4DD9D9D9),
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
                )))
      ],
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Color getColor() {
    return phoneCodeStr.value.isEmpty
        ? Color(0xfff6c9c6)
        : AppColors.THEME_COLOR;
  }

  toPsdShow() {
    setState(() {
      isShowPsd = !isShowPsd;
    });
  }
}
