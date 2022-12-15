import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:crazyenglish/routes/app_pages.dart';

import '../pages/webview_page.dart';
import '../routes/routes_utils.dart';
import 'Util.dart';
import 'object_util.dart';

class NavigatorUtil {
  static void pushPage(
    BuildContext context,
    Widget page, {
    String? pageName,
    bool needLogin = false,
  }) {
    if (context == null || page == null) return;
    if (needLogin && !Util.isLogin()) {
      // BlingabcRouter.push(context,
      //     module: MainRouters.moduleName,
      //     path: MainRouters.login);
      RouterUtil.toNamed(AppRoutes.LOGIN);
      return;
    }
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushWeb(BuildContext context,
      {String? title, String? titleId, String? url, bool isHome: false,bool needLogin = false,}) {
    if (context == null || ObjectUtil.isEmpty(url))
      return;
    if (needLogin && !Util.isLogin()) {
      RouterUtil.toNamed(AppRoutes.LOGIN);
      return;
    }
    Navigator.push(
        context,
        new CupertinoPageRoute<void>(
            builder: (ctx) => new WebViewPage(
                  title: title,
                  url: url,
                )));
  }


}
