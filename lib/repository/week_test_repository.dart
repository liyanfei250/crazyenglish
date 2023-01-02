import 'package:crazyenglish/entity/week_test_catalog_response.dart';
import 'package:crazyenglish/entity/week_test_detail_response.dart';
import 'package:crazyenglish/entity/week_test_list_response.dart' as weekTest;
import 'package:dio/dio.dart';

import '../api/api.dart';
import '../entity/base_resp.dart';
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
        .request(Method.get, Api.getWeekTestList,
        data: req,options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if(baseResp.getReturnData() !=null){
      weekTest.WeekTestListResponse weekTestListResponse = weekTest.WeekTestListResponse.fromJson(baseResp.getReturnData());
      return weekTestListResponse.data!;
    } else {
      return Future.error("返回weekTestListResponse为空");
    }
  }


  Future<WeekTestCatalogResponse> getWeekPaperCategory(String periodicaId) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getWeekTestCategoryList+periodicaId,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if(baseResp.getReturnData() !=null){

      WeekTestCatalogResponse weekTestCatalogResponse = WeekTestCatalogResponse.fromJson(baseResp.getReturnData());
      return weekTestCatalogResponse!;
    } else {
      return Future.error("返回weekPaperResponse为空");
    }
  }


  Future<WeekTestDetailResponse> getWeekPaperDetail(String id) async{
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



}