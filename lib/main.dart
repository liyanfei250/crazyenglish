import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazyenglish/base/bloc_wrapper.dart';
import 'package:crazyenglish/config.dart';
import 'package:get/get.dart';

import 'base/common.dart';
import 'base/global.dart';
import 'routes/app_pages.dart';

void main() {
  Config.env = Env.PRODUCT;
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
