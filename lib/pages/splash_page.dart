import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;

import '../base/common.dart';
import '../r.dart';
import '../routes/app_pages.dart';
import '../routes/routes_utils.dart';
import '../utils/colors.dart';
import '../utils/sp_util.dart';
import 'webview_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {

  String privacyAgreementContent = "亲爱的用户，欢迎你使用英语周报！我们将依据隐私政策和服务条款来帮助你了解我们在收集、使用、存储和共享你的个人信息的情况以及你享有的相关权利。<br><br>为保障服务所必须，<b>我们会收集你的设备信息和日志信息。</b><br><br>你可以通过阅读完整的<a href=\"${C.REGISTER_LAW}\" contenteditable=\"false\" target=\"_blank\">《用户协议》</a>和<a href=\"${C.REGISTER_PRIVACY_POLICY_LAW}\" contenteditable=\"false\" target=\"_blank\">《隐私政策》</a>";


  var privacyAgreementTitle = "温馨提示";
  bool firstInstall = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
//1.首次安装
    firstInstall= SpUtil.getBool(BaseConstant.key_first_installation, defValue: true);
    Future.delayed(const Duration(seconds: 1), (){
      if(!firstInstall){
        _goMain();
      }

    });
  }


  void _goMain() {
    RouterUtil.offAndToNamed(AppRoutes.HOME,isNeedCheckLogin: true);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        context,
        designSize: const Size(375, 667));



    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: Container(
          color: AppColors.c_FFFAF7F7,
          // child: Image.asset(
          //   fit:BoxFit.cover,
          //   R.imagesSplash,
          //   width: double.infinity,
          //   height: double.infinity,),
        ),),

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
                    constraints: BoxConstraints(maxHeight: 400.h,minHeight: 200.h),
                    margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 15.h),
                    child: SingleChildScrollView(child: Html(data: privacyAgreementContent,

                      style: {"a":Style(color: AppColors.THEME_COLOR,textDecoration: TextDecoration.none)},
                      onLinkTap: (String? url, RenderContext rc, Map<String, String> attributes, dom.Element? element){
                        String title = "";
                        // if(rc!=null&&rc.tree!=null&&rc.tree.children!=null&&rc.tree.children.){
                        TextContentElement tce = rc.tree.children[0] as TextContentElement;

                        title = tce.text??"";
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
                            title: title,showStatusBar: true,showAppBar: true,showH5Title: true,backIconType: BackIconType.closeAlways);
                      },),),
                  ),

                  ///同意按钮
                  GestureDetector(
                    onTap: () {
                      //存储第一次安装跟最后一次更新时间
                      //初始化用户权限
                      SpUtil.putBool(BaseConstant.key_first_installation, false);
                      _goMain();

                    },
                    child: Container(
                      width: 250.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                          color: AppColors.THEME_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(50.w))),
                      child: Center(
                        child: Text(
                          "同意并继续",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                              color: AppColors.c_FFFFFFFF, fontSize: 16.w),
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
                              color: AppColors.THEME_COLOR, fontSize: 14.w),
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
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}
