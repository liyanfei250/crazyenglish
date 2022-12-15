import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home_page.dart';
import '../pages/login/login_view.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    // GetPage(name: AppRoutes.INITIAL, page:()=> SplashPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> TestApp(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> LoginPageNew(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> SplashPage(),),
    GetPage(name: AppRoutes.INITIAL, page:()=> LoginPage(),),
    GetPage(name: AppRoutes.HOME, page:()=> HomePage(),),
    GetPage(name: AppRoutes.LOGIN, page:()=>LoginPage(),),
  ];
}