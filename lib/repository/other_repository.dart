import 'dart:io';

import 'package:dio/dio.dart';

import '../api/api.dart';
import '../entity/home/HomeKingDate.dart';
import '../entity/review/HomeSecondListDate.dart';
import '../entity/review/HomeWeeklyChoiceDate.dart';
import '../net/net_manager.dart';

class OtherRepository {
  Future<HomeKingDate> getDictionaryDataByType(String type) async {
      Map map = await NetManager.getInstance()!.request(
          Method.get,
          options: Options(contentType: ContentType.json.toString()),
          Api.getHomeKingList + type);
      HomeKingDate paperDetail = HomeKingDate.fromJson(map);
      if (paperDetail.code != ResponseCode.status_success) {
        return Future.error(paperDetail.message!);
      } else {
        return paperDetail!;
      }
    }

  Future<HomeSecondListDate> getListnerList(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.getHomeSecondListDate,data: req,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
    HomeSecondListDate paperDetail = HomeSecondListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

}
