import 'package:crazyenglish/pages/reading_catalog/reading_catalog_view.dart';
import 'package:crazyenglish/pages/reading_detail/reading_detail_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../entity/paper_category.dart';
import '../pages/home_page.dart';
import '../pages/login/login_view.dart';
import '../pages/splash_page.dart';
import '../pages/weekly_list/weekly_list_view.dart';
import '../xfyy/main.dart';
import '../xfyy/text_to_voice.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    // GetPage(name: AppRoutes.INITIAL, page:()=> SplashPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> TestApp(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> LoginPageNew(),),
    GetPage(name: AppRoutes.INITIAL, page:()=> SplashPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> LoginPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> MyHomePage(title: "ceshi",),),
    GetPage(name: AppRoutes.HOME, page:()=> HomePage(),),
    GetPage(name: AppRoutes.TextToVoice, page:()=> TextToVoice(),),
    GetPage(name: AppRoutes.LOGIN, page:()=>LoginPage(),),
    GetPage(name: AppRoutes.WeeklyList, page:()=>WeeklyListPage(),),
    GetPage(name: AppRoutes.PaperCategory, page:()=>Reading_catalogPage(),),
    GetPage(name: AppRoutes.PaperDetail, page:()=>Reading_detailPage(),),
  ];
}