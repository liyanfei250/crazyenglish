import 'dart:io';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/net/net_manager.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http_proxy_override/http_proxy_override.dart';

import '../config.dart';
import '../utils/sp_util.dart';
import 'AppUtil.dart';
import 'package:get_storage/get_storage.dart';
class Global {
  //初始化全局信息
  static Future init(VoidCallback callback,{bool isTeacher = false}) async {
    WidgetsFlutterBinding.ensureInitialized();
    if(Platform.isAndroid || Platform.isIOS){
    //  设置http代理
      HttpOverrides.global = await HttpProxyOverride.createHttpProxy();
    }

    await GetStorage.init();
    // BotToastInit();
    await SpUtil.getInstance();
    if(isTeacher){
      SpUtil.putBool(BaseConstant.IS_TEACHER_LOGIN,isTeacher);
    }

    if(Platform.isAndroid || Platform.isIOS){
      await FkUserAgent.init();

    }

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
    Util.getHeader();
    callback();
  }
}
