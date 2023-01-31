import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import '../config.dart';
import '../net/net_manager.dart';
import '../r.dart';
import 'object_util.dart';
import 'package:html/parser.dart' show parse;
import 'dart:ui' as ui;

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


  static String parseHtmlString(String? htmlString) {
    var document = parse(htmlString);
    return document.body!.text;
  }

  static Future<CroppedFile?> crop(String filePath,bool is4x1Picture) async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio:is4x1Picture?CropAspectRatio(ratioX: 360.w,ratioY:90.w):CropAspectRatio(ratioX: 360.w,ratioY:360.w),
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
  }

  static Widget buildBackWidget(BuildContext context){
    return
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        Get.back();
      },
      child:
      Center(
          child: Container(
            width: Util.setWidth(20) as double?,
            height: Util.setWidth(20) as double?,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: Util.setWidth(13) as double),
            child: Image.asset(
              R.imagesIconBackBlack,fit: BoxFit.fill,),
          ),
      ),
    );
  }

  static Widget buildCloseWidget(BuildContext context){
    return
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          Get.back();
        },
        child:
        Center(
          child: Image.asset(
            R.imagesIconClose,
            width: Util.setWidth(40) as double?,height: Util.setWidth(40) as double?,),
        ),
      );
  }

  static Widget buildBlackBackWidget(BuildContext context,{Function()? onBackTap}){
    return
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          if(onBackTap!=null){
            onBackTap.call();
          }else{
            Get.back();
          }
        },
        child:
        Center(
          child: Image.asset(
            R.imagesIconBackBlue,
            width: Util.setWidth(45) as double?,height: Util.setWidth(45) as double?,),
        ),
      );
  }

  static num buildBackWidgetWidth(){
    return Util.setWidth(27.5);
  }

  static num setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static num setSP(double sp) {
    return ScreenUtil().setSp(sp);
  }

  static String formatNum(int num){
    if(num<0){
      return "";
    }else if(num<10000){
      return num.toString();
    }else if(num<1000000){
      return formartFloatNum(num/10000,1)+"w";
    }else {
      return (num/10000).toString()+"w";
    }
  }

  /**
   * target  要转换的数字
   * postion 要保留的位数
   * isCrop  true 直接裁剪 false 四舍五入
   */
  static String formartFloatNum(num target, int postion, {bool isCrop = false}) {
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
      String t3 =  postion>0?".":"";

      for (int i = 0; i < postion; i++) {
        t3 += "0";
      }
      return t + t3;
    }
  }

  static Future<Map<String,String>> getHeaderParams() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var appname = "crazyenglish";
    return {
      "appname": appname,
      "screensize": "1080*1920",
      "platform": Platform.isAndroid? "android_phone_10":Platform.isIOS? "ios_phone_10":"android_phone_10",
      "vcode": packageInfo.buildNumber,
      "pversion": Config.versionName,
      "appId": Config.appId,
      "version": Config.versionName,
      "channel": "flutter",
      "vendor": appname,
      "imei":"223232323",
    };
  }

  static getHeader() {
    try {
      getHeaderParams().then((value){
        NetManager.getInstance()!.setHeaders(value);
      });
    } catch (exception) {
      Util.toast(exception.toString());
    }
  }

  static toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  static toastLong(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
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

  static bool isLoginCheckYK() {
    return ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.Sid)) && SpUtil.getObject(BaseConstant.loginUser)!=null;
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
}
