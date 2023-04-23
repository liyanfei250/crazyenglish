/// code : 0
/// message : "系统正常"
/// obj : null
/// p : null

class CollectDate {
  CollectDate({
      num? code, 
      String? message, 
      dynamic obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  CollectDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'];
    _p = json['p'];
  }
  num? _code;
  String? _message;
  dynamic _obj;
  dynamic _p;
CollectDate copyWith({  num? code,
  String? message,
  dynamic obj,
  dynamic p,
}) => CollectDate(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  dynamic get obj => _obj;
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