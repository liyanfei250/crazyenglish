// import 'package:weibo_kit/weibo_kit.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class SnsLoginUtil {
  static const String WECHAT_APPID = 'wxf814fbeed5ba5291';
  static const String WECHAT_UNIVERSAL_LINK =
      'https://app-download.crazyenglishweekly.com/'; // iOS 请配置
  static const String WECHAT_APPSECRET = '815f006d7476de1caeed7137801bc705';

  static const String TENCENT_APPID = '102024877';
  static const String UNIVERSAL_LINK =
      'https://dfhui.cn/'; // iOS 请配置

  static const String SINA_APPID = "1664693468";
  static const String SINA_SECRET = "019f33c253ea87c84464ce2bd185b476";


  static const String WEIBO_APP_KEY = '1571175609';
  static const List<String> WEIBO_SCOPE =<String>[
    // WeiboScope.ALL,
  ];
  static const DEFAULT_REDIRECTURL = 'http://sns.whalecloud.com/sina2/callback';


  static const SHAER_ICON = 'https://chuguo.koolearn.com/static/img/ielts_simple.png';


  // https://ps-1252082677.cos.ap-beijing.myqcloud.com
  static const String QCloud_bucketName = "test-1315843937";
  static const String QCloud_region = "ap-beijing";
  static const String QCloud_secretKey = "vgCTclhP6kADBwRioiMm04ua1Wp3LUUi";
  static const String QCloud_secretId = "AKIDMW7UfdPxIRRWQ5XnRyMniSxEHH5f5IHJ";
  static const String QCloud_path = "crazyenglish/app/";
  static const String QCloud_domain = "http://cdn-files-test.crazyenglishweekly.com/";



  Uri _encodeUrl(
      String baseUrl,
      String appkey,
      String? accessToken,
      Map<String, String?> params,
      ) {
    params['source'] = appkey;
    params['access_token'] = accessToken;
    final Uri baseUri = Uri.parse(baseUrl);
    final Map<String, List<String?>> queryParametersAll =
    Map<String, List<String>>.of(baseUri.queryParametersAll);
    for (final MapEntry<String, String?> entry in params.entries) {
      queryParametersAll.remove(entry.key);
      queryParametersAll.putIfAbsent(entry.key, () => <String?>[entry.value]);
    }
    return baseUri.replace(queryParameters: queryParametersAll);
  }


}
