import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import 'change_psd_logic.dart';

class ChangePsdPage extends BasePage {
  const ChangePsdPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<ChangePsdPage> {
  final logic = Get.put(Change_psdLogic());
  final state = Get.find<Change_psdLogic>().state;
  TextEditingController? _phoneController;
  var phoneCodeStr = "".obs;
  var phoneNumStr = "".obs;
  late bool isShowPsd;

  @override
  void initState() {
    super.initState();
    isShowPsd = false;
    _phoneController = TextEditingController();
    logic.toChangePassword('id');
    logic.addListenerId(GetBuilderIds.toChangePassword, () {
      //todo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("修改密码"),
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
      ),
    );
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
              //todo 发送验证码，去验证码界面
              // logic.sendCode(_phoneController!.text);

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
          Text('旧密码: '),
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
                          hintText: '请输入旧密码',
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
              ))
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
          Text('新密码: '),
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
                  hintText: '请输入新密码',
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
