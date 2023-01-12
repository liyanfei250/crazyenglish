import 'package:crazyenglish/config.dart';
import 'package:crazyenglish/pages/reading_catalog/reading_catalog_view.dart';
import 'package:crazyenglish/pages/reading_detail/reading_detail_view.dart';
import 'package:crazyenglish/pages/week_test_catalog/week_test_catalog_view.dart';
import 'package:crazyenglish/pages/week_test_detail/week_test_detail_view.dart';
import 'package:crazyenglish/pages/week_test_list/week_test_list_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../entity/paper_category.dart';
import '../pages/home_page.dart';
import '../pages/intensive_listening/intensive_listening_view.dart';
import '../pages/login/login_view.dart';
import '../pages/reading_list/reading_list_view.dart';
import '../pages/splash_page.dart';
import '../pages/week_test_detail/week_detail_view.dart';
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
    GetPage(name: AppRoutes.WeeklyList, page:()=>ReadingListPage(),),
    GetPage(name: AppRoutes.PaperCategory, page:()=>Reading_catalogPage(),),
    GetPage(name: AppRoutes.PaperDetail, page:()=>Reading_detailPage(),),
    GetPage(name: AppRoutes.WeeklyTestList, page:()=>WeekTestListPage(),),
    GetPage(name: AppRoutes.WeeklyTestCategory, page:()=>WeekTestCatalogPage(),),
    GetPage(name: AppRoutes.WeeklyTestDetail, page:()=>WeekTestDetailPage(),),
    GetPage(name: AppRoutes.IntensiveListeningPage, page:()=>IntensiveListeningPage(),),

  ];
}