import 'dart:convert';
import 'dart:io';

import 'package:crazyenglish/entity/home/PersonInfo.dart';
import 'package:dio/dio.dart';

import '../../api/api.dart';
import '../../base/AppUtil.dart';
import '../../entity/SendCodeResponseNew.dart';
import '../../entity/base_resp.dart';
import '../../entity/home/ClassInfoDate.dart';
import '../../entity/home/CommentDate.dart';
import '../../entity/home/HomeKingDate.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyJournalListDate.dart';
import '../../entity/home/HomeMyTasksDate.dart';
import '../../entity/home/HomeSearchListDate.dart';
import '../../entity/review/HomeListDate.dart';
import '../../net/net_manager.dart';

class HomeViewRepository {
  //获取首页我的期刊，学生端
  Future<HomeMyJournalListDate> getMyJournalList(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeMyJournalListDate + id,
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

  //提交反馈信息
  Future<CommentDate> toPushContent(Map<String, dynamic> req) async {
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

  //提交头像
  Future<CommentDate> toPushHeaderImage(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.toPushHeaderImage,
        data: req, options: Options(method: Method.post));
    CommentDate paperDetail = CommentDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //获取个人信息
  Future<PersonInfo> getPersonInfo(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getPersonInfo,
        options: Options(method: Method.get));
    PersonInfo paperDetail = PersonInfo.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //修改昵称
  Future<CommentDate> toChangeNickName(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.toChangeNickName,
        data: req, options: Options(method: Method.post));
    CommentDate paperDetail = CommentDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //修改密码
  Future<CommentDate> toChangePassword(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.toChangePassword,
        data: req, options: Options(method: Method.post));
    CommentDate paperDetail = CommentDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //修改手机号
  Future<CommentDate> toChangePhoneNum(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.toChangePhoneNum,
        data: req, options: Options(method: Method.post));
    CommentDate paperDetail = CommentDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //发验证
  Future<SendCodeResponseNew> sendCodeNew(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!
        .request(Method.post, Api.getSendAuthCodeNew, data: req);
    SendCodeResponseNew sendCodeResponse = SendCodeResponseNew.fromJson(map);
    if (sendCodeResponse.code != ResponseCode.status_success) {
      return Future.error(sendCodeResponse.message!);
    }

    if (sendCodeResponse != null) {
      return sendCodeResponse!;
    } else {
      return Future.error("返回SendCodeResponse为空");
    }
  }

  //金刚区列表新增
  Future<HomeKingNewDate> getHomeKingListNew(String type) async {
    Map map = await NetManager.getInstance()!
        .request(Method.get, Api.getHomeKingListNew);
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
}
