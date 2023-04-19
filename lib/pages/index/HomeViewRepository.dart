import 'package:dio/dio.dart';

import '../../api/api.dart';
import '../../entity/base_resp.dart';
import '../../entity/home/HomeMyJournalListDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/review/HomeListDate.dart';
import '../../net/net_manager.dart';

class HomeViewRepository {
  Future<HomeListDate> getHomeList(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeList,
        options: Options(method: Method.get));
    HomeListDate paperDetail = HomeListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //获取首页我的期刊，学生端
  Future<HomeMyJournalListDate> getMyJournalList(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeMyJournalListDate,
        options: Options(method: Method.get));
    HomeMyJournalListDate paperDetail = HomeMyJournalListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //获取首页我的任务
  Future<HomeMyTasksDate> getMyTask(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeMyTasksDate,
        options: Options(method: Method.get));
    HomeMyTasksDate paperDetail = HomeMyTasksDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}
