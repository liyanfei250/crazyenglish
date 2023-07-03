/// code : 0
/// message : "系统正常"
/// obj : {"code":"922429"}
/// p : null

class SendCodeResponseNew {
  SendCodeResponseNew({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  SendCodeResponseNew.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
SendCodeResponseNew copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => SendCodeResponseNew(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  Obj? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.toJson();
    }
    map['p'] = _p;
    return map;
  }

}

/// code : "922429"

class Obj {
  Obj({
      String? code,}){
    _code = code;
}

  Obj.fromJson(dynamic json) {
    _code = json['code'];
  }
  String? _code;
Obj copyWith({  String? code,
}) => Obj(  code: code ?? _code,
);
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    return map;
  }

}