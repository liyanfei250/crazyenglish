/// code : 1
/// msg : "系统正常"
/// data : "123456"

class SendCodeResponse{
  int? _code;
  String? _msg;
  String? _data;

  int? get code => _code;
  String? get msg => _msg;
  String? get data => _data;

  SendCodeResponse({
      int? code, 
      String? msg, 
      String? data}){
    _code = code;
    _msg = msg;
    _data = data;
}

  SendCodeResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['data'] = _data;
    return map;
  }

}