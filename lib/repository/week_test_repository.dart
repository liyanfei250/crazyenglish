import 'dart:convert';
import 'dart:io';

import 'package:crazyenglish/entity/boo_obj_response.dart';
import 'package:crazyenglish/entity/common_response.dart';
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

  Future<StartExam> getStartHomework(String jouralCatalogueId,String operationStudentId) async {
    Map map = await NetManager.getInstance()!.request(
        data: "{\"operationStudentId\":$operationStudentId,\"journalCatalogueId\":$jouralCatalogueId}",
        Method.post,
        Api.getStartHomework,
        options: Options(
            method: Method.post, contentType: ContentType.json.toString()));

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

  Future<BoolObjResponse> getVerifyDeadline(String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getVerifyDeadline+"/${id}",
        options: Options(method: Method.get));

    BoolObjResponse startExam = BoolObjResponse.fromJson(map);

    if (startExam.code != ResponseCode.status_success) {
      return Future.error(startExam.message!);
    }
    if (startExam.code == 0) {
      return startExam;
    } else {
      return Future.error("校验截止日期错误");
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
    Map map = await NetManager.getInstance()!
        .request(Method.get, Api.getAppVersion+(Platform.isAndroid? "1":"2"),
        options: Options(method: Method.get));
    CheckUpdateResp checkUpdateResp = CheckUpdateResp.fromJson(map);
    return checkUpdateResp;
    // if (checkUpdateResp.code != ResponseCode.status_success) {
    //   return Future.error(baseResp.message!);
    // }
    // if(baseResp.getReturnData() !=null){
    //   CheckUpdateResponse checkUpdateResp = CheckUpdateResponse.fromJson(baseResp.getReturnData());
    //   return checkUpdateResp!.data!;
    // } else {
    // return Future.error("返回CheckUpdateResp为空");
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

  Future<CommonResponse> toUpdateShowNum(String type) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get,
        options: Options(contentType: ContentType.json.toString()),
        Api.updateJournalView + type);
    CommonResponse paperDetail = CommonResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}
