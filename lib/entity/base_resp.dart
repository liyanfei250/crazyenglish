import 'package:dio/dio.dart';

/// <BaseResp<T> 返回 status code msg data.
class BaseResp<T> {
  int? code;
  String? message;
  T obj;

  BaseResp(this.code, this.message, this.obj);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"code\":$code");
    sb.write(",\"msg\":\"$message\"");
    sb.write(",\"data\":\"$obj\"");
    sb.write('}');
    return sb.toString();
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
