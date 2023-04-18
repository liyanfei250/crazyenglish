import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../entity/review/HomeListChoiceDate.dart';
import '../../../entity/review/HomeSecondListDate.dart';
import '../../../entity/review/HomeWeeklyChoiceDate.dart';
import '../../../net/net_manager.dart';

class ListRepository {
  Future<HomeListChoiceDate> getHomeListChoiceDate(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeListChoiceDate,
        options: Options(method: Method.get));
    HomeListChoiceDate paperDetail = HomeListChoiceDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<HomeSecondListDate> getListnerList(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeSecondListDate,
        options: Options(method: Method.get));
    HomeSecondListDate paperDetail = HomeSecondListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

}
