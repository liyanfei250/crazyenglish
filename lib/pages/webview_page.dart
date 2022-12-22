import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/config.dart' as config;
import 'package:crazyenglish/utils/Util.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../entity/apple_pay_item.dart';

//定义返回按钮类型
enum BackIconType { close, closeAlways, back }

// ignore: must_be_immutable
class WebViewPage extends StatefulWidget {
  const WebViewPage(
      {Key? key,
      this.title = "疯狂英语",
      this.url,
      this.showAppBar = false,
      this.showStatusBar = false,
      this.showH5Title = false,
      this.backIconType =  BackIconType.back,
      this.isMyOrder = false})
      : super(key: key);

  final String? title;
  final String? url;
  final bool? showAppBar;
  final bool? showStatusBar;
  final bool? showH5Title;
  final bool? isMyOrder;
  final BackIconType? backIconType;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  //webView UA
  String? webUrl;
  String? subTitleUrl;
  String? pageTitle;
  String? pageSubTitle = "";
  bool? showAppBar = false;
  bool? showStatusBar = false;
  bool? showH5Title = false;
  bool toggleShareBtn = false;
  bool toggleShowSubBtn = false;
  bool? isMyOrder = false;
  double lineProgress = 0;
  bool needRefreshInitUrl = false;
  String applePayReloadUrl = "";
  BackIconType backIconType = BackIconType.back;
  StreamSubscription<ApplePayItem>? _appleAuthSubs;
  StreamSubscription<Map<String,String>>? _applePayReloadUrl;
  String mWxPayNextUrl = "";
  //控制器
  // late InAppWebViewController _controller ;


  @override
  void initState() {
    super.initState();
    String testUrl  = "";
    // testUrl = "http://10.155.63.184:30033/flutterDemo";
    webUrl = widget.url!;
    backIconType = widget.backIconType!;
    pageTitle = widget.title;
    showAppBar = widget.showAppBar;
    showStatusBar = widget.showStatusBar;
    showH5Title = widget.showH5Title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: webUrl!,
          javascriptMode: JavascriptMode.unrestricted,
        );
        // return InAppWebView(
        //   initialUrlRequest: URLRequest(url:Uri.parse(webUrl!)),
        //   onWebViewCreated: (controller){
        //     _controller = controller;
        //   },
        // );
      }),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

  //显示隐藏 分享按钮
  _buildAppBar() {
    //显示系统导航栏
    if (showAppBar!) {
      return AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          icon: _buildBackIcon(),
          onPressed: () async{
            ///点击返回按钮
            // if (backIconType == BackIconType.back && _controller!=null) {
            //   //返回按钮
            //     bool canGoBack = await _controller.canGoBack();
            //     if (canGoBack) {
            //       _controller.goBack();
            //     } else {
            //       Get.back();
            //     }
            // } else {
              //关闭按钮
              Get.back();
            // }
          },
        ),
        title: Text(
          widget.title!,
          style: TextStyle(
              color: AppColors.c_FF32374E,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        bottom: _buildProgressBar(lineProgress, context),
      );
    }
    //只显示状态栏
    if (showStatusBar!) {
      return PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().statusBarHeight),
        child: Container(
          color: Colors.grey,
          alignment: Alignment.bottomCenter,
          height: ScreenUtil().statusBarHeight,
          child: _buildProgressBar(lineProgress, context),
        ),
      );
    }
  }

  ///变化返回按钮图标
  _buildBackIcon() {
    if (backIconType == BackIconType.back) {
      return Icon(
        Icons.arrow_back,
        size: 25,
        color: Colors.black,
      );
    } else {
      return Icon(
        Icons.close,
        size: 25,
        color: Colors.black,
      );
    }
  }


  ///浏览器网页加载进度条
  _buildProgressBar(double progress, BuildContext context) {
    return PreferredSize(
      child: Container(
        height: 1,
        child: LinearProgressIndicator(
          backgroundColor: Colors.green.withOpacity(0),
          value: progress == 1.0 ? 0 : progress,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),
        ),
      ),
      preferredSize: Size.fromHeight(0.1),
    );
  }


  @override
  void setState(VoidCallback fn) {
    super.setState(() {
      fn();
      print("set State");
    });
  }


  String getJs(Map<String, dynamic> map) {
    String jsonStr = json.encode(map);
    return 'javascript:window["koolearnApp2jsBridge.callback"]($jsonStr)';
  }
}
