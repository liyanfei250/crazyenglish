import 'dart:io';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/net/net_manager.dart';
import 'package:crazyenglish/utils/Util.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http_proxy_override/http_proxy_override.dart';

import '../config.dart';
import '../utils/sp_util.dart';

class Global {
  //初始化全局信息
  static Future init(VoidCallback callback) async {
    WidgetsFlutterBinding.ensureInitialized();
    //设置http代理
    HttpOverrides.global = await HttpProxyOverride.createHttpProxy();

    // BotToastInit();
    await SpUtil.getInstance();
    await FkUserAgent.init();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    String versionName = Config.versionName;
    String versionCode = Config.versionCode;
    String app = "Ielts";
    String appID = Config.appId;
    String tag = Platform.isAndroid ? "B" : "A1";
    try {
      platformVersion = FkUserAgent.userAgent!;
      BaseConstant.UA = platformVersion;
      print("srcUa:"+platformVersion);
      int i = BaseConstant.UA.indexOf(")");
      String startString = BaseConstant.UA.substring(0,i);
      String endString = BaseConstant.UA.substring(i,BaseConstant.UA.length);
      BaseConstant.UA = startString + ";Flutter; Koolearn; $app/$versionName; $tag/$appID/$versionCode"+endString;
      print("targetUa:"+BaseConstant.UA);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      if (Platform.isAndroid) {
        BaseConstant.UA = "Flutter/5.0 (Linux; Android 10; MI 9 Build/QKQ1.190825.002; wv; Koolearn; $app/$versionName; $tag/$appID/$versionCode) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/77.0.3865.120 MQQBrowser/6.2 TBS/045714 Mobile Safari/537.36";
      }else if (Platform.isIOS){
        BaseConstant.UA = "Mozilla/5.0 (iPhone; CPU iPhone OS 14_8_1 like Mac OS X;Koolearn; $app/$versionName; $tag/$appID/$versionCode) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148";
      }
    }
    Util.getHeader();
    callback();
  }
}
