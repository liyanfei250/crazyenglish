import 'package:dio/dio.dart';

import '../../api/api.dart';
import '../../entity/base_resp.dart';
import '../../entity/review/HomeListDate.dart';
import '../../net/net_manager.dart';

class HomeViewRepository {
  Future<HomeListDate> getHomeList(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeList,
        options: Options(method: Method.get));
    HomeListDate paperDetail =
    HomeListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    }else{

      return paperDetail!;
    }
  }
}
