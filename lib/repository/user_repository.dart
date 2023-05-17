import 'dart:io';

import 'package:crazyenglish/entity/check_update_resp.dart';
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
import '../entity/home/CommentDate.dart';
import '../entity/user_info_response.dart';

/**
 * Time: 2022/9/24 09:14
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class UserRepository {

  Future<LoginNewResponse> passwordLogin(Map<String, String> req) async {
    req.addAll({
      "grant_type": "password",
      "client_id": "app",
      "client_secret": "a119ed01622927d54cd67e10cbb9f7ad",
      "clientType": "2",
    });
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

  Future<BaseResp> mobileExists(String mobile) async {
    Map map = await NetManager.getInstance()!
        .request(Method.get, Api.getMobileExists+"$mobile");
    BaseResp baseResp = BaseResp.fromJson(map);
    if (baseResp.code != ResponseCode.status_success) {
      Util.toast(baseResp.message ?? "");
    }
    if (baseResp != null) {
      return baseResp!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }


  Future<SendCodeResponseNew> sendCodeNew(String phone,String type) async {
    Map map = await NetManager.getInstance()!
        .request(Method.get, "${Api.getSendAuthCodeNew}$phone/$type");
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
        .request(Method.put, Api.getResetPsdNew, data: req,
        options: Options(method: Method.put,contentType: ContentType.json.toString())
    );
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
        .request(Method.post, Api.getChangeGrade, data: req,
    );
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
  Future<UserInfoResponse> getUserInfo(String user) async {
    Map map = await NetManager.getInstance()!.request(Method.get, Api.getUserIofo + user);
    UserInfoResponse sendCodeResponse = UserInfoResponse.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }


  //提交头像
  Future<CommentDate> toPushHeaderImage(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.toPushHeaderImage,
        data: req, options: Options(method: Method.post));
    CommentDate paperDetail = CommentDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //修改昵称
  Future<CommentDate> toChangePersonInfo(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.put, Api.putUserIofo,
        data: req, options: Options(method: Method.put));
    CommentDate paperDetail = CommentDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}