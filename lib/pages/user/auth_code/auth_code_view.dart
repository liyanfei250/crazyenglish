import 'dart:async';

import 'package:crazyenglish/pages/user/auth_code/CodeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../utils/colors.dart';
import 'auth_code_logic.dart';

class AuthCodePage extends BasePage {
  String? phone;
  String? code;

  AuthCodePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      phone = Get.arguments['phone'];
      code = Get.arguments['code'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToCodeAuthPageState();
}

class _ToCodeAuthPageState extends BasePageState<AuthCodePage> {
  final logic = Get.put(Auth_codeLogic());
  final state = Get.find<Auth_codeLogic>().state;

  get data => null;

  ///收起键盘
  hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("手机号验证"),
      backgroundColor: AppColors.theme_bg,
      // body: CodeWidget(),
      body: Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // '请输入验证码',
              widget.phone.toString(),
              style: TextStyle(fontSize: 16, color: Color(0xff353e4d)),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  '已发送至178****7851',
                  style: TextStyle(fontSize: 14, color: Color(0xff898a93)),
                )),
                InkWell(
                  onTap: () {
                    hideKeyBoard();
                    _startTimer(6);
                  },
                  child: Obx(() => Text(
                        countDown.value == -1 ? "重新发送" : "${countDown.value} s",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff898a93)),
                      )),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20.w)),
            CodeWidget(
                itemWidth: 71.w,
                borderColor: Color(0xffe7e7e7),
                borderSelectColor: Color(0xffb5b5b5))
          ],
        ),
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  @override
  void dispose() {
    Get.delete<Auth_codeLogic>();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  var countDown = (-1).obs;
  Timer? timer;
  bool isShowRepeat = false;

  _startTimer(int? countDownTime) {
    if (timer != null) {
      timer!.cancel();
    }
    countDown.value = countDownTime ?? 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      countDown.value--;
      if (countDown.value < 0) {
        timer.cancel();
      }
    });
  }
}
