import 'dart:io';

import 'package:get/get.dart';
import 'package:crazyenglish/utils/updateApp/update_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/AppUtil.dart';
import '../../entity/check_update_resp.dart';
import '../colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_market.dart';
import 'app_upgrade.dart';
import 'download_status.dart';
import 'flutter_upgrade.dart';

///
/// des:app升级提示控件
///
class SimpleAppUpgradeWidget extends StatefulWidget {


  const SimpleAppUpgradeWidget(
      {
      // required this.title,
      // this.titleStyle,
      // required this.contents,
      // this.contentStyle,
      // this.cancelText,
      // this.cancelTextStyle,
      // this.okText,
      // this.okTextStyle,
      // this.okBackgroundColors,
      // this.progressBar,
      // this.progressBarColor,
      // this.borderRadius = 10,
      required this.resp,
        required this.downloadUrl,
      this.forceUpdate = false,
      this.iosAppId = "6448911680",
      this.appMarketInfo,
      this.onCancel,
      this.onOk,
      this.downloadProgress,
      this.downloadStatusChange});

  final CheckUpdateResp resp;

  ///
  /// app安装包下载url,没有下载跳转到应用宝等渠道更新
  ///
  final String downloadUrl;

  ///
  /// 是否强制升级,设置true没有取消按钮
  ///
  final bool forceUpdate;

  ///
  /// ios app id,用于跳转app store
  ///
  final String? iosAppId ;

  ///
  /// 指定跳转的应用市场，
  /// 如果不指定将会弹出提示框，让用户选择哪一个应用市场。
  ///
  final AppMarketInfo? appMarketInfo;

  final VoidCallback? onCancel;
  final VoidCallback? onOk;
  final DownloadProgressCallback? downloadProgress;
  final DownloadStatusChangeCallback? downloadStatusChange;

  @override
  State<StatefulWidget> createState() {

   return _SimpleAppUpgradeWidget();}
}

class _SimpleAppUpgradeWidget extends State<SimpleAppUpgradeWidget> {
   String _downloadApkName = "" ;

  ///
  /// 下载进度
  ///
  double _downloadProgress = 0.0;

  DownloadStatus _downloadStatus = DownloadStatus.none;

  late Dio dio;

  late CancelToken token = CancelToken();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 271.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 19.w,top:19.w,right: 19.w),
                    child: Image.asset(
                      'images/bg_update_top.png',
                      height: Util.setHeight(101) as double?,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 22, top: 16,bottom: 10.w),
                    child: Text(
                      "发现新版本 V${widget.resp.newVersion}",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Color(0xFF282828),
                          decoration: TextDecoration.none),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: double.infinity,
              height: 200,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Text(
                    getUpdateContent(widget.resp),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
            _buildDownloadProgress(),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Row(
                children: [
                  widget.forceUpdate?
                  Container():
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _clickCancle();
                            Get.back();
                          },
                          child: Center(
                            child: Text(
                              "下次再说",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      )),
                  widget.forceUpdate?VerticalDivider(
                    width: Util.setWidth(0.5) as double?,
                    color: AppColors.c_FFECECEC,
                  ):Container(),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _clickOk();

                          },
                          child: Center(
                            child: Text(
                              "立即更新",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.THEME_COLOR,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 37,
            ),
            widget.forceUpdate?
            Container():
            Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 34,
                  width: 34,
                  child: Image.asset(
                    'images/icon_close_round_black.png',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// 构建版本更新信息
  ///
  String getUpdateContent(CheckUpdateResp resp) {
    String updateContent = "";
    updateContent +=
        "\n更新时间 ：${resp.publishDate}";
    // updateContent +=
    //     "\n更新时间 ：" + DateUtil.formatDateMs(resp.publishDate);
    updateContent += "\n更新说明 ：\n";
    updateContent += resp.updateDescription??"\n";
    return updateContent;
  }


  ///
  /// 下载进度widget
  ///
  Widget _buildDownloadProgress() {
    return (_downloadStatus == DownloadStatus.downloading)
        ? SizedBox(
            height: 2.h,
            width: 284.w,
            child: LinearProgressIndicator(
                value: _downloadProgress,
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(AppColors.THEME_COLOR)),
          )
        : Container();
  }

   final String _appStoreUrl = 'https://apps.apple.com/app/id6448911680'; // 替换为您应用程序的 App Store URL

   void _launchAppStore() async {
     if (await canLaunchUrl(Uri.parse(_appStoreUrl))) {
       await launchUrl(Uri.parse(_appStoreUrl));
     } else {
       throw 'Could not launch $_appStoreUrl';
     }
   }

  ///
  /// 点击确定按钮
  ///
  _clickOk() async {
    if(_downloadApkName.isEmpty){
      _downloadApkName = UpdateUtil().getApkNameByDownloadUrl(widget.downloadUrl);
    }

    widget.onOk?.call();
    if (Platform.isIOS) {
      _launchAppStore();
      return;
    }
    if (widget.downloadUrl == null || widget.downloadUrl.isEmpty) {
      //没有下载地址，跳转到第三方渠道更新，原生实现
      FlutterUpgrade.toMarket(appMarketInfo: widget.appMarketInfo!);
      return;
    }
    bool hasPermission = await FlutterUpgrade.hasInstallPersmission.call();
    if( hasPermission ){
      String path = await FlutterUpgrade.apkDownloadPath;
      _downloadApk(widget.downloadUrl, '$path/$_downloadApkName');
    } else {
      FlutterUpgrade.requestPersmission.call();
    }

  }

  _clickCancle(){
    if(token!=null){
        token.cancel("");
    }
  }

  ///
  /// 下载apk包
  ///
  _downloadApk(String url, String path) async {
    if (_downloadStatus == DownloadStatus.start ||
        _downloadStatus == DownloadStatus.downloading ||
        _downloadStatus == DownloadStatus.done) {
      print('当前下载状态：$_downloadStatus,不能重复下载。');
      return;
    }

    _updateDownloadStatus(DownloadStatus.start);
    try {
       dio = Dio();
      // token = CancelToken();
      await dio.download(url, path, cancelToken: token,onReceiveProgress: (int count, int total) {
        if (total == -1) {
          _downloadProgress = 0.01;
        } else {
          widget.downloadProgress?.call(count, total);
          _downloadProgress = count / total.toDouble();
          _downloadStatus = DownloadStatus.downloading;
        }
        setState(() {});
        if (_downloadProgress == 1) {
          //下载完成，跳转到程序安装界面
          _updateDownloadStatus(DownloadStatus.done);
          Navigator.pop(context);
          FlutterUpgrade.installAppForAndroid(path);
        }
      });
    } catch (e) {
      print('$e');
      _downloadProgress = 0;
      _updateDownloadStatus(DownloadStatus.error, error: e);
    }
  }

  _updateDownloadStatus(DownloadStatus downloadStatus, {dynamic error}) {
    _downloadStatus = downloadStatus;
    widget.downloadStatusChange?.call(_downloadStatus, error: error);
  }
}
