import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazyenglish/base/bloc_wrapper.dart';
import 'package:crazyenglish/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base/global.dart';
import 'routes/app_pages.dart';
void main() {
  Config.env = Env.NEIBU;
  Global.init(() {
    FlutterBugly.postCatchedException(() {
      runApp(BlocWrapper(child: MyApp()));
    }, debugUpload: true);
  });
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver{
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // 设置状态栏透明和文字颜色
    _setStatusBarTransparent();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // 设置状态栏透明和文字颜色
      _setStatusBarTransparent();
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _setStatusBarTransparent() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Black status bar icons
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context,child)=>GetMaterialApp(
        defaultTransition: Transition.noTransition,
        locale: const Locale('zh', 'CN'),
        localizationsDelegates: const [
          // 添加 Refresh 的国际化代理
          RefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CN'), // 添加中文语言支持
          Locale('en', 'US'), // 添加英文语言支持
        ],
        builder: (context,child){
          final originalMediaQuery = MediaQuery.of(context);
          final customMediaQuery = originalMediaQuery.copyWith(
            textScaleFactor:
            1.0, // 这里将 textScaleFactor 设置为 1.0，即不跟随系统字体大小调整
          );
          return MediaQuery(data: customMediaQuery, child: BotToastInit()(context,child!),);
        },
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: AppRoutes.INITIALNew,
        getPages: AppPages.pages,
        theme: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(color: Colors.white),
        ),
      ));
  }

}
