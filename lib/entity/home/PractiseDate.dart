/// code : 0
/// message : "系统正常"
/// obj : ["2023-04-18T16:00:00.000+0000","2023-04-19T16:00:00.000+0000"]
/// p : null

class PractiseDate {
  PractiseDate({
      num? code, 
      String? message, 
      List<String>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  PractiseDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? json['obj'].cast<String>() : [];
    _p = json['p'];
  }
  num? _code;
  String? _message;
  List<String>? _obj;
  dynamic _p;
PractiseDate copyWith({  num? code,
  String? message,
  List<String>? obj,
  dynamic p,
}) => PractiseDate(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  List<String>? get obj => _obj;
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