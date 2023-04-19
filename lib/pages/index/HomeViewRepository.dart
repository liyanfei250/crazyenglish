import 'package:dio/dio.dart';

import '../../api/api.dart';
import '../../entity/base_resp.dart';
import '../../entity/home/ClassInfoDate.dart';
import '../../entity/home/HomeMyJournalListDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/home/HomeSearchListDate.dart';
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

  //获取首页顶部搜索
  Future<HomeSearchListDate> getSearchDateList(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeSearchListDate,
        options: Options(method: Method.get));
    HomeSearchListDate paperDetail = HomeSearchListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
  //获取班级信息
  Future<ClassInfoDate> getClassInfo(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHClassInfoDate,
        options: Options(method: Method.get));
    ClassInfoDate paperDetail = ClassInfoDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}
