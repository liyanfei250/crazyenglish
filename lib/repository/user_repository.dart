import 'package:crazyenglish/entity/check_update_resp.dart';
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

/**
 * Time: 2022/9/24 09:14
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class UserRepository{

  Future<LoginResponse> quickLogin(Map<String,String> req) async{
    req.addAll({"action":"loginCallBack"});
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.post, Api.getLogin,
        data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.obj !=null){

      LoginResponse orderQuestionObj = LoginResponse.fromJson(baseResp.obj);
      return orderQuestionObj!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }

  Future<SendCodeResponse> sendCode(String phone) async{
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.get, Api.getSendCode+phone);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.obj !=null){

      SendCodeResponse orderQuestionObj = SendCodeResponse.fromJson(baseResp.obj);
      return orderQuestionObj!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }

  Future<LoginResponse> bindPhone(Map<String,String> req) async{
    req.addAll({"action":"bindMobile"});
    // code uid
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.post, Api.getUser,
        data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.obj !=null){

      LoginResponse orderQuestionObj = LoginResponse.fromJson(baseResp.obj);
      return orderQuestionObj!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }

  Future<LoginResponse> userInfo(Map<String,String> req) async{
    req.addAll({"action":"info"});
    // code uid
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.post, Api.getUser,
        data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.obj !=null){

      LoginResponse orderQuestionObj = LoginResponse.fromJson(baseResp.obj);
      return orderQuestionObj!;
    } else {
      return Future.error("返回LoginResponse为空");
    }
  }


  Future<bool> updateUserNick(String u_nick) async{
    Map<String,String> req = {"u_nick":u_nick};
    req.addAll({"action":"updateNick"});
    req.addAll({"user_id":SpUtil.getString(BaseConstant.userId)});
    // code uid
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.post, Api.getUser,
        data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return false;
    }
    return true;
  }

  Future<CheckUpdateResp> getAppVersion(Map<String,String> req) async{
    req.addAll({"action":"info"});
    // current_version =
    // code uid
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    req.addAll({"current_version":packageInfo.version});
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.post, Api.getAppVersion,
        data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }

    if(baseResp.obj !=null){
      CheckUpdateResp orderQuestionObj = CheckUpdateResp.fromJson(baseResp.obj);
      return orderQuestionObj!;
    } else {
      return Future.error("返回CheckUpdateResp为空");
    }
  }

  Future<PushMsgList> getPushList(Map<String,String> req) async{
    req.addAll({"action":"list"});
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.post, Api.getPush,
        data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.obj !=null){

      PushMsgList orderQuestionObj = PushMsgList.fromJson(baseResp.obj);
      return orderQuestionObj!;
    } else {
      return Future.error("返回列表PushMsgList为空");
    }
  }
}