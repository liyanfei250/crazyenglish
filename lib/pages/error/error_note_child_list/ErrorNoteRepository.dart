import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../entity/base_resp.dart';
import '../../../entity/practice_list_response.dart';
import '../../../entity/week_detail_response.dart' as errorDetail;
import '../../../net/net_manager.dart';
import 'package:crazyenglish/entity/error_note_response.dart' as errorTest;

class ErrorNoteRepository {
  Future<errorTest.Data> getErrorTestList(Map<String, String> req) async {
    BaseResp baseResp = await NetManager.getInstance()!.request(
        Method.get, Api.getErrotList,
        data: req, options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if (baseResp.getReturnData() != null) {
      errorTest.ErrorNoteResponse errorTestListResponse =
          errorTest.ErrorNoteResponse.fromJson(baseResp.getReturnData());
      return errorTestListResponse.data!;
    } else {
      return Future.error("返回errorTestListResponse为空");
    }
  }

  Future<errorDetail.WeekDetailResponse> getErrorNoteDetail(String id) async {
    BaseResp baseResp = await NetManager.getInstance()!.request(
        data: {"directory_uuid": id},
        Method.get,
        Api.getErrotListDetail,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if (baseResp.getReturnData() != null) {
      errorDetail.WeekDetailResponse weekTestDetailResponse =
          errorDetail.WeekDetailResponse.fromJson(baseResp.getReturnData());
      return weekTestDetailResponse!;
    } else {
      return Future.error("返回weekTestDetailResponse为空");
    }
  }

  Future<PracticeListResponse> getPracticerecords(
      int page, int pageSize) async {
    BaseResp baseResp = await NetManager.getInstance()!.request(
        data: {"page": page, "pageSize": pageSize},
        Method.get,
        Api.getPracticerecords,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if (baseResp.getReturnData() != null) {
      PracticeListResponse practiceListResponse =
      PracticeListResponse.fromJson(baseResp.getReturnData());
      return practiceListResponse!;
    } else {
      return Future.error("返回weekTestDetailResponse为空");
    }
  }

  Future<errorDetail.WeekDetailResponse> getPracticerecordsDetail(
      uuid) async {
    BaseResp baseResp = await NetManager.getInstance()!.request(
        data: {"uuid": uuid},
        Method.get,
        Api.getPracticerecordsDetail,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.msg!);
    }
    if (baseResp.getReturnData() != null) {
      errorDetail.WeekDetailResponse practiceListResponse =
      errorDetail.WeekDetailResponse.fromJson(baseResp.getReturnData());
      return practiceListResponse!;
    } else {
      return Future.error("返回weekTestDetailResponse为空");
    }
  }
}
