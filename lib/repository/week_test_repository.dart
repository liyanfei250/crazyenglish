import 'dart:convert';
import 'dart:io';

import 'package:crazyenglish/entity/week_directory_response.dart';
import 'package:crazyenglish/entity/week_list_response.dart' as weekTest;
import 'package:dio/dio.dart';

import '../api/api.dart';
import '../base/AppUtil.dart';
import '../base/common.dart';
import '../entity/base_resp.dart';
import '../entity/check_update_resp.dart';
import '../entity/commit_request.dart';
import '../entity/home/HomeKingDate.dart';
import '../entity/review/HomeWeeklyChoiceDate.dart';
import '../entity/start_exam.dart';
import '../entity/user_info_response.dart';
import '../entity/week_detail_response.dart' as weekDetail;
import '../entity/week_list_response.dart';
import '../net/net_manager.dart';
import '../utils/sp_util.dart';

/**
 * Time: 2022/12/22 14:56
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class WeekTestRepository {
  Future<WeekListResponse> getWeekTestList(Map<String, dynamic> req) async {
    String testData =
        '{"code":0,"message":"系统正常","obj":[{"id":1648136972349313025,"p":null,"name":"ceshi","affiliatedGrade":2,"schoolYear":2,"periodsNum":21,"coverImg":"","status":false,"isDelete":false,"createTime":"2023-04-18T09:30:50","updateTime":null,"createUser":1,"updateUser":null}],"p":{"records":[],"total":1,"size":50,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}}';

    /*if(Util.isTestMode()){
      WeekListResponse weekTestListResponse = WeekListResponse.fromJson(json.decode(testData));
      return weekTestListResponse;
    }*/

    Map baseResp = await NetManager.getInstance()!.request(
        Method.post, Api.getHomeWeeklyList,
        data: req, options: Options(contentType: ContentType.json.toString()));

    if (baseResp != null) {
      WeekListResponse weekTestListResponse =
          WeekListResponse.fromJson(baseResp);
      if (weekTestListResponse.code != ResponseCode.status_success) {
        return Future.error(weekTestListResponse.message!);
      }
      return weekTestListResponse;
    } else {
      return Future.error("返回weekTestListResponse为空");
    }
  }

  Future<WeekDirectoryResponse> getWeekTestCategory(String periodicaId) async {
    String testData =
        "{\"code\":1,\"data\":[{\"uuid\":\"6b028a80-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一部分听力（共两节， 满分 30 分 ）\",\"sort\":267,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b028a81-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节 （共5小题；每小题1.5分，满分7.5分）\",\"sort\":268,\"parentId\":\"6b028a80-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b190-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 （共15小题；每小题1.5分，满分22.5分）\",\"sort\":269,\"parentId\":\"6b028a80-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]},{\"uuid\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二部分阅读理解（共两节，满分40分）\",\"sort\":270,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b02b192-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节A篇 （共3小题；每小题2分，满分6分）\",\"sort\":271,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b193-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节B篇 （共4小题；每小题2分，满分8分）\",\"sort\":272,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b194-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节C篇 （共4小题；每小题2分，满分8分）\",\"sort\":273,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b195-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节D篇 （共4小题；每小题2分，满分8分）\",\"sort\":274,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b196-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 （共5小题；每小题2分，满分10分）\",\"sort\":275,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]},{\"uuid\":\"6b02b197-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第三部分语言知识运用（共两节，满分45 分）\",\"sort\":276,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b02b198-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节 （共20小题；每小题1.5分，满分30分）\",\"sort\":277,\"parentId\":\"6b02b197-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b199-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 （共10小题；每小题1.5分，满分15分）\",\"sort\":278,\"parentId\":\"6b02b197-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]},{\"uuid\":\"6b02b19a-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第四部分写作（共两节，满分35分）\",\"sort\":279,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b02b19b-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节 短文改错 （共10小题；每小题1分，满分10分）\",\"sort\":280,\"parentId\":\"6b02b19a-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02d8a0-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 书面表达 （满分25分）\",\"sort\":281,\"parentId\":\"6b02b19a-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]}],\"msg\":\"\"}";

    // if(Util.isTestMode()){
    //   WeekDirectoryResponse weekTestCatalogResponse = WeekDirectoryResponse.fromJson(json.decode(testData));
    //   return weekTestCatalogResponse!;
    // }

    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeWeeklyDirectoryList + periodicaId,
        options: Options(contentType: ContentType.json.toString()));

    if (map != null) {
      WeekDirectoryResponse weekTestCatalogResponse =
          WeekDirectoryResponse.fromJson(map);
      if (weekTestCatalogResponse.code != ResponseCode.status_success) {
        return Future.error("返回WeekDirectoryResponse为空");
      } else {
        return weekTestCatalogResponse!;
      }
    } else {
      return Future.error("返回WeekDirectoryResponse为空");
    }
  }

  Future<weekDetail.WeekDetailResponse> getWeekTestDetailFromCatalogId(String id) async {

    Map map = await NetManager.getInstance()!.request(
        Method.get,
        Api.getWeekDetail+id,
        options: Options(method: Method.get));

    if (map != null) {
      weekDetail.WeekDetailResponse weekTestCatalogResponse =
          weekDetail.WeekDetailResponse.fromJson(map);
      if (weekTestCatalogResponse.code != ResponseCode.status_success) {
        return Future.error("返回WeekDirectoryResponse为空");
      } else {
        return weekTestCatalogResponse!;
      }
    } else {
      return Future.error("返回WeekDirectoryResponse为空");
    }
  }

  Future<weekDetail.WeekDetailResponse> getWeekTestDetailFromSubjectId(String id) async {

    Map map = await NetManager.getInstance()!.request(
        Method.get,
        Api.getSearchCollectListDateDetail+"/${SpUtil.getInt(BaseConstant.USER_ID)}/${id}",
        options: Options(method: Method.get));

    if (map != null) {
      weekDetail.WeekDetailResponse weekTestCatalogResponse =
      weekDetail.WeekDetailResponse.fromJson(map);
      if (weekTestCatalogResponse.code != ResponseCode.status_success) {
        return Future.error("返回WeekDirectoryResponse为空");
      } else {
        return weekTestCatalogResponse!;
      }
    } else {
      return Future.error("返回WeekDirectoryResponse为空");
    }
  }


  Future<StartExam> getStartExam(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getStartExam+"${SpUtil.getInt(BaseConstant.USER_ID)}/${id}",
        options: Options(method: Method.get));

    StartExam startExam = StartExam.fromJson(map);

    if (startExam.code != ResponseCode.status_success) {
      return Future.error(startExam.message!);
    }
    if (startExam.code == 0) {
      return startExam;
    } else {
      return Future.error("返回开始作答信息为空");
    }
  }

  Future<StartExam> getExerciseDetail(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getExerciseDetail+"/${id}",
        options: Options(method: Method.get));

    StartExam startExam = StartExam.fromJson(map);

    if (startExam.code != ResponseCode.status_success) {
      return Future.error(startExam.message!);
    }
    if (startExam.code == 0) {
      return startExam;
    } else {
      return Future.error("返回作答信息为空");
    }
  }

  Future<JouralResultResponse> getResultOverviewExercise(String id,String classifyType) async {
    int userId = SpUtil.getInt(BaseConstant.USER_ID);
    Map map = await NetManager.getInstance()!.request(
        data: "{\"userId\":$userId,\"journalId\":$id,\"classifyType\":$classifyType}",
        Method.post,
        Api.getJournalExerciseResult,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));

    JouralResultResponse jouralResultResponse = JouralResultResponse.fromJson(map);

    if (jouralResultResponse.code != ResponseCode.status_success) {
      return Future.error(jouralResultResponse.msg??"");
    }
    if (jouralResultResponse.code == 0) {
      return jouralResultResponse;
    } else {
      return Future.error("返回作答信息为空");
    }
  }

  Future<CommitResponse> uploadWeekTest(CommitAnswer commitRequest) async {
    Map map = await NetManager.getInstance()!.request(
        data: commitRequest.toJson(),
        Method.post,
        Api.postWeekCommit,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));
    CommitResponse commitResponse = CommitResponse.fromJson(map);
    if (commitResponse.code != ResponseCode.status_success) {
      return Future.error(commitResponse.message!);
    } else {
      return commitResponse;
    }
  }

  Future<StartExam> getExamResult(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getExamResult+"/${SpUtil.getInt(BaseConstant.USER_ID)}/${id}",
        options: Options(method: Method.get));

    StartExam startExam = StartExam.fromJson(map);

    if (startExam.code != ResponseCode.status_success) {
      return Future.error(startExam.message!);
    }
    if (startExam.code == 0) {
      return startExam;
    } else {
      return Future.error("返回开始作答信息为空");
    }
  }

  Future<CheckUpdateResp> getAppVersion() async {
    // BaseResp baseResp = await NetManager.getInstance()!
    //     .request(Method.get, Api.getAppVersion+(Platform.isAndroid? "1":"2"),
    //     options: Options(method: Method.get));
    // if (baseResp.code != ResponseCode.status_success) {
    //   return Future.error(baseResp.message!);
    // }
    // if(baseResp.getReturnData() !=null){
    //   CheckUpdateResponse checkUpdateResp = CheckUpdateResponse.fromJson(baseResp.getReturnData());
    //   return checkUpdateResp!.data!;
    // } else {
    return Future.error("返回CheckUpdateResp为空");
    // }
  }

  Future<HomeKingDate> getHomeWeeklyChoiceDate(String type) async {
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
}
