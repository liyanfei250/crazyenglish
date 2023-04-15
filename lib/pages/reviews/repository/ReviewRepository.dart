
import 'package:dio/dio.dart';

import '../../../api/api.dart';
import '../../../entity/base_resp.dart';
import '../../../entity/review/ErrorNoteTabDate.dart';
import '../../../entity/review/PractiseHistoryDate.dart';
import '../../../entity/review/ReviewHomeDetail.dart';
import '../../../net/net_manager.dart';

class ReviewRepository{

  Future<ReviewHomeDetail> getReviewHomeDetail(String id) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getReviewHomeDetail,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.getReturnData() !=null){

      ReviewHomeDetail paperDetail = ReviewHomeDetail.fromJson(baseResp.getReturnData());
      return paperDetail!;
    } else {
      return Future.error("返回ReviewHomeDetailResponse为空");
    }
  }


  Future<PractiseHistoryDate> getPracticeRecordList(String id) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getPracticeRecordList,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.getReturnData() !=null){

      PractiseHistoryDate paperDetail = PractiseHistoryDate.fromJson(baseResp.getReturnData());
      return paperDetail!;
    } else {
      return Future.error("返回PracticeRecordListResponse为空");
    }
  }

  Future<ErrorNoteTabDate> getErrorNoteTabDate(String id) async{
    BaseResp baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getErrorNoteTabDateList,
        options: Options(method: Method.get));
    if (baseResp.code != ResponseCode.status_success) {
      return Future.error(baseResp.message!);
    }
    if(baseResp.getReturnData() !=null){

      ErrorNoteTabDate paperDetail = ErrorNoteTabDate.fromJson(baseResp.getReturnData());
      return paperDetail!;
    } else {
      return Future.error("返回ErrorNoteTabDateResponse为空");
    }
  }

}