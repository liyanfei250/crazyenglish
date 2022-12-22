import '../api/api.dart';
import '../entity/base_resp.dart';
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

  Future<WeekPaperResponse> getWeekPaperList(Map<String,String> req) async{
    BaseResp<Map<String, dynamic>?> baseResp = await NetManager.getInstance()!
        .request<Map<String, dynamic>>(Method.post, Api.getWeekPaperList,
        data: req);
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.obj !=null){

      WeekPaperResponse weekPaperResponse = WeekPaperResponse.fromJson(baseResp.obj);
      return weekPaperResponse!;
    } else {
      return Future.error("返回weekPaperResponse为空");
    }
  }


}