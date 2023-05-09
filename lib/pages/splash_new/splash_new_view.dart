import 'dart:async';
import 'dart:io';

import 'package:crazyenglish/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/common.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../utils/sp_util.dart';
import '../webview_page.dart';
import 'splash_new_logic.dart';
import 'package:html/dom.dart' as dom;

class SplashPageNew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashNewPageState();
  }
}

class SplashNewPageState extends State<SplashPageNew> {
  final logic = Get.put(Splash_newLogic());
  final state = Get.find<Splash_newLogic>().state;
  String privacyAgreementContent =
      "亲爱的用户，欢迎你使用数组英语！我们将依据隐私政策和服务条款来帮助你了解我们在收集、使用、存储和共享你的个人信息的情况以及你享有的相关权利。<br><br>为保障服务所必须，<b>我们会收集你的设备信息和日志信息。</b><br><br>你可以通过阅读完整的<a href=\"${C.REGISTER_LAW}\" contenteditable=\"false\" target=\"_blank\">《用户协议》</a>和<a href=\"${C.REGISTER_PRIVACY_POLICY_LAW}\" contenteditable=\"false\" target=\"_blank\">《隐私政策》</a>";

  var privacyAgreementTitle = "温馨提示";
  bool firstInstall = false;

  @override
  void initState() {
    super.initState();
    //测试
    // SpUtil.putBool(BaseConstant.ISLOGING, true);
    // SpUtil.putString(
    //     BaseConstant.loginTOKEN, '++++6666');
    // Util.getHeader();
    //测试
    _init();
  }

  void _init() {
    //1.首次安装
    firstInstall =
        SpUtil.getBool(BaseConstant.key_first_installation, defValue: true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!firstInstall) {
        _goMain();
      }
    }
    );
  }

  void _goMain() {
    if (SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)) {
      RouterUtil.offAndToNamed(AppRoutes.TEACHER_HOME, isNeedCheckLogin: true);
    } else {
      RouterUtil.offAndToNamed(AppRoutes.HOME, isNeedCheckLogin: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: AppColors.theme_bg,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.imagesSplashBg), fit: BoxFit.cover),
            ),
          ),
          Positioned(
              top: 15.w,
              right: 15.w,
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 50.w, right: 27.w),
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      RouterUtil.offAndToNamed(AppRoutes.HOME,
                          isNeedCheckLogin: true);
                    },
                    child: Container(
                      height: 26.w,
                      width: 72.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //圆角半径
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18)),
                        //边框线宽、颜色
                        border: Border.all(width: 1.0, color: Colors.red),
                      ),
                      child: const Text('跳过',
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    )),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                R.imagesSplashCenterImage,
                width: 238.w,
                height: 212.w,
              ),
              SizedBox(
                height: 26.w,
              ),
              Image.asset(
                R.imagesSplashCenterText,
                width: 274.w,
                height: 54.w,
              ),
            ],
          ),
          Positioned(
            bottom: 20.w,
            child: Image.asset(
              R.imagesSplashBottomLogo,
              width: 109.w,
              height: 30.w,
            ),
          ),
          Offstage(
            offstage: !firstInstall,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.c_FFFFFFFF,
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                width: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///标题
                    Container(
                      margin: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 0),
                      child: Text(
                        privacyAgreementTitle,
                        maxLines: 1,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: AppColors.c_FF32374E,
                          fontSize: 15.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ///文本
                    Container(
                      constraints:
                          BoxConstraints(maxHeight: 400.h, minHeight: 200.h),
                      margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 15.h),
                      child: SingleChildScrollView(
                        child: Html(
                          data: privacyAgreementContent,
                          style: {
                            "a": Style(
                                color: AppColors.THEME_COLOR,
                                textDecoration: TextDecoration.none)
                          },
                          onLinkTap: (String? url,
                              RenderContext rc,
                              Map<String, String> attributes,
                              dom.Element? element) {
                            String title = "";
                            // if(rc!=null&&rc.tree!=null&&rc.tree.children!=null&&rc.tree.children.){
                            TextContentElement tce =
                                rc.tree.children[0] as TextContentElement;

                            title = tce.text ?? "";
                            // }

                            // BlingabcRouter.push(context,
                            //     module: MainRouters.moduleName,
                            //     path: MainRouters.web,
                            //     arguments: {
                            //       "title": title,
                            //       "url": url,
                            //       "showAppBar": true,
                            //       "showH5Title": true,
                            //       "showStatusBar": true,
                            //       "backIconType": BackIconType.closeAlways
                            //     });
                            RouterUtil.toWebPage(url,
                                title: title,
                                showStatusBar: true,
                                showAppBar: true,
                                showH5Title: true,
                                backIconType: BackIconType.closeAlways);
                          },
                        ),
                      ),
                    ),

                    ///同意按钮
                    GestureDetector(
                      onTap: () {
                        //存储第一次安装跟最后一次更新时间
                        //初始化用户权限
                        SpUtil.putBool(
                            BaseConstant.key_first_installation, false);
                        _goMain();
                      },
                      child: Container(
                        width: 250.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                            color: AppColors.THEME_COLOR,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.w))),
                        child: Center(
                          child: Text(
                            "同意并继续",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: AppColors.c_FFFFFFFF,
                                fontSize: 16.w),
                          ),
                        ),
                      ),
                    ),

                    ///退出按钮
                    GestureDetector(
                      onTap: () {
                        // SystemNavigator.pop();
                        exit(0);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10.h, 10.h, 10.h),
                        child: Center(
                          child: Text(
                            "退出应用",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: AppColors.THEME_COLOR,
                                fontSize: 14.w),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
