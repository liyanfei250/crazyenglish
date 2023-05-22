import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazyenglish/base/bloc_wrapper.dart';
import 'package:crazyenglish/config.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base/common.dart';
import 'base/global.dart';
import 'routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Config.env = Env.NEIBU;
  Global.init(() {
    runApp(BlocWrapper(child: MyApp()));
  });
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: AppRoutes.INITIALNew,
      getPages: AppPages.pages,
      theme: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(color: Colors.white),
      ),
    );
  }

}
