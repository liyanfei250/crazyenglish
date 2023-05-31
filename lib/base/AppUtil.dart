import 'dart:io';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/widgetPage/dialog_manager.dart';
import 'package:crazyenglish/entity/user_info_response.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../config.dart';
import '../net/net_manager.dart';
import '../pages/practise/result/result_view.dart';
import '../r.dart';
import '../utils/object_util.dart';
import 'package:html/parser.dart' show parse;
import 'dart:ui' as ui;

import '../utils/time_util.dart';

class Util {
  static num setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static Future<Uint8List?> imageToUnit8List(ui.Image image) async {
    ByteData? byteData = await image.toByteData();
    if (byteData != null) {
      Uint8List bytes = byteData.buffer.asUint8List();
      return bytes;
    }
    return null;
  }

  static bool isIOSMode() {
    if (Config.env == Env.IOS) {
      return true;
    } else {
      return false;
    }
  }

  static String parseHtmlString(String? htmlString) {
    var document = parse(htmlString);
    return document.body!.text;
  }

  static Future<CroppedFile?> crop(String filePath, bool is4x1Picture) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: is4x1Picture
          ? CropAspectRatio(ratioX: 90.w, ratioY: 90.w)
          : CropAspectRatio(ratioX: 90.w, ratioY: 90.w),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '图片裁剪',
            toolbarColor: AppColors.THEME_COLOR,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        IOSUiSettings(
          title: '图片裁剪',
        ),
      ],
    );
    return croppedFile;
  }

  static Html getHtmlWidget(String? htmlContent,{FontSize? fontSize}){
    fontSize ??= FontSize(14.sp);
    return Html(
      data: (htmlContent ?? "").replaceAll("\t", "&ensp;&ensp;"),
      onImageTap: (
          url,
          context,
          attributes,
          element,
          ) {
        if (url != null && url!.startsWith('http')) {
          DialogManager.showPreViewImageDialog(
              BackButtonBehavior.close, url);
        }
      },
      style: {
        "p": Style(
            textAlign: TextAlign.justify,
            color: const Color(0xff353e4d),
            fontSize: fontSize,margin: Margins.only(top: 0.w)),
        "sentence": Style(
            textDecorationStyle: TextDecorationStyle.dashed,
            textDecorationColor: AppColors.THEME_COLOR),
        "hr": Style(
          margin: Margins.only(
              left: 0, right: 0, top: 10.w, bottom: 10.w),
          padding: EdgeInsets.all(0),
          border: Border(bottom: BorderSide(color: Colors.grey)),
        )
      },
      tagsList: Html.tags..addAll(['sentence']),
    );
  }

  static initWhenEnterMain() async {
    // Wechat.instance.registerApp(
    //   appId: SnsLoginUtil.WECHAT_APPID,
    //   universalLink: SnsLoginUtil.WECHAT_UNIVERSAL_LINK,
    // );
    // Weibo.instance.registerApp(
    //     appKey: SnsLoginUtil.WEIBO_APP_KEY,
    //     universalLink: SnsLoginUtil.DEFAULT_REDIRECTURL,
    //     scope: SnsLoginUtil.WEIBO_SCOPE,
    //     redirectUrl: SnsLoginUtil.DEFAULT_REDIRECTURL);
    // await Tencent.instance.setIsPermissionGranted(granted: true);
    // Tencent.instance.registerApp(
    //     appId: SnsLoginUtil.TENCENT_APPID,
    //     universalLink: SnsLoginUtil.UNIVERSAL_LINK);
    // registerUmeng();
    FlutterBugly.init(
      androidAppId: Config.getAndroidBugly,
      iOSAppId: Config.getIosBugly,
    );
  }

  static Widget buildBackWidget(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.back();
      },
      child: Center(
        child: Container(
          width: Util.setWidth(20) as double?,
          height: Util.setWidth(20) as double?,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Util.setWidth(13) as double),
          child: Image.asset(
            R.imagesIconBackBlack,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  static UserInfoResponse? getUserInfoResponse(){
    Map? map = SpUtil.getObject(BaseConstant.USER_INFO);
    if(map!=null){
      return UserInfoResponse.fromJson(map);
    }
  }

  static Widget buildAnswerState(int state) {
    String text = "未答";
    BoxDecoration decoration;
    if (state == 1) {
      // 未答
      text = "未答";
      decoration = BoxDecoration(
          color: AppColors.c_FFF5F7FA,
          borderRadius: BorderRadius.all(Radius.circular(22.w)),
          border: Border.all(color: AppColors.c_FFD6D9DB, width: 1.w));
    } else if (state == 2) {
      // 答对
      text = "答对";
      decoration = BoxDecoration(
        color: AppColors.c_FF62C5A2,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    } else {
      // 答错
      text = "答错";
      decoration = BoxDecoration(
        color: AppColors.c_FFEC6560,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: EdgeInsets.only(left: 13.w)),
        Container(
          width: 10.w,
          height: 10.w,
          decoration: decoration,
        ),
        Padding(padding: EdgeInsets.only(left: 3.w)),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.c_FF878DA6,
              fontSize: 12.sp),
        )
      ],
    );
  }

  static Widget buildTopIndicator(
      num questionCount, num rightCount, num answerTime, String questionTypeStr,
      {bool isWritinPage = false}) {
    final customWidth01 = CustomSliderWidths(
        trackWidth: 6, progressBarWidth: 20, shadowWidth: 20);
    final customColors01 = CustomSliderColors(
        dotColor: Colors.white.withOpacity(0.8),
        trackColor: HexColor('#FFB648').withOpacity(0.6),
        progressBarColors: [
          AppColors.c_FFFFB648,
          AppColors.c_FFFFB648,
        ],
        shadowColor: HexColor('#FFD7E2'),
        shadowMaxOpacity: 0.08);

    final info = InfoProperties(
        mainLabelStyle: TextStyle(
            color: Colors.white, fontSize: 60, fontWeight: FontWeight.w100));
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 18.w, right: 18.w),
      padding: EdgeInsets.only(bottom:isWritinPage? 14.w:0.w),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFFFF,
        boxShadow: [
          BoxShadow(
            color: AppColors.c_FFD0C5B4.withOpacity(0.15), // 阴影的颜色
            offset: Offset(0.w, 0.w), // 阴影与容器的距离
            blurRadius: 3.w, // 高斯的标准偏差与盒子的形状卷积。
            spreadRadius: 1.w,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Visibility(
            visible: !isWritinPage,
            child: Container(
              width: 193.w,
              height: 193.w,
              margin: EdgeInsets.only(top: 30.w),
              child: SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: questionCount>0? (rightCount/questionCount)*100:0,
                appearance: CircularSliderAppearance(
                    customWidths: customWidth01,
                    customColors: customColors01,
                    infoProperties: info,
                    startAngle: 180,
                    angleRange: 180,
                    size: 350.0.w),
                onChange: null,
                onChangeStart: (double startValue) {
                  // callback providing a starting value (when a pan gesture starts)
                },
                onChangeEnd: null,
                innerWidget: (double value) {
                  //This the widget that will show current value
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 31.w)),
                      Text(
                        "正确率",
                        style: TextStyle(
                            fontSize: 14.w,
                            fontWeight: FontWeight.w600,
                            color: AppColors.c_FF898A93),
                      ),
                      Text(
                        "${rightCount}",
                        style: TextStyle(
                            fontSize: 40.w,
                            fontWeight: FontWeight.w600,
                            color: AppColors.c_FF1B1D2C),
                      ),
                      Text(
                        "/${questionCount}题",
                        style: TextStyle(
                            fontSize: 12.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.c_FF898A93),
                      ),
                    ],
                  );
                },
              ),
            ),

          ),
          Container(
            padding: EdgeInsets.only(left: 13.w, right: 13.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  child: Container(
                    height: 0.2.w,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 150.w),
                    color: AppColors.c_FFD2D5DC,
                  ),
                  visible: !isWritinPage,
                ),
                Padding(padding: EdgeInsets.only(top: 14.w)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          R.imagesResultTimeTips,
                          width: 12.w,
                          height: 12.w,
                        ),
                        Padding(padding: EdgeInsets.only(left: 7.w)),
                        Text(
                          "答题用时：",
                          style: TextStyle(
                              fontSize: 12.w,
                              color: AppColors.c_FFB3B7C6,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Text(
                      "${TimeUtil.getPractiseTime(answerTime.toInt())}",
                      style: TextStyle(
                          fontSize: 12.w,
                          color: AppColors.c_FFB3B7C6,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 9.w)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          R.imagesResultVectorTips,
                          width: 12.w,
                          height: 12.w,
                        ),
                        Padding(padding: EdgeInsets.only(left: 7.w)),
                        Text(
                          "习题类型：",
                          style: TextStyle(
                              fontSize: 12.w,
                              color: AppColors.c_FFB3B7C6,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Text(
                      "${questionTypeStr}",
                      style: TextStyle(
                          fontSize: 12.w,
                          color: AppColors.c_FFB3B7C6,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget buildCheckBox(GestureTapCallback callback,
      {bool chooseEnable = false}) {
    var choose = chooseEnable.obs;
    return InkWell(
      onTap: () {
        callback.call();
        choose.value = !choose.value;
      },
      child: Container(
        width: 16.w,
        height: 16.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff19e59),
                Color(0xffec5f2a),
              ]),
          borderRadius: BorderRadius.all(Radius.circular(6.w)),
          boxShadow: [
            BoxShadow(
              color: Color(0xffee754f).withOpacity(0.25), // 阴影的颜色
              offset: Offset(0.w, 4.w), // 阴影与容器的距离
              blurRadius: 6.w, // 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0.w,
            ),
          ],
        ),
        child: Obx(() => Visibility(
              visible: choose.value,
              child: Image.asset(
                R.imagesIconChooseCenter,
                width: 12.w,
                height: 12.w,
              ),
            )),
      ),
    );
  }

  static Widget buildHomeworkNormalBtn(GestureTapCallback callback, String text,
      {bool enable = true}) {
    return InkWell(
      onTap: () {
        enable?
        callback.call():null;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        height: 28.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                enable ? Color(0xfff19e59) : Color(0x80f19e59),
                enable ? Color(0xffec5f2a) : Color(0x80ec5f2a),
              ]),
          borderRadius: BorderRadius.all(Radius.circular(16.5.w)),
          boxShadow: [
            BoxShadow(
              color: Color(0xffee754f).withOpacity(0.25), // 阴影的颜色
              offset: Offset(0.w, 4.w), // 阴影与容器的距离
              blurRadius: 8.w, // 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0.w,
            ),
          ],
        ),
        child: Text(
          "$text",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static Widget buildWhiteWidget(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.back();
      },
      child: Center(
        child: Container(
          width: Util.setWidth(20) as double?,
          height: Util.setWidth(20) as double?,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Util.setWidth(13) as double),
          child: Image.asset(
            R.imagesIconBackWhite,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  static Widget buildCloseWidget(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.back();
      },
      child: Center(
        child: Image.asset(
          R.imagesIconClose,
          width: Util.setWidth(40) as double?,
          height: Util.setWidth(40) as double?,
        ),
      ),
    );
  }

  static Widget buildBlackBackWidget(BuildContext context,
      {Function()? onBackTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onBackTap != null) {
          onBackTap.call();
        } else {
          Get.back();
        }
      },
      child: Center(
        child: Image.asset(
          R.imagesIconBackBlue,
          width: Util.setWidth(45) as double?,
          height: Util.setWidth(45) as double?,
        ),
      ),
    );
  }

  static num buildBackWidgetWidth() {
    return Util.setWidth(27.5);
  }

  static num setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static num setSP(double sp) {
    return ScreenUtil().setSp(sp);
  }

  static String formatNum(int num) {
    if (num < 0) {
      return "";
    } else if (num < 10000) {
      return num.toString();
    } else if (num < 1000000) {
      return formartFloatNum(num / 10000, 1) + "w";
    } else {
      return (num / 10000).toString() + "w";
    }
  }

  /**
   * target  要转换的数字
   * postion 要保留的位数
   * isCrop  true 直接裁剪 false 四舍五入
   */
  static String formartFloatNum(num target, int postion,
      {bool isCrop = false}) {
    String t = target.toString();
    // 如果要保留的长度小于等于0 直接返回当前字符串
    if (postion < 0) {
      return t;
    }
    if (t.contains(".")) {
      String t1 = t.split(".").last;
      if (t1.length >= postion) {
        if (isCrop) {
          // 直接裁剪
          return t.substring(0, t.length - (t1.length - postion));
        } else {
          // 四舍五入
          return target.toStringAsFixed(postion);
        }
      } else {
        // 不够位数的补相应个数的0
        String t2 = "";
        for (int i = 0; i < postion - t1.length; i++) {
          t2 += "0";
        }
        return t + t2;
      }
    } else {
      // 不含小数的部分补点和相应的0
      String t3 = postion > 0 ? "." : "";

      for (int i = 0; i < postion; i++) {
        t3 += "0";
      }
      return t + t3;
    }
  }

  /*static Future<Map<String, String>> getHeaderParams() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var appname = "crazyenglish";
    Map<String, String> params = {
      "Appname": appname,
      "Screensize": "1080*1920",
      "Platform": Platform.isAndroid
          ? "android_phone_10"
          : Platform.isIOS
              ? "ios_phone_10"
              : "android_phone_10",
      // "vcode": packageInfo.buildNumber,
      "Pversion": Config.versionName,
      "appId": Config.appId,
      "Version": Config.versionName,
      "Channel": "flutter",
      "Vendor": appname,
      "Imei": "223232323",
    };
    if (SpUtil.getString(BaseConstant.loginTOKEN).isNotEmpty) {
      //params["Authorization"] = "Bearer "+SpUtil.getString(BaseConstant.loginTOKEN);
      params["Authorization"] = SpUtil.getString(BaseConstant.loginTOKEN);
    }
    return params;
  }*/
  static Map<String, String> getHeaderParams() {
    var appname = "crazyenglish";
    Map<String, String> params = {
      "Appname": appname,
      "Screensize": "1080*1920",
      "Platform": Platform.isAndroid
          ? "android_phone_10"
          : Platform.isIOS
              ? "ios_phone_10"
              : "android_phone_10",
      "Pversion": Config.versionName,
      "appId": Config.appId,
      "Version": Config.versionName,
      "Channel": "flutter",
      "Vendor": appname,
      "Imei": "223232323",
    };
    if (SpUtil.getString(BaseConstant.loginTOKEN).isNotEmpty) {
      params["Authorization"] =
          "Bearer " + SpUtil.getString(BaseConstant.loginTOKEN);
    }
    return params;
  }

  static getHeader() {
    try {
      NetManager.getInstance()!.setHeaders(getHeaderParams());
    } catch (exception) {
      Util.toast(exception.toString());
    }
  }

  static toast(String message) {
    BotToast.showText(text: message);
  }

  static toastLong(String message) {
    BotToast.showText(text: message);
  }

  static hidePhone(String phone) {
    if (phone.isEmpty) {
      return "";
    }
    return phone.replaceRange(3, 7, "****");
  }

  static bool isLogin() {
    return SpUtil.getBool(BaseConstant.ISLOGING);
    // return ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.Sid));
  }

  static bool isDesktop() {
    return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  }

  static bool isLoginCheckYK() {
    return ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.Sid)) &&
        SpUtil.getObject(BaseConstant.loginUser) != null;
  }

  static int getLoadStatus(bool hasError, List data) {
    if (hasError) return LoadStatus.fail;
    if (data == null) {
      return LoadStatus.loading;
    } else if (data.isEmpty) {
      return LoadStatus.empty;
    } else {
      return LoadStatus.success;
    }
  }

  static void reportErrorAndLog(FlutterErrorDetails details) {
    final errorMsg = {
      "exception": details.exceptionAsString(),
      "stackTrace": details.stack.toString(),
    };
    print("reportErrorAndLog : $errorMsg");
  }

  static FlutterErrorDetails makeDetails(Object error, StackTrace stackTrace) {
    // 构建错误信息
    return FlutterErrorDetails(stack: stackTrace, exception: error);
  }

  static bool isLoginPassword(String input) {
    /*RegExp passwordRegExp =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[^\w\d\s])[A-Za-z\d\W]{8,20}$');
    return passwordRegExp.hasMatch(input);*/

    if (input.length < 6 || input.length > 18) {
      return false;
    }

    int conditionsMet = 0;

    // 包含大写字母
    if (RegExp(r'[A-Z]').hasMatch(input)) {
      conditionsMet++;
    }

    // 包含小写字母
    if (RegExp(r'[a-z]').hasMatch(input)) {
      conditionsMet++;
    }

    // 包含数字
    if (RegExp(r'\d').hasMatch(input)) {
      conditionsMet++;
    }

    // 包含符号
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(input)) {
      conditionsMet++;
    }

    return conditionsMet >= 2;
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 7) {
      return phoneNumber;
    }
    String firstThree = phoneNumber.substring(0, 3);
    String lastFour = phoneNumber.substring(phoneNumber.length - 4);
    return '$firstThree****$lastFour';
  }

  static bool isPhoneNumberInChina(String phoneNumber) {
    RegExp chinaPhoneNumberRegExp = RegExp(r'^1\d{10}$');
    return chinaPhoneNumberRegExp.hasMatch(phoneNumber);
  }
}
