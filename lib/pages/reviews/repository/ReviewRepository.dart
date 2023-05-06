import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../entity/base_resp.dart';
import '../../../entity/home/ErrorNoteTab.dart';
import '../../../entity/home/HomeKingDate.dart';
import '../../../entity/home/PractiseDate.dart';
import '../../../entity/home/SearchCollectListDetail.dart';
import '../../../entity/review/CancellCollectDate.dart';
import '../../../entity/review/CollectDate.dart';
import '../../../entity/review/ErrorNoteTabDate.dart';
import '../../../entity/review/PractiseHistoryDate.dart';
import '../../../entity/review/ReviewHomeDetail.dart';
import '../../../entity/review/SearchCollectListDate.dart';
import '../../../entity/review/SearchRecordDate.dart';
import '../../../net/net_manager.dart';
import '../../../utils/sp_util.dart';

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
      Map<String,dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.getPracticeRecordList,data: req,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
    PractiseHistoryDate paperDetail = PractiseHistoryDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
//获取tab
  Future<ErrorNoteTab> getErrorNoteTab(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getErrorNoteTabList,
        options: Options(method: Method.get));
    ErrorNoteTab paperDetail = ErrorNoteTab.fromJson(map);
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

  Future<SearchCollectListDate> getCollectList(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.getSearchCollectListDate,data: req,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
    SearchCollectListDate paperDetail = SearchCollectListDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //收藏列表的详情接口
  Future<SearchCollectListDetail> getCollectListDetail(int userid, String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getSearchCollectListDateDetail + userid.toString() + "/" + id,
        options: Options(method: Method.get));
    SearchCollectListDetail paperDetail = SearchCollectListDetail.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //收藏
  Future<CollectDate> toCollect(String id,{num subtopicId=-1}) async {
    int userid = SpUtil.getInt(BaseConstant.USER_ID);
    String uploadData = "";
    if(subtopicId>0){
      uploadData = "{\"userId\":${userid},\"subjectId\":${id},\"subtopicId\":${subtopicId}}";
    }else{
      uploadData = "{\"userId\":${userid},\"subjectId\":${id}}";
    }
    Map map = await NetManager.getInstance()!.request(
        data:uploadData,
        Method.post,
        Api.toCollect,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    CollectDate paperDetail = CollectDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //收藏
  Future<CollectDate> queryCollect(String id,{num subtopicId=-1}) async {
    int userid = SpUtil.getInt(BaseConstant.USER_ID);
    String uploadData = "";
    if(subtopicId>0){
      uploadData = "{\"userId\":${userid},\"subjectId\":${id},\"subtopicId\":${subtopicId}}";
    }else{
      uploadData = "{\"userId\":${userid},\"subjectId\":${id}}";
    }
    Map map = await NetManager.getInstance()!.request(
        data: uploadData,
        Method.post,
        Api.queryQuestionCollect,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));

    CollectDate paperDetail = CollectDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //金刚区列表和周报筛选
  Future<HomeKingDate> getHomeKingList(String type) async {
    Map map = await NetManager.getInstance()!
        .request(Method.get,options: Options(contentType: ContentType.json.toString()), Api.getHomeKingList + type);
    HomeKingDate sendCodeResponse = HomeKingDate.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }

}
