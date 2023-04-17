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
import '../entity/SendCodeResponseNew.dart';
import '../entity/user_info_response.dart';

/**
 * Time: 2022/9/24 09:14
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class UserRepository {


  Future<LoginCodeResponse> mobileNewLogin(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!
        .request(Method.post, Api.getLoginNew, data: req);
    if(map!=null){
      LoginCodeResponse loginResponse = LoginCodeResponse.fromJson(map);
      if (loginResponse.code != ResponseCode.status_success) {
        Util.toast(loginResponse.message ?? "");
        return Future.error("返回LoginCodeResponse为空");
      }else{
        return loginResponse!;
      }
    }else{
      return Future.error("返回LoginCodeResponse为空");
    }
  }

  Future<LoginNewResponse> passwordLogin(Map<String, String> req) async {
    req.addAll({
      "grant_type":"password",
      "client_id":"app",
      "client_secret":"a119ed01622927d54cd67e10cbb9f7ad",
      "clientType":"0",
      "type":"0"});
    Map map = await NetManager.getInstance()!
        .request(Method.post, Api.getPsdLoginNew, data: req);
    LoginNewResponse loginResponse = LoginNewResponse.fromJson(map);
    if (loginResponse.code != ResponseCode.status_success) {
      Util.toast(loginResponse.message ?? "");
    }
    if (loginResponse != null) {
      return loginResponse!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }

  Future<SendCodeResponse> sendCode(String phone) async {
    Map map = await NetManager.getInstance()!
        .request(Method.get, Api.getSendCode + phone);
    SendCodeResponse sendCodeResponse = SendCodeResponse.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }

  Future<SendCodeResponseNew> sendCodeNew(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!
        .request(Method.post, Api.getSendAuthCodeNew, data: req);
    SendCodeResponseNew sendCodeResponse = SendCodeResponseNew.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }

  //重置密码和上面共用一个实体类接收
  Future<SendCodeResponseNew> sendResetPsd(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!
        .request(Method.post, Api.getResetPsdNew, data: req);
    SendCodeResponseNew sendCodeResponse = SendCodeResponseNew.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }

  //选择年级和用户类型和上面共用一个实体类接收
  Future<SendCodeResponseNew> sendChangeGrade(Map<String, int> req) async {
    Map map = await NetManager.getInstance()!
        .request(Method.post, Api.getChangeGrade, data: req);
    SendCodeResponseNew sendCodeResponse = SendCodeResponseNew.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }

  //获取用户信息
  Future<UserInfoResponse> getUserInfo() async {
    Map map =
        await NetManager.getInstance()!.request(Method.get, Api.getUserIofo);
    UserInfoResponse sendCodeResponse =
    UserInfoResponse.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }
}
