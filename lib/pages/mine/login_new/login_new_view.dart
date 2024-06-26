import 'dart:async';

import 'package:crazyenglish/blocs/login_change_bloc.dart';
import 'package:crazyenglish/blocs/login_change_event.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../base/AppUtil.dart';
import '../../../utils/colors.dart';
import '../../../utils/sp_util.dart';
import 'login_new_logic.dart';

class LoginNewPage extends BasePage {
  static const String inEnterHome = "enter_home";
  static const String UserInfoResponse = "UserInfoResponse";

  bool isEnterHome = true;

  LoginNewPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isEnterHome = Get.arguments[inEnterHome] ?? false;
    }
  }

  @override
  BasePageState<BasePage> getState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BasePageState<LoginNewPage> {
  final logic = Get.put(Login_newLogic());
  final state = Get.find<Login_newLogic>().state;

  var agreePolicy = false.obs;

  var _isHavePhoneNum = false.obs;
  var _isHaveVerifyCode = false.obs;
  TextEditingController? _phoneController;
  TextEditingController? _psdControl;
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

  var controllerPHone = new TextEditingController();
  int tryTime = 0;
  var isHidePasswd = true.obs;
  var isCanLogin = false.obs;
  var isUserLoginEnable = false.obs;
  var phoneStr = "".obs;
  var phoneCodeStr = "".obs;
  var phoneAuthStr = "".obs;
  var wechatIsInstalled = true.obs;
  var qqIsInstalled = true.obs;
  var isPhoneLog = true.obs;
  late bool isShowPsd;

  @override
  void initState() {
    super.initState();
    Util.initWhenEnterMain();
    isThirdInstalled();
    isPhoneLog.value = true;
    isShowPsd = false;
    _phoneController = TextEditingController();
    _psdControl = TextEditingController();
    _verifyCodeController = TextEditingController();

    // Future.delayed(Duration(milliseconds: 400),quickLogin());
    recognizerRegister.onTap = () {
      RouterUtil.toWebPage(
        C.REGISTER_LAW,
        title: "用户协议",
        showStatusBar: true,
        showAppBar: true,
        showH5Title: true,
      );
    };
    recognizerPrivacyLaw.onTap = () {
      RouterUtil.toWebPage(
        C.REGISTER_PRIVACY_POLICY_LAW,
        title: "隐私保护政策",
        showStatusBar: true,
        showAppBar: true,
        showH5Title: true,
      );
    };

    logic.addListenerId(GetBuilderIds.sendCode, () {
      // Util.toast(state.sendCodeResponse.data??"");
      _startTimer(60);
      hideLoading();
    });
    logic.addListenerId(GetBuilderIds.mobileLogin, () {
      if ((state.loginResponse.data?.accessToken ?? "").isNotEmpty) {
        Util.toast("登录成功");
        SpUtil.putString(BaseConstant.loginTOKEN,
            state.loginResponse.data!.accessToken ?? "");
        Util.getHeader();
        logic.getUserinfo();
      } else {
        Util.toast("登录失败");
      }
    });
    logic.addListenerId(GetBuilderIds.passwordLogin, () {
      if ((state.loginResponse.data?.accessToken ?? "").isNotEmpty) {
        Util.toast("登录成功");
        SpUtil.putString(BaseConstant.loginTOKEN,
            state.loginResponse.data!.accessToken ?? "");
        Util.getHeader();
        logic.getUserinfo();
      } else {
        Util.toast("登录失败");
      }
    });
    // Future.delayed(Duration(milliseconds: 400),quickLogin(""));

    logic.addListenerId(GetBuilderIds.getUserInfo, () {
      if (state.infoResponse.code == 0 && state.infoResponse.obj != null) {
        Util.toast('获取信息成功');

        if (state.infoResponse.obj?.identity == RoleType.student ||
            state.infoResponse.obj?.identity == RoleType.teacher) {
          SpUtil.putBool(
              "${BaseConstant.IS_CHOICE_ROLE}${state.infoResponse.obj?.id}",
              true);
        } else {
          SpUtil.putBool(
              "${BaseConstant.IS_CHOICE_ROLE}${state.infoResponse.obj?.id}",
              false);
        }

        //1老师2学生
        if (state.infoResponse.obj?.identity == 1) {
          SpUtil.putBool(BaseConstant.IS_TEACHER_LOGIN, true);
        }

        if (state.infoResponse.obj?.identity == 2) {
          SpUtil.putBool(BaseConstant.IS_TEACHER_LOGIN, false);
        }

        if (!SpUtil.getBool(
            "${BaseConstant.IS_CHOICE_ROLE}${state.infoResponse.obj?.id}")) {
          //没选角色
          RouterUtil.offAndToNamed(AppRoutes.RolePage, arguments: {
            LoginNewPage.inEnterHome: widget.isEnterHome,
            LoginNewPage.UserInfoResponse: state.infoResponse,
          });
        } else {
          if ((state.infoResponse.obj?.affiliatedGrade ?? "").isEmpty &&
              !SpUtil.getBool(
                  "${BaseConstant.IS_CHOICE_ROLE_GRADE}${state.infoResponse.obj?.id}")) {
            ////是学生且没选年级
            //如果没选年级就去选年级
            RouterUtil.offAndToNamed(AppRoutes.RoleTwoPage, arguments: {
              LoginNewPage.inEnterHome: widget.isEnterHome,
              LoginNewPage.UserInfoResponse: state.infoResponse,
            });
            //选了去首页
          } else {
            logic.updateNativeUserInfo(state.infoResponse);
            if (mounted) {
              BlocProvider.of<LoginChangeBloc>(context)
                  .add(SendLoginChangeEvent());
            }
            if (widget.isEnterHome) {
              if (state.infoResponse.obj?.identity == RoleType.teacher) {
                RouterUtil.offAndToNamed(AppRoutes.TEACHER_HOME);
              } else {
                RouterUtil.offAndToNamed(AppRoutes.HOME);
              }
            } else {
              if (!SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN) &&
                  state.infoResponse.obj?.identity == RoleType.student) {
                RouterUtil.offAndToNamed(AppRoutes.HOME);
              } else if (SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN) &&
                  state.infoResponse.obj?.identity == RoleType.teacher) {
                RouterUtil.offAndToNamed(AppRoutes.TEACHER_HOME);
              }
              Get.back();
            }
          }
        }
      } else {
        Util.toast("登录失败，获取个人信息失败");
      }
    });
  }

  void isThirdInstalled() async {
    // wechatIsInstalled.value = await wechat.Wechat.instance.isInstalled();
    // qqIsInstalled.value = await tencent.Tencent.instance.isQQInstalled();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        //状态栏颜色
        statusBarIconBrightness: Brightness.light,
        //状态栏图标颜色
        statusBarBrightness: Brightness.dark,
        //状态栏亮度
        systemStatusBarContrastEnforced: true,
        //系统状态栏对比度强制
        systemNavigationBarColor: Colors.white,
        //导航栏颜色
        systemNavigationBarIconBrightness: Brightness.light,
        //导航栏图标颜色
        systemNavigationBarDividerColor: Colors.transparent,
        //系统导航栏分隔线颜色
        systemNavigationBarContrastEnforced: true, //系统导航栏对比度强制
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.theme_bg,
          body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                hideKeyBoard();
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(R.imagesLoginTopBg),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBar(
                        elevation: 0,
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        title: Text(""),
                        backgroundColor: Colors.transparent,
                        actions: [
                          Obx(
                            () => TextButton(
                                onPressed: toPsdLogin,
                                child: Text(
                                  isPhoneLog.value ? '账号密码登录' : '手机号登录',
                                  style: TextStyle(
                                      color: Color(0xff353e4d),
                                      fontSize: 14.sp),
                                )),
                          )
                        ],
                      ),
                      Obx(() => Text(isPhoneLog.value ? '手机号登录' : '账号密码登录',
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff353e4d),
                          ))),
                      Visibility(
                          visible: isPhoneLog.value,
                          child: Text('未注册过的手机号将自动创建账号',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w100,
                                color: Color(0xff898a93),
                              ))),
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
                              children: [
                                Obx(() => InkWell(
                                      onTap: () {
                                        agreePolicy.value = !agreePolicy.value;
                                      },
                                      child: Container(
                                        width: 20.w,
                                        height: 20.w,
                                        padding: EdgeInsets.only(
                                            left: 5.w,
                                            right: 5.w,
                                            top: 1.w,
                                            bottom: 5.w),
                                        child: Image.asset(
                                          agreePolicy.value
                                              ? R.imagesLoginAgreeSelected
                                              : R.imagesLoginAgreeDefault,
                                          width: 10.w,
                                          height: 10.w,
                                        ),
                                      ),
                                    )),
                                Expanded(
                                  child: RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: "已阅读并同意",
                                        style: TextStyle(
                                            color: Color(0xff727a89),
                                            fontSize: 11),
                                        children: [
                                          TextSpan(
                                            text: "《用户协议》",
                                            style: TextStyle(
                                                color: AppColors.THEME_COLOR,
                                                fontSize: 11.sp,
                                                decoration:
                                                    TextDecoration.none),
                                            recognizer: recognizerRegister,
                                          ),
                                          TextSpan(
                                            text: "和",
                                            style: TextStyle(
                                                color: Color(0xff727a89),
                                                fontSize: 11.sp,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          TextSpan(
                                            text: "《隐私政策》",
                                            style: TextStyle(
                                                color: AppColors.THEME_COLOR,
                                                fontSize: 11.sp,
                                                decoration:
                                                    TextDecoration.none),
                                            recognizer: recognizerPrivacyLaw,
                                          ),
                                          // TextSpan(
                                          //   text: "和",
                                          //   style: TextStyle(
                                          //       color: Color(0xff727a89),
                                          //       fontSize: 11.sp,
                                          //       decoration:
                                          //           TextDecoration.none),
                                          // ),
                                          // TextSpan(
                                          //   text: "《儿童隐私保护政策》",
                                          //   style: TextStyle(
                                          //       color: AppColors.THEME_COLOR,
                                          //       fontSize: 11.sp,
                                          //       decoration:
                                          //           TextDecoration.none),
                                          // ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ))),
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
      margin: EdgeInsets.only(top: 24.w, left: 20.w, right: 20.w),
      child: Column(
        children: [
          _getInputPhoneView(),
          Obx(() => Visibility(
              visible: isPhoneLog.value,
              child: Container(
                margin: EdgeInsets.only(top: 18.w),
                child: Container(
                    width: 329.w,
                    height: 47.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.w)),
                        color: AppColors.c_4DD9D9D9),
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 15.w),
                            width: 220.w,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _verifyCodeController,
                              style: TextStyle(
                                  fontSize: 15.sp, color: Color(0xff32374e)),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (String str) {
                                phoneAuthStr.value = str;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入验证码',
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Color(0xff717171)),
                              ),
                            )),
                        VerticalDivider(
                          color: Colors.grey,
                          width: 1,
                          indent: 13.w,
                          endIndent: 13.w,
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        InkWell(
                          onTap: () {
                            if (_isHavePhoneNum.value) {
                              if (countDown.value <= 0) {
                                logic.sendCode(_phoneController!.text,
                                    SmsCodeType.phoneLogin);
                              } else {
                                hideKeyBoard();
                                Util.toast("请等待${countDown.value} s后重新发送");
                              }
                            } else {
                              hideKeyBoard();
                              Util.toast("请输入手机号");
                            }
                          },
                          child: Obx(() => Text(
                                countDown.value == -1
                                    ? "获取验证码"
                                    : "${countDown.value} s",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColors.THEME_COLOR),
                              )),
                        )
                      ],
                    )),
              ))),
          Obx(() => Visibility(
              visible: !isPhoneLog.value, child: _getInputPsdView())),
          Obx(() => Visibility(
              visible: isPhoneLog.value,
              child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 24.w),
                  child: TextButton(
                      onPressed: toPsd,
                      child: Text(
                        '',
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xff898a93)),
                      ))))),
          Obx(() => Visibility(
              visible: !isPhoneLog.value,
              child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 24.w),
                  child: TextButton(
                      onPressed: toSetPsd,
                      child: Text(
                        '忘记密码',
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xff898a93)),
                      ))))),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              hideKeyBoard();
              if (!agreePolicy.value) {
                Util.toast("同意协议后才能登录");
                return;
              }
              if (isPhoneLog.value) {
                if (_phoneController!.text.isEmpty) {
                  Util.toast("请输入手机号");
                  return;
                }
                if (phoneAuthStr.value.isEmpty) {
                  Util.toast("请输入验证码");
                  return;
                }
              } else {
                if (_phoneController!.text.isEmpty) {
                  Util.toast("请输入用户名/手机号/邮箱");
                  return;
                }
                if (_psdControl!.text.isEmpty) {
                  Util.toast("请输入密码");
                  return;
                }
              }
              isPhoneLog.value
                  ? logic.mobileLogin(phoneStr.value, phoneAuthStr.value)
                  : logic.passwordLogin(phoneStr.value, phoneCodeStr.value);
            },
            child: Obx(() {
              return Container(
                height: 47.w,
                decoration: BoxDecoration(
                    color: getColor(isPhoneLog.value),
                    borderRadius: const BorderRadius.all(Radius.circular(22))),
                child: const Center(
                  child: Text(
                    "登录",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              );
            }),
          ),
          Visibility(
            visible: Util.isIOSMode(),
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  hideKeyBoard();
                  logic.passwordLogin("guest", "123456");
                },
                child: Container(
                  height: 47.w,
                  child: const Center(
                    child: Text(
                      "游客登录",
                      style: TextStyle(color: Color(0xff898a93), fontSize: 15),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _getInputPsdView() {
    return Container(
        width: 329.w,
        height: 47.w,
        margin: EdgeInsets.only(top: 18.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
            color: AppColors.c_4DD9D9D9),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 15.w)),
            Expanded(
                child: Obx(() => TextField(
                      keyboardType: TextInputType.text,
                      controller: _psdControl,
                      obscureText: isShowPsd,
                      style:
                          TextStyle(fontSize: 15.sp, color: Color(0xff32374e)),
                      inputFormatters: isPhoneLog.value
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : [FilteringTextInputFormatter.singleLineFormatter],
                      onChanged: (String str) {
                        phoneCodeStr.value = str;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入密码',
                        hintStyle:
                            TextStyle(fontSize: 15, color: Color(0xff717171)),
                      ),
                    ))),
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

  //用户名密码登录，输入用户名编辑框
  Widget _getInputPhoneView() {
    return Container(
      width: 329.w,
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
            child: Obx(() => TextField(
                  keyboardType: isPhoneLog.value
                      ? TextInputType.phone
                      : TextInputType.text,
                  controller: _phoneController,
                  style: TextStyle(fontSize: 15, color: Color(0xff32374e)),
                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (String str) {
                    phoneStr.value = str;
                    if (phoneStr.value.isNotEmpty) {
                      _isHavePhoneNum.value = true;
                    } else {
                      _isHavePhoneNum.value = false;
                    }
                  },
                  decoration: isPhoneLog.value
                      ? const InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入手机号',
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff717171)),
                        )
                      : const InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入用户名/手机号/邮箱',
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff717171)),
                        ),
                )),
          )
        ],
      ),
    );
  }

  getMobile(String token) {}

  @override
  void dispose() {
    // _wechatAuthSubs?.cancel();
    // _weiboAuthSubs?.cancel();
    // _tencentAuthSubs?.cancel();
    Get.delete<Login_newLogic>();
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

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  void appleLogin() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(appleCredential);

    if (appleCredential.userIdentifier != null &&
        appleCredential.identityToken != null) {
      /*logic.appleLogin({
        "userIdentifier": appleCredential.userIdentifier!,
        "identityToken": appleCredential.identityToken!
      });*/
    }
  }

  toPsdLogin() {
    if (isPhoneLog.value) {
      isPhoneLog.value = false;
      Util.toast("切换账号密码登录");
    } else {
      isPhoneLog.value = true;
      Util.toast("切换手机号登录");
    }
  }

  toPsd() {}

  toSetPsd() {
    RouterUtil.toNamed(AppRoutes.SetPsdPage);
  }

  toPsdShow() {
    setState(() {
      isShowPsd = !isShowPsd;
    });
  }

  Color getColor(isPhoneLog) {
    if (isPhoneLog) {
      return phoneStr.value.isEmpty || phoneAuthStr.value.isEmpty
          ? Color(0xfff6c9c6)
          : AppColors.THEME_COLOR;
    } else {
      return phoneStr.value.isEmpty || phoneCodeStr.value.isEmpty
          ? Color(0xfff6c9c6)
          : AppColors.THEME_COLOR;
    }
  }
}
