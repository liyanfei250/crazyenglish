import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../entity/base_resp.dart';
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
}
