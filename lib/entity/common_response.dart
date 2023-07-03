/// code : 0
/// message : "系统正常"
/// obj : true
/// p : null
/// success : true

class CommonResponse {
  CommonResponse({
      num? code, 
      String? message, 
      bool? obj, 
      dynamic p, 
      bool? success,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
    _success = success;
}

  CommonResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'];
    _p = json['p'];
    _success = json['success'];
  }
  num? _code;
  String? _message;
  bool? _obj;
  dynamic _p;
  bool? _success;
CommonResponse copyWith({  num? code,
  String? message,
  bool? obj,
  dynamic p,
  bool? success,
}) => CommonResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
  success: success ?? _success,
);
  num? get code => _code;
  String? get message => _message;
  bool? get obj => _obj;
  dynamic get p => _p;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['obj'] = _obj;
    map['p'] = _p;
    map['success'] = _success;
    return map;
  }

}