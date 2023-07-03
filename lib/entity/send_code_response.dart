import 'base_resp.dart';

/// code : 1
/// msg : "系统正常"
/// data : "123456"

class SendCodeResponse extends BaseResp{
  String? _data;

  String? get data => _data;

  SendCodeResponse({
      int? code, 
      String? msg, 
      String? data}):super(code,msg){
    _data = data;
}

  SendCodeResponse.fromJson(dynamic json):super.fromJson(json) {
    _data = json['obj'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['obj'] = _data;
    return map;
  }

}