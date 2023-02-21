import 'package:crazyenglish/pages/cashier/cashier_view.dart';
import 'package:crazyenglish/pages/order_sure/order_sure_view.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/pages/week_read/reading_catalog/reading_catalog_view.dart';
import 'package:crazyenglish/pages/week_read/reading_detail/reading_detail_view.dart';
import 'package:crazyenglish/pages/shop/shop_view.dart';
import 'package:crazyenglish/pages/shop_car/shop_car_view.dart';
import 'package:crazyenglish/pages/shoplist/view.dart';
import 'package:crazyenglish/pages/week_test/week_test_catalog/week_test_catalog_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_detail/week_test_detail_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_list/week_test_list_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home_page.dart';
import '../pages/intensive_listening/intensive_listening_view.dart';
import '../pages/my_order_list/view.dart';
import '../pages/order_detail/view.dart';
import '../pages/week_read/reading_list/reading_list_view.dart';
import '../pages/splash_page.dart';
import '../pages/user/login/login_view.dart';
import '../pages/writing/writing_view.dart';
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
    GetPage(name: AppRoutes.ToShoppingPage, page:()=>ToShoppingPage(),),
    GetPage(name: AppRoutes.ShoppingListPage, page:()=>ShoppingListPage(),),
    GetPage(name: AppRoutes.ShopCarPage, page:()=>ShopCarPage(),),
    GetPage(name: AppRoutes.OrderSurePage, page:()=>OrderSurePage(),),
    GetPage(name: AppRoutes.CashierPage, page:()=>CashierPage(),),
    GetPage(name: AppRoutes.OrderDetailPage, page:()=>OrderDetailPage(),),
    GetPage(name: AppRoutes.MyOrderPage, page:()=>MyOrderPage(),),
    GetPage(name: AppRoutes.WritingPage, page:()=>WritingPage(),),
    GetPage(name: AppRoutes.AnsweringPage, page:()=>AnsweringPage(),),

  ];
}