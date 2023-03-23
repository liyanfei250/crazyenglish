import 'package:dio/dio.dart';

import '../api/api.dart';
import '../entity/base_resp.dart';
import '../entity/datagroup_detail_response.dart';
import '../net/net_manager.dart';

/**
 * Time: 2023/1/12 14:03
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class OtherRepository{

  Future<DatagroupDetailResponse> getDataGroupDetail(String code) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getDataGroupDetail+code,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if(baseResp.getReturnData() !=null){
      DatagroupDetailResponse datagroupDetailResponse = DatagroupDetailResponse.fromJson(baseResp.getReturnData());
      return datagroupDetailResponse;
    } else {
      return Future.error("返回datagroupDetailResponse为空");
    }
  }
}