import 'dart:io';

import 'package:crazyenglish/entity/base_resp.dart';
import 'package:dio/dio.dart';

import '../../api/api.dart';
import '../../entity/class_bottom_info.dart';
import '../../entity/class_detail_response.dart';
import '../../entity/class_list_response.dart';
import '../../entity/class_top_info.dart';
import '../../entity/common_response.dart';
import '../../entity/student_detail_response.dart';
import '../../entity/student_ranking_response.dart';
import '../../net/net_manager.dart';

class ClassRepository {
  Future<ClassListResponse> getMyClassList(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.TeacherClassList,
        data: req,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    ClassListResponse paperDetail = ClassListResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<ClassDetailResponse> getMyClassDetail(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.TeacherClassDetail + id,
        options: Options(method: Method.get));
    ClassDetailResponse paperDetail = ClassDetailResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<CommonResponse> myClassAdd(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.TeacherClassAdd,
        data: req,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    CommonResponse paperDetail = CommonResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //顶部班级
  Future<ClassTopInfo> getMyClassTop(String classId) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.TeacherClassTop + classId,
        options: Options(method: Method.get));
    ClassTopInfo paperDetail = ClassTopInfo.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  //底部学生
  Future<ClassBottomInfo> getMyClassBottom(Map<String, dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.TeacherClassBottom,
        data: req,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    ClassBottomInfo paperDetail = ClassBottomInfo.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<StudentDetailResponse> getStudentDetail(String classId) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.studentDetail + classId,
        options: Options(method: Method.get));
    StudentDetailResponse paperDetail = StudentDetailResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<StudentRankingResponse> getStudentRanking(String classId) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.studentRanking + classId,
        options: Options(method: Method.get));
    StudentRankingResponse paperDetail = StudentRankingResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}
