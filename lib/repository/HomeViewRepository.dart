import 'dart:convert';
import 'dart:io';

import 'package:crazyenglish/entity/home/banner.dart';
import 'package:crazyenglish/entity/teacher_home_tips_response.dart';
import 'package:crazyenglish/entity/week_list_response.dart';
import 'package:dio/dio.dart';

import '../api/api.dart';
import '../base/AppUtil.dart';
import '../base/common.dart';
import '../entity/SendCodeResponseNew.dart';
import '../entity/base_resp.dart';
import '../entity/home/ClassInfoDate.dart';
import '../entity/home/CommentDate.dart';
import '../entity/home/HomeKingDate.dart';
import '../entity/home/HomeKingNewDate.dart';
import '../entity/home/HomeMyTasksDate.dart';
import '../entity/home/HomeSearchListDate.dart';
import '../entity/review/HomeListDate.dart';
import '../entity/teacher_week_list_response.dart';
import '../net/net_manager.dart';
import '../utils/sp_util.dart';

class HomeViewRepository {
  //获取首页我的期刊，学生端
  Future<WeekListResponse> getMyJournalList(String id) async {
    // String testData =
    //     '{"code":0,"message":"系统正常","obj":[],"p":{"records":[],"total":1,"size":50,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}}';
    //
    // if(Util.isTestMode()){
    //   HomeMyJournalListDate weekTestListResponse = HomeMyJournalListDate.fromJson(json.decode(testData));
    //   return weekTestListResponse;
    // }

    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeMyJournalListDate + id,
        options: Options(method: Method.get));
    WeekListResponse paperDetail = WeekListResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //获取首页我的任务
  Future<HomeMyTasksDate> getMyTask(Map<String,dynamic> req) async {
    
    
    Map map = await NetManager.getInstance()!.request(
      data:req,
        Method.post, Api.getHomeMyTasksDate,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
    HomeMyTasksDate paperDetail = HomeMyTasksDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //获取首页顶部搜索
  Future<HomeSearchListDate> getSearchDateList(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.getHomeSearchListDate,
        data: req,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
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

  //提交反馈信息
  Future<CommentDate> toUploadFeeedback(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.postContentDate,
        data: req,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    CommentDate paperDetail = CommentDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }


  //金刚区列表新增
  Future<HomeKingNewDate> getHomeKingListNew(String role) async {

    Map map = await NetManager.getInstance()!
        .request(Method.get, "${Api.getHomeKingListNew}$role");
    HomeKingNewDate sendCodeResponse = HomeKingNewDate.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回HomeKingNewDateResponse为空");
    }
  }

  //banner列表
  Future<Banner> getHomeBanner(int role) async {

    Map map = await NetManager.getInstance()!
        .request(Method.get, "${Api.getHomeBanner}$role");
    Banner sendCodeResponse = Banner.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回HomeKingNewDateResponse为空");
    }
  }

//教师
  //获取首页我的已购期刊
  Future<TeacherWeekListResponse> getMyJournalListTeacher(
      Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.purchaseJournals,
        data: req,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    TeacherWeekListResponse paperDetail = TeacherWeekListResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //获取首页推荐期刊
  Future<TeacherWeekListResponse> getMyRecommendationTeacher(
      Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.recommendJournals,
        data: req,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    TeacherWeekListResponse paperDetail = TeacherWeekListResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //获取首页提醒数量
  Future<TeacherHomeTipsResponse> getHomeTipsNum() async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.indexTeacerOperationStatus,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    TeacherHomeTipsResponse paperDetail = TeacherHomeTipsResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}
