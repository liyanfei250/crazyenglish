import 'package:crazyenglish/entity/base_resp.dart';

/// code : 0
/// message : ""
/// obj : {}

class StartExam extends BaseResp{
  StartExam({
      num? code,
      String? message,
      dynamic obj,}):super(code,message){
    _obj = obj;
}

  StartExam.fromJson(dynamic json):super.fromJson(json) {
    _obj = json['obj'];
  }
  dynamic _obj;
StartExam copyWith({  num? code,
  String? message,
  dynamic obj,
}) => StartExam(  code: code ?? code,
  message: message ?? message,
  obj: obj ?? _obj,
);
  dynamic get obj => _obj;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['obj'] = _obj;
    return map;
  }

}