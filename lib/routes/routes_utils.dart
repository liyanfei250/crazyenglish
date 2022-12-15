import 'package:get/get.dart';

import '../pages/webview_page.dart';
import '../utils/Util.dart';
import 'app_pages.dart';

/*
    RouterUtil是路由处理的唯一通道
  */
class RouterUtil {
  ///通过AppRoutes中的key跳转到某一页面
  static Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    bool isNeedCheckLogin = false,
    bool checkYKLogin = false,
  }) {
    if (isNeedCheckLogin &&
        (checkYKLogin ? !Util.isLoginCheckYK() : !Util.isLogin())) {
      return Get.toNamed(AppRoutes.LOGIN)!;
    }
    return Get.toNamed(page, arguments: arguments, parameters: parameters);
  }

  ///通过AppRoutes中的key跳转到某一页面
  static Future<T?>? offAndToNamed<T>(
      String page, {
        dynamic arguments,
        int? id,
        bool preventDuplicates = true,
        Map<String, String>? parameters,
        bool isNeedCheckLogin = false,
        bool checkYKLogin = false,
      }) {
    if (isNeedCheckLogin &&
        (checkYKLogin ? !Util.isLoginCheckYK() : !Util.isLogin())) {
      return Get.offAndToNamed(AppRoutes.LOGIN)!;
    }
    return Get.offAndToNamed(page, arguments: arguments, parameters: parameters);
  }


  ///通过AppRoutes中的key退出某一页面
  static Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Get.offNamed(page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }

  ///跳转到webView页面
  static Future<T?>? toWebPage<T>(
    String? url, {
    title,
    showAppBar = false,
    showStatusBar = false,
    showH5Title = false,
    backIconType = BackIconType.back,
    isMyOrder = false,
    bool isNeedCheckLogin = false,
    bool checkYKLogin = false,
  }) {
    if (isNeedCheckLogin &&
        (checkYKLogin ? !Util.isLoginCheckYK() : !Util.isLogin())) {
      return Get.toNamed(AppRoutes.LOGIN)!;
    }
    return Get.to(WebViewPage(
        title: title,
        url: url,
        showAppBar: showAppBar,
        showStatusBar: showStatusBar,
        backIconType: backIconType,
        showH5Title: showH5Title,
        isMyOrder: isMyOrder));
  }
}
