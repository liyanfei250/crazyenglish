import 'package:crazyenglish/entity/check_update_resp.dart';
import 'package:crazyenglish/entity/login/LoginCodeResponse.dart';
import 'package:crazyenglish/entity/login/LoginNewResponse.dart';
import 'package:crazyenglish/entity/login_response.dart';
import 'package:crazyenglish/entity/push_msg.dart';
import 'package:crazyenglish/entity/send_code_response.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';

import '../../api/api.dart';
import '../../base/common.dart';
import '../../entity/base_resp.dart';
import '../../net/net_manager.dart';
import '../base/AppUtil.dart';

/**
 * Time: 2022/9/24 09:14
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class UserRepository {
  Future<LoginResponse> quickLogin(Map<String, String> req) async {
    req.addAll({"action": "loginCallBack"});
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.post, Api.getLogin, data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }

    LoginResponse loginResponse =
        LoginResponse.fromJson(baseResp.getReturnData());
    if (loginResponse != null) {
      return loginResponse!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }

  Future<LoginResponse> mobileLogin(Map<String, String> req) async {
    req.addAll({
      "grant_type": "sms_code",
      "client_id": "mobile",
      "client_secret": "e16b2ab8d12314bf4efbd6203906ea6c"
    });
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.post, Api.getLogin, data: req);
    if (baseResp.code != ResponseCode.status_success) {
      Util.toast(baseResp.msg ?? "");
    }
    LoginResponse loginResponse =
        LoginResponse.fromJson(baseResp.getReturnData());
    if (loginResponse != null) {
      return loginResponse!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }

  Future<LoginCodeResponse> mobileNewLogin(Map<String, String> req) async {
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.post, Api.getLoginNew, data: req);
    if (baseResp.code != ResponseCode.status_success) {
      Util.toast(baseResp.msg ?? "");
    }
    LoginCodeResponse loginResponse =
    LoginCodeResponse.fromJson(baseResp.getReturnData());
    if (loginResponse != null) {
      return loginResponse!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }

  Future<LoginNewResponse> passwordLogin(Map<String, String> req) async {
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.post, Api.getPsdLoginNew, data: req);
    if (baseResp.code != ResponseCode.status_success) {
      Util.toast(baseResp.msg ?? "");
    }
    LoginNewResponse loginResponse =
        LoginNewResponse.fromJson(baseResp.getReturnData());
    if (loginResponse != null) {
      return loginResponse!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }

  Future<SendCodeResponse> sendCode(String phone) async {
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getSendCode + phone);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }

    SendCodeResponse sendCodeResponse =
        SendCodeResponse.fromJson(baseResp.getReturnData());
    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }
}
