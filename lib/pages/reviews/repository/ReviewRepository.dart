import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../entity/base_resp.dart';
import '../../../entity/home/PractiseDate.dart';
import '../../../entity/review/CancellCollectDate.dart';
import '../../../entity/review/CollectDate.dart';
import '../../../entity/review/ErrorNoteTabDate.dart';
import '../../../entity/review/PractiseHistoryDate.dart';
import '../../../entity/review/ReviewHomeDetail.dart';
import '../../../entity/review/SearchCollectListDate.dart';
import '../../../entity/review/SearchRecordDate.dart';
import '../../../net/net_manager.dart';

class ReviewRepository {
  Future<ReviewHomeDetail> getReviewHomeDetail(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getReviewHomeDetail + id,
        options: Options(method: Method.get));
    ReviewHomeDetail paperDetail = ReviewHomeDetail.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<PractiseDate> getPracticeDateList(String id, String date) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getPracticeDateList + id + "/" + "$date",
        options: Options(method: Method.get));
    PractiseDate paperDetail = PractiseDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<PractiseHistoryDate> getPracticeRecordList(
      String id, String date) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getPracticeRecordList + id + "/" + "$date",
        options: Options(method: Method.get));
    PractiseHistoryDate paperDetail = PractiseHistoryDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<ErrorNoteTabDate> getErrorNoteTabDate(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getErrorNoteTabDateList,
        options: Options(method: Method.get));
    ErrorNoteTabDate paperDetail = ErrorNoteTabDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<SearchRecordDate> getSearchRecordList(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getSearchRecordDateList,
        options: Options(method: Method.get));
    SearchRecordDate paperDetail = SearchRecordDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<SearchCollectListDate> getCollectList(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getSearchCollectListDate,
        options: Options(method: Method.get));
    SearchCollectListDate paperDetail = SearchCollectListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //收藏
  Future<CollectDate> toCollect(int userid, String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.put, Api.toCollect + userid.toString() + "/" + id,
        options: Options(method: Method.put));
    CollectDate paperDetail = CollectDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}
