import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../entity/check_update_resp.dart';
import 'app_market.dart';
import 'download_status.dart';
import 'simple_app_upgrade.dart';

///
/// des:App 升级组件
///
class AppUpgrade {
  ///
  /// App 升级组件入口函数，在`initState`方法中调用此函数即可。不要在[MaterialApp]控件的`initState`方法中调用，
  /// 需要在[Scaffold]的`body`控件内调用。
  ///
  /// `context`: 用于`showDialog`时使用。
  ///
  /// `future`：返回Future<AppUpgradeInfo>，通常情况下访问后台接口获取更新信息
  ///
  ///
  /// `iosAppId`：ios app id,用于跳转app store,格式：idxxxxxxxx
  ///
  /// `appMarketInfo`：指定Android平台跳转到第三方应用市场更新，如果不指定将会弹出提示框，让用户选择哪一个应用市场。
  ///
  /// `onCancel`：点击取消按钮回调
  ///
  /// `onOk`：点击更新按钮回调
  ///
  /// `downloadProgress`：下载进度回调
  ///
  /// `downloadStatusChange`：下载状态变化回调
  ///
  static appUpgrade(
      BuildContext context,
      CheckUpdateResp resp, {
        String? iosAppId,
        AppMarketInfo? appMarketInfo,
        VoidCallback? onCancel,
        VoidCallback? onOk,
        DownloadProgressCallback? downloadProgress,
        DownloadStatusChangeCallback? downloadStatusChange,
      }) {

    bool forceUpdate = false;

    ///升级模式：0无提示，1提醒一次，2提醒多次，3强制更新
    forceUpdate = (resp.forceUpdate??0)>0;
    forceUpdate = false;
    _showUpgradeDialog(context, resp,
        apkDownloadUrl: resp.apkUrl.toString(),
        force: forceUpdate,
        iosAppId: iosAppId,
        appMarketInfo: appMarketInfo,
        onCancel: onCancel,
        onOk: onOk,
        downloadProgress: downloadProgress,
        downloadStatusChange: downloadStatusChange);
  }

  ///
  /// 展示app升级提示框
  ///
  static _showUpgradeDialog(
      BuildContext context,
      CheckUpdateResp resp, {
        required String apkDownloadUrl,
        bool force = false,
        String? iosAppId,
        AppMarketInfo? appMarketInfo,
        VoidCallback? onCancel,
        VoidCallback? onOk,
        DownloadProgressCallback? downloadProgress,
        DownloadStatusChangeCallback? downloadStatusChange,
      }) {
    showDialog(
        context: context,
        barrierDismissible: !force,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return !force;
            },
            child: CustomUpdateDialog(
              conter: SimpleAppUpgradeWidget(
                  downloadUrl: apkDownloadUrl,
                  resp: resp,
                  forceUpdate: force,
                  iosAppId: iosAppId,
                  appMarketInfo: appMarketInfo,
                  onCancel: onCancel,
                  onOk: onOk,
                  downloadProgress: downloadProgress,
                  downloadStatusChange: downloadStatusChange),
            ),
            // child: Dialog(
            //
            //     child: Container(
            //       color: Colors.transparent,
            //       child: SimpleAppUpgradeWidget(
            //
            //         downloadUrl: apkDownloadUrl,
            //         resp: resp,
            //         force: force,
            //         iosAppId: iosAppId,
            //         appMarketInfo: appMarketInfo,
            //         onCancel: onCancel,
            //         onOk: onOk,
            //         downloadProgress: downloadProgress,
            //         downloadStatusChange: downloadStatusChange
            //     ),)),
          );
        });
  }
}

class AppInfo {
  AppInfo({this.versionName, this.versionCode, this.packageName});

  String? versionName;
  String? versionCode;
  String? packageName;
}

class CustomUpdateDialog extends Dialog {
  Widget conter;

  CustomUpdateDialog({required this.conter});

  @override
  Widget build(BuildContext context) {
    return conter;
  }
}

class AppUpgradeInfo {
  AppUpgradeInfo(
      {required this.title,
        required this.contents,
        this.apkDownloadUrl,
        this.force = false});

  ///
  /// title,显示在提示框顶部
  ///
  final String title;

  ///
  /// 升级内容
  ///
  final List<String> contents;

  ///
  /// apk下载url
  ///
  final String? apkDownloadUrl;

  ///
  /// 是否强制升级
  ///
  final bool force;
}

///
/// 下载进度回调
///
typedef DownloadProgressCallback = Function(int count, int total);

///
/// 下载状态变化回调
///
typedef DownloadStatusChangeCallback = Function(DownloadStatus downloadStatus,
    {dynamic error});
