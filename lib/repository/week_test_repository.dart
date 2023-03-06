import 'dart:io';

import 'package:crazyenglish/entity/week_directory_response.dart';
import 'package:crazyenglish/entity/week_test_catalog_response.dart';
import 'package:crazyenglish/entity/week_test_detail_response.dart';
import 'package:crazyenglish/entity/week_list_response.dart' as weekTest;
import 'package:dio/dio.dart';

import '../api/api.dart';
import '../entity/base_resp.dart';
import '../entity/check_update_resp.dart';
import '../entity/user_info_response.dart';
import '../net/net_manager.dart';

/**
 * Time: 2022/12/22 14:56
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class WeekTestRepository{

  Future<weekTest.Data> getWeekTestList(Map<String,String> req) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getWeeklyList,
        data: req,options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if(baseResp.getReturnData() !=null){
      weekTest.WeekListResponse weekTestListResponse = weekTest.WeekListResponse.fromJson(baseResp.getReturnData());
      return weekTestListResponse.data!;
    } else {
      return Future.error("返回weekTestListResponse为空");
    }
  }


  Future<WeekDirectoryResponse> getWeekTestCategory(String periodicaId) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(data:{"uuid":periodicaId},Method.get, Api.getWeeklyDirectory,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if(baseResp.getReturnData() !=null){

      WeekDirectoryResponse weekTestCatalogResponse = WeekDirectoryResponse.fromJson(baseResp.getReturnData());
      return weekTestCatalogResponse!;
    } else {
      return Future.error("返回weekPaperResponse为空");
    }
  }


  Future<WeekTestDetailResponse> getWeekTestDetail(String id) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getWeekTestDetail+id,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if(baseResp.getReturnData() !=null){

      WeekTestDetailResponse weekTestDetailResponse = WeekTestDetailResponse.fromJson(baseResp.getReturnData());
      return weekTestDetailResponse!;
    } else {
      return Future.error("返回weekTestDetailResponse为空");
    }
  }

  Future<CheckUpdateResp> getAppVersion() async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getAppVersion+(Platform.isAndroid? "1":"2"),
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if(baseResp.getReturnData() !=null){
      CheckUpdateResponse checkUpdateResp = CheckUpdateResponse.fromJson(baseResp.getReturnData());
      return checkUpdateResp!.data!;
    } else {
      return Future.error("返回CheckUpdateResp为空");
    }
  }

  //获取用户信息
  Future<UserInfoResponse> getUserInfo() async {
    BaseResp baseResp =
    await NetManager.getInstance()!.request(Method.get, Api.getUserIofo);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }

    UserInfoResponse sendCodeResponse =
    UserInfoResponse.fromJson(baseResp.getReturnData());
    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }


  }



}