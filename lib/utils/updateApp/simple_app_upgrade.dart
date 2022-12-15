import 'dart:io';

import 'package:get/get.dart';
import 'package:crazyenglish/utils/updateApp/update_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../entity/check_update_resp.dart';
import '../Util.dart';
import '../colors.dart';
import '../date_util.dart';
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
      this.iosAppId = "1488425098",
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
        width: 285.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // width: 285,
              height: 156.h,
              child: Stack(
                children: [
                  Image.asset(
                    'images/bg_update_top.png',
                    height: Util.setHeight(156) as double?,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 22, top: 47.5),
                    child: Text(
                      '发现新版本',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 21.5, top: 86),
                    child: Text(
                      '推广大师',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                  )
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
    updateContent += "版本号 ：" + resp.newVersion!;
    updateContent +=
        "\n更新时间 ：" + DateUtil.formatDateMs(resp.publishDate);
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

  ///
  /// 点击确定按钮
  ///
  _clickOk() async {
    if(_downloadApkName.isEmpty){
      _downloadApkName = UpdateUtil().getApkNameByDownloadUrl(widget.downloadUrl);
    }

    widget.onOk?.call();
    if (Platform.isIOS) {
      //ios 需要跳转到app store更新，原生实现
      // FlutterUpgrade.toAppStore(widget.iosAppId!);
      FlutterUpgrade.toAppStore();
      return;
    }
    if (widget.downloadUrl == null || widget.downloadUrl.isEmpty) {
      //没有下载地址，跳转到第三方渠道更新，原生实现
      FlutterUpgrade.toMarket(appMarketInfo: widget.appMarketInfo!);
      return;
    }
    String path = await FlutterUpgrade.apkDownloadPath;
    _downloadApk(widget.downloadUrl, '$path/$_downloadApkName');
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
