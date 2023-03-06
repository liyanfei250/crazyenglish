import 'package:crazyenglish/pages/listening/listening_practice/listening_practice_view.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/pages/splash_new/splash_new_view.dart';
import 'package:crazyenglish/pages/user/auth_code/auth_code_view.dart';
import 'package:crazyenglish/pages/user/login_new/login_new_view.dart';
import 'package:crazyenglish/pages/user/set_psd/set_psd_view.dart';
import 'package:crazyenglish/pages/week_read/reading_catalog/reading_catalog_view.dart';
import 'package:crazyenglish/pages/week_read/reading_detail/reading_detail_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_catalog/week_test_catalog_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_detail/week_test_detail_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_list/week_test_list_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../drawable_test/draggable_demo.dart';
import '../drawable_test/draggable_demo.dart';
import '../pages/buy/cashier/cashier_view.dart';
import '../pages/buy/my_order_list/my_order_list_view.dart';
import '../pages/buy/order_detail/view.dart';
import '../pages/buy/order_sure/order_sure_view.dart';
import '../pages/buy/shop/shop_view.dart';
import '../pages/buy/shop_car/shop_car_view.dart';
import '../pages/buy/shoplist/view.dart';
import '../pages/home_page.dart';
import '../pages/intensive_listening/intensive_listening_view.dart';
import '../pages/practise/result/result_view.dart';
import '../pages/user/mine_setting/mine_setting_view.dart';
import '../pages/user/role/role_view.dart';
import '../pages/user/role_two/role_two_view.dart';
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
    GetPage(name: AppRoutes.INITIALNew, page:()=> SplashPageNew(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> LoginPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> MyHomePage(title: "ceshi",),),
    GetPage(name: AppRoutes.HOME, page:()=> HomePage(),),
    GetPage(name: AppRoutes.LoginNew, page:()=> LoginNewPage(),),
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
    GetPage(name: AppRoutes.SettingPage, page:()=>SettingPage(),),
    GetPage(name: AppRoutes.WritingPage, page:()=>WritingPage(),),
    GetPage(name: AppRoutes.AnsweringPage, page:()=>AnsweringPage(),),
    GetPage(name: AppRoutes.ResultPage, page:()=>ResultPage(),),
    GetPage(name: AppRoutes.SetPsdPage, page:()=>SetPsdPage(),),
    GetPage(name: AppRoutes.AuthCodePage, page:()=>AuthCodePage(),),
    GetPage(name: AppRoutes.RolePage, page:()=>RolePage(),),
    GetPage(name: AppRoutes.RoleTwoPage, page:()=>RoleTwoPage(),),
    GetPage(name: AppRoutes.ListeningPracticePage, page:()=>ListeningPracticePage(),),
    GetPage(name: AppRoutes.DraggableDemo, page:()=>DraggableDemo(),),

  ];
}