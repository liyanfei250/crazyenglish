import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../base/common.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../entity/login/login_util.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../base/AppUtil.dart';
import '../../utils/colors.dart';
import '../../utils/sp_util.dart';
import 'login_logic.dart';

class LoginPage extends BasePage {
  const LoginPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _LoginPageState();
  }
}

class _LoginPageState extends BasePageState<LoginPage> {
  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  var agreePolicy = true.obs;

  var _isHavePhoneNum = false.obs;
  var _isHaveVerifyCode = false.obs;
  TextEditingController? _phoneController;
  TextEditingController? _verifyCodeController;

  TextEditingController? _pawdController;

  String errorStr = "";

  ///注册条款
  final TapGestureRecognizer recognizerRegister = TapGestureRecognizer();
  ///用户隐私协议
  final TapGestureRecognizer recognizerPrivacyLaw = TapGestureRecognizer();


  // 极光相关
  /// 统一 key
  final String f_result_key = "result";

  /// 错误码
  final String f_code_key = "code";

  /// 回调的提示信息，统一返回 flutter 为 message
  final String f_msg_key = "message";

  /// 运营商信息
  final String f_opr_key = "operator";

  String _result = "token=";
  var controllerPHone = new TextEditingController();
  String? _token;
  int tryTime = 0;
  var isHidePasswd = true.obs;
  var isUserLoginEnable = false.obs;
  var phoneStr = "".obs;
  var phoneCodeStr = "".obs;
  var wechatIsInstalled = true.obs;
  var qqIsInstalled = true.obs;

  @override
  void initState() {
    super.initState();
    Util.initWhenEnterMain();
    isThirdInstalled();
    _phoneController = TextEditingController();
    _verifyCodeController = TextEditingController();

    // Future.delayed(Duration(milliseconds: 400),quickLogin());
    recognizerRegister.onTap = () {
      RouterUtil.toWebPage(C.REGISTER_LAW,
        title: "用户协议",showStatusBar: true,showAppBar: true,showH5Title: true,);
    };
    recognizerPrivacyLaw.onTap = () {
      RouterUtil.toWebPage(C.REGISTER_PRIVACY_POLICY_LAW,
        title: "隐私保护政策",showStatusBar: true,showAppBar: true,showH5Title: true,);
    };

    logic.addListenerId(GetBuilderIds.sendCode, () {

      // Fluttertoast.showToast(msg: state.sendCodeResponse.data??"");
      _startTimer(60);
      hideLoading();
    });
    logic.addListenerId(GetBuilderIds.mobileLogin, () {
      if((state.loginResponse.data!.accessToken??"").isNotEmpty){
        Fluttertoast.showToast(msg: "登录成功");
        SpUtil.putBool(BaseConstant.ISLOGING, true);
        SpUtil.putString(BaseConstant.loginTOKEN, state.loginResponse.data!.accessToken);
        Util.getHeader();
        RouterUtil.offAndToNamed(AppRoutes.HOME);
      }else{
        Fluttertoast.showToast(msg: "登录失败");
      }


    });
    // Future.delayed(Duration(milliseconds: 400),quickLogin(""));
  }


  void isThirdInstalled() async {
    // wechatIsInstalled.value = await wechat.Wechat.instance.isInstalled();
    // qqIsInstalled.value = await tencent.Tencent.instance.isQQInstalled();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        context,
        designSize: const Size(360, 640));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.theme_bg,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          hideKeyBoard();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 70.w)),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 40.w, right: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(R.imagesWelcomeIcon,width: 78.w,height: 76.w,),
                  Padding(padding: EdgeInsets.only(top: 8.w)),
                  Image.asset(R.imagesWelcomeTxt,width: 236.w,height: 33.w,),
                ],
              ),
            ),
            _getLoginInput(),
            Padding(padding: EdgeInsets.only(top: 10.w)),
            const Spacer(),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20,bottom: 43.w),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 30,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(()=>InkWell(
                              onTap: (){
                                agreePolicy.value = !agreePolicy.value;
                              },
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                padding: EdgeInsets.only(left:5.w,right: 5.w,top: 4.w),
                                child: Image.asset(agreePolicy.value? R.imagesLoginAgreeSelected:R.imagesLoginAgreeDefault,width: 10.w,
                                  height: 10.w,),
                              ),
                            )),
                            RichText(
                              text: TextSpan(
                                  text: "阅读并同意",
                                  style:
                                  TextStyle(color: Color(0xff727a89), fontSize: 11),
                                  children: [
                                    TextSpan(
                                      text: "用户协议",
                                      style: TextStyle(
                                          color: AppColors.THEME_COLOR,
                                          fontSize: 11.sp,
                                          decoration: TextDecoration.none),
                                      recognizer: recognizerRegister,
                                    ),
                                    TextSpan(
                                      text: "·",
                                      style: TextStyle(
                                          color: Color(0xff727a89),
                                          fontSize: 11.sp,
                                          decoration: TextDecoration.none),
                                    ),

                                    TextSpan(
                                      text: "隐私政策·",
                                      style: TextStyle(
                                          color: AppColors.THEME_COLOR,
                                          fontSize: 11.sp,
                                          decoration: TextDecoration.none),
                                      recognizer: recognizerPrivacyLaw,
                                    ),
                                    TextSpan(
                                      text: "首次登录将自动注册",
                                      style: TextStyle(
                                          color: Color(0xff727a89),
                                          fontSize: 11.sp,
                                          decoration: TextDecoration.none),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
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
      margin: EdgeInsets.only(top: 44.w, left: 20.w, right: 20.w),
      child: Column(
        children: [
          _getInputPhoneView(),
          Container(
            margin: EdgeInsets.only(top: 28.w),
            child: Container(
                width: 270.w,
                height: 44.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22.w)),
                    color: AppColors.c_4DD9D9D9
                ),
                child: Row(
                  children: [
                    Obx(()=>
                        Container(
                          padding: EdgeInsets.only(left: 20.w),
                          width: 170.w,
                          child:TextField(
                            keyboardType: TextInputType.number,
                              controller: _verifyCodeController,
                              obscureText: isHidePasswd.value,
                              style: TextStyle(fontSize: 18, color: Color(0xff32374e)),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (String str) {
                                phoneCodeStr.value = str;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入验证码',
                                hintStyle:
                                TextStyle(fontSize: 15, color: Color(0xff717171)),
                              ),
                            )
                        ),
                    ),
                    InkWell(
                      onTap: (){
                        if (_isHavePhoneNum.value) {
                          if(countDown.value <= 0){
                            logic.sendCode(_phoneController!.text);
                          }else{
                            hideKeyBoard();
                            Fluttertoast.showToast(msg: "请等待${countDown.value} s后重新发送");
                          }
                        }else{
                          hideKeyBoard();
                          Fluttertoast.showToast(msg: "请输入手机号");
                        }
                      },
                      child: Obx(
                          ()=>Text(countDown.value == -1 ? "获取验证码" : "${countDown.value} s",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15,color: AppColors.THEME_COLOR),)
                      ),
                    )
                  ],
                )
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              hideKeyBoard();
              logic.mobileLogin(phoneStr.value,phoneCodeStr.value);
            },
            child: Container(
                  height: 44.w,
                  margin: EdgeInsets.only(top: 28.w),
                  width: 270.w,
                  decoration: BoxDecoration(
                      color: AppColors.THEME_COLOR,
                      borderRadius: const BorderRadius.all(Radius.circular(22))),
                  child: const Center(
                    child: Text(
                      "登录",
                      style: TextStyle(color: Colors.white, fontSize: 15),
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
      width: 270.w,
      height: 44.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(22.w)),
          color: AppColors.c_4DD9D9D9
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text("+86",style: TextStyle(fontSize:16.sp,color: AppColors.c_FF101010),),
          ),
          Container(
            width: 170.w,
            alignment: Alignment.centerLeft,
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              style: TextStyle(fontSize: 18, color: Color(0xff32374e)),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (String str) {
                phoneStr.value = str;
                if(phoneStr.value.isNotEmpty){
                  _isHavePhoneNum.value = true;
                } else {
                  _isHavePhoneNum.value = false;
                }
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '请输入您的手机号',
                hintStyle: TextStyle(fontSize: 15, color: Color(0xff717171)),
              ),
            ),
          )
          ],
      ),
    );
  }



  getMobile(String token){

  }

  @override
  void dispose() {
    // _wechatAuthSubs?.cancel();
    // _weiboAuthSubs?.cancel();
    // _tencentAuthSubs?.cancel();
    Get.delete<LoginLogic>();
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
    countDown.value = countDownTime??0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      countDown.value--;
      if (countDown.value < 0) {
        timer.cancel();
      }
    });
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  void appleLogin() async{
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(appleCredential);

    if(appleCredential.userIdentifier!=null &&
        appleCredential.identityToken!=null
    ){
      logic.appleLogin({"userIdentifier":appleCredential.userIdentifier!,
        "identityToken":appleCredential.identityToken!});
    }

  }

}