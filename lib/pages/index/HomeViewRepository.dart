import 'package:dio/dio.dart';

import '../../api/api.dart';
import '../../entity/base_resp.dart';
import '../../entity/review/HomeListDate.dart';
import '../../net/net_manager.dart';

class HomeViewRepository {
  Future<HomeListDate> getHomeList(String id) async {
    BaseResp baseResp = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeList,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if (baseResp.getReturnData() != null) {
      HomeListDate paperDetail =
          HomeListDate.fromJson(baseResp.getReturnData());
      return paperDetail!;
    } else {
      return Future.error("返回HomeListDateResponse为空");
    }
  }
}
