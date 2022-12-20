import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home_page.dart';
import '../pages/login/login_view.dart';
import '../pages/weekly_list/weekly_list_view.dart';
import '../xfyy/main.dart';
import '../xfyy/text_to_voice.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    // GetPage(name: AppRoutes.INITIAL, page:()=> SplashPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> TestApp(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> LoginPageNew(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> SplashPage(),),
    GetPage(name: AppRoutes.INITIAL, page:()=> LoginPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> MyHomePage(title: "ceshi",),),
    GetPage(name: AppRoutes.HOME, page:()=> HomePage(),),
    GetPage(name: AppRoutes.TextToVoice, page:()=> TextToVoice(),),
    GetPage(name: AppRoutes.LOGIN, page:()=>LoginPage(),),
    GetPage(name: AppRoutes.WeeklyList, page:()=>WeeklyListPage(),),
  ];
}