import 'package:dio/dio.dart';

import '../api/api.dart';
import '../entity/base_resp.dart';
import '../entity/paper_category.dart';
import '../entity/paper_detail.dart';
import '../entity/week_paper_response.dart';
import '../net/net_manager.dart';

/**
 * Time: 2022/12/22 14:56
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class WeekRepository{

  Future<WeekPaper> getWeekPaperList(Map<String,String> req) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getWeekPaperList,
        data: req,options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.getReturnData() !=null){
      WeekPaperResponse weekPaperResponse = WeekPaperResponse.fromJson(baseResp.getReturnData());
      return weekPaperResponse.data!;
    } else {
      return Future.error("返回weekPaperResponse为空");
    }
  }


  Future<PaperCategory> getWeekPaperCategory(String periodicaId) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getWeekPaperCategory+periodicaId,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.getReturnData() !=null){

      PaperCategory paperCategory = PaperCategory.fromJson(baseResp.getReturnData());
      return paperCategory!;
    } else {
      return Future.error("返回weekPaperResponse为空");
    }
  }


  Future<PaperDetail> getWeekPaperDetail(String id) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getWeekPaperDetail+id,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.getReturnData() !=null){

      PaperDetail paperDetail = PaperDetail.fromJson(baseResp.getReturnData());
      return paperDetail!;
    } else {
      return Future.error("返回weekPaperResponse为空");
    }
  }



}