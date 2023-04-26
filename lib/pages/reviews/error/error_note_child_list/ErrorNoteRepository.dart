import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../api/api.dart';
import '../../../../base/AppUtil.dart';
import '../../../../entity/practice_list_response.dart';
import '../../../../entity/review/ErrorNoteTabDate.dart';
import '../../../../entity/week_detail_response.dart' as errorDetail;
import '../../../../net/net_manager.dart';
import 'package:crazyenglish/entity/error_note_response.dart' as errorTest;

class ErrorNoteRepository {
  Future<errorTest.Data> getErrorTestList(Map<String, String> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getErrotList,
        data: req, options: Options(method: Method.get));
    errorTest.ErrorNoteResponse errorTestListResponse =
    errorTest.ErrorNoteResponse.fromJson(map);
    if (errorTestListResponse.code != ResponseCode.status_success) {
      return Future.error(errorTestListResponse.message!);
    }else{
      return errorTestListResponse.data!;
    }
  }

  //获取错题本数据列表
  Future<ErrorNoteTabDate> getErrorNoteTabDate(Map<String, dynamic> req) async {
    // String testData = '{"code": 0,"message": "系统正常","obj": [{"journalId": 1647898280209838082,"journalName": "ceshi","createTime": "2023-4-20 11:12:14","recordListVos": [{"journalId": 1647898280209838082,"subjectId": 1648489081579143169,"questionTypeName": "完形填空","totalCount": 5,"errorCount": 2}]},{"journalId": 1647898280209838082,"journalName": "ceshi","createTime": "2023-4-20 11:28:00","recordListVos": [{"journalId": 1647898280209838082,"subjectId": 1648489081579143169,"questionTypeName": "完形填空","totalCount": 5,"errorCount": 1}]},{"journalId": 1647898280209838082,"journalName": "ceshi","createTime": "2023-4-20 11:29:41","recordListVos": [{"journalId": 1647898280209838082,"subjectId": 1648489081579143169,"questionTypeName": "完形填空","totalCount": 5,"errorCount": 1},{"journalId": 1647898280209838082,"subjectId": 1648489081579143169,"questionTypeName": "完形填空","totalCount": 5,"errorCount": 1}]}],"p": null}';
    //
    // //todo 后面调试去掉数据
    // if(Util.isTestMode()){
    //   ErrorNoteTabDate weekTestListResponse = ErrorNoteTabDate.fromJson(json.decode(testData));
    //   return weekTestListResponse;
    // }

    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.getErrorNoteTabDateList,data: req,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
    ErrorNoteTabDate paperDetail = ErrorNoteTabDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }

  Future<errorDetail.WeekDetailResponse> getErrorNoteDetail(String id) async {
    Map map = await NetManager.getInstance()!.request(
        data: {"directory_uuid": id},
        Method.get,
        Api.getErrotListDetail,
        options: Options(method: Method.get));
    errorDetail.WeekDetailResponse practiceListResponse =
    errorDetail.WeekDetailResponse.fromJson(map);
    if (practiceListResponse.code != ResponseCode.status_success) {
      return Future.error(practiceListResponse.message!);
    }else{
      return practiceListResponse!;
    }
  }

  Future<PracticeListResponse> getPracticerecords(
      int page, int pageSize) async {
    Map map = await NetManager.getInstance()!.request(
        data: {"page": page, "pageSize": pageSize},
        Method.get,
        Api.getPracticerecords,
        options: Options(method: Method.get));
    PracticeListResponse practiceListResponse = PracticeListResponse.fromJson(map);

    if (practiceListResponse.code != ResponseCode.status_success) {
      return Future.error(practiceListResponse.message!);
    }else{
      return practiceListResponse!;
    }
  }

  Future<errorDetail.WeekDetailResponse> getPracticerecordsDetail(
      uuid) async {
    Map map = await NetManager.getInstance()!.request(
        data: {"uuid": uuid},
        Method.get,
        Api.getPracticerecordsDetail,
        options: Options(method: Method.get));
    errorDetail.WeekDetailResponse practiceListResponse =
    errorDetail.WeekDetailResponse.fromJson(map);
    if (practiceListResponse.code != ResponseCode.status_success) {
      return Future.error(practiceListResponse.message!);
    }else{
      return practiceListResponse!;
    }
  }
}
