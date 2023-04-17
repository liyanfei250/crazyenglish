import 'package:dio/dio.dart';

/// <BaseResp<T> 返回 status code msg data.
class BaseResp{
  num? code;
  String? message;

  BaseResp(this.code, this.message);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"code\":$code");
    sb.write(",\"msg\":\"$message\"");
    sb.write('}');
    return sb.toString();
  }

  BaseResp.fromJson(dynamic json) {
    code = json['code'];
    message = json['message']??"";
  }
}

/// <BaseRespR<T> 返回 status code msg data Response.
class BaseRespR<T> {
  String? status;
  num? code;
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
