import 'package:dio/dio.dart';

/// <BaseResp<T> 返回 status code msg data.
class BaseResp {
  int? code;
  String? msg;
  dynamic _returnData;

  BaseResp(this.code, this.msg);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"code\":$code");
    sb.write(",\"msg\":\"$msg\"");
    sb.write('}');
    return sb.toString();
  }


  dynamic getReturnData(){
   return _returnData;
  }

  void setReturnData(dynamic value) {
    _returnData = value;
  }

  BaseResp.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
  }
}

/// <BaseRespR<T> 返回 status code msg data Response.
class BaseRespR<T> {
  String? status;
  int? code;
  String? msg;
  T data;
  Response response;

  BaseRespR(this.status, this.code, this.msg, this.data, this.response);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"code\":$code");
    sb.write(",\"msg\":\"$msg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}
