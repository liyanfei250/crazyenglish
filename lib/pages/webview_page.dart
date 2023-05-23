import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/r.dart';

// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/config.dart' as config;
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
      this.backIconType = BackIconType.back,
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
  StreamSubscription<Map<String, String>>? _applePayReloadUrl;
  String mWxPayNextUrl = "";

  //控制器
  // late InAppWebViewController _controller ;

  //控制器
  // InAppWebViewController? _controller;
  // WebView? webView;
  late WebViewController _controller;
  double _progressValue = 0.0;
  bool isFinish = false;

  @override
  void initState() {
    super.initState();
    String testUrl = "";
    // testUrl = "http://10.155.63.184:30033/flutterDemo";
    webUrl = widget.url!;
    backIconType = widget.backIconType!;
    pageTitle = widget.title;
    showAppBar = widget.showAppBar;
    showStatusBar = widget.showStatusBar;
    showH5Title = widget.showH5Title;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              _progressValue = progress / 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _progressValue = 0.1;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _progressValue = 1.0;
              isFinish = true;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(webUrl!)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(webUrl!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          bool canGoBack = false;
          canGoBack = await _controller!.canGoBack();
          if (canGoBack) {
            _controller!.goBack();
          } else {
            Get.back();
          }
          if (canGoBack) {
            return false;
          } else {
            return false;
          }
        },
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            body: Column(
              children: [
                isFinish
                    ? SizedBox.shrink()
                    : Container(
                        height: 3,
                        width: MediaQuery.of(context).size.width,
                        child: LinearProgressIndicator(
                          value: _progressValue,
                          backgroundColor: Colors.grey[200],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                Expanded(
                  child: WebViewWidget(controller: _controller),
                ),
              ],
            ),
          );
          /*InAppWebView(
            initialUrlRequest: URLRequest(url:WebUri.uri(Uri.parse(webUrl!))),
            initialSettings: InAppWebViewSettings(
                javaScriptEnabled:true,
            ),
            onWebViewCreated: (controller){
              _controller = controller;
            },
            onReceivedServerTrustAuthRequest: (InAppWebViewController controller,
                URLAuthenticationChallenge challenge) async {
              return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
            },
          )*/

          ;
        }),
      ),
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
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            if (backIconType == BackIconType.back) {
              //返回按钮
              bool canGoBack = await _controller!.canGoBack();
              if (canGoBack) {
                _controller!.goBack();
              } else {
                Get.back();
              }
            } else {
              //关闭按钮
              Get.back();
            }
          },
          child: Center(
            child: Container(
              width: Util.setWidth(20) as double?,
              height: Util.setWidth(20) as double?,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: Util.setWidth(13) as double),
              child: Image.asset(
                R.imagesIconBackBlack,
                fit: BoxFit.fill,
              ),
            ),
          ),
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

  String getJs(Map<String, dynamic> map) {
    String jsonStr = json.encode(map);
    return 'javascript:window["showbg"]($jsonStr)';
  }
}
