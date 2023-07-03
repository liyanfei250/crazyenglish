/// code : 0
/// message : "系统正常"
/// obj : false
/// p : null

class BoolObjResponse {
  BoolObjResponse({
      num? code, 
      String? message, 
      bool? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  BoolObjResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'];
    _p = json['p'];
  }
  num? _code;
  String? _message;
  bool? _obj;
  dynamic _p;
BoolObjResponse copyWith({  num? code,
  String? message,
  bool? obj,
  dynamic p,
}) => BoolObjResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  bool? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['obj'] = _obj;
    map['p'] = _p;
    return map;
  }

}