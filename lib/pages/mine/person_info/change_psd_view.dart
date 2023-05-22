import 'package:crazyenglish/pages/mine/person_info/person_info_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';

class ChangePsdPage extends BasePage {
  const ChangePsdPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<ChangePsdPage> {
  final logic = Get.find<Person_infoLogic>();
  TextEditingController? _phoneController;
  var oldPasswordStr = "".obs;
  var newPasswordStr = "".obs;
  late bool isShowPsd;

  @override
  void initState() {
    super.initState();
    isShowPsd = false;
    _phoneController = TextEditingController();

    logic.addListenerId(GetBuilderIds.toChangePassword, () {

      if(mounted&&logic.state.pushDate!=null&&logic.state.pushDate!.code!=0){
        Util.toast(logic.state.pushDate!.message.toString());
      }else{
        Util.toast('修改成功');
        Get.back();
      }

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
              if (oldPasswordStr.value.isEmpty) {
                Util.toast("请输入旧密码");
                return;
              }
              if (newPasswordStr.value.isEmpty) {
                Util.toast("请输入新密码");
                return;
              }
              //手机号的格式是否通过？
              if (!Util.isLoginPassword(newPasswordStr.value)) {
                Util.toast("密码长度为6-18位，满足字母大小写、数字、符号三类中其中两类");
                return;
              }


              logic.toChangePassword(oldPasswordStr.value,newPasswordStr.value);
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
                        onChanged: (String str) {
                          oldPasswordStr.value = str;
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
                onChanged: (String str) {
                  newPasswordStr.value = str;
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
  void onDestroy() {

  }

  toPsdShow() {
    setState(() {
      isShowPsd = !isShowPsd;
    });
  }
}
