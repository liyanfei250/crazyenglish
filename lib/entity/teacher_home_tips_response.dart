/// code : 472
/// message : "success"
/// obj : {"remindCount":165,"correctionCount":883}
/// p : {}

class TeacherHomeTipsResponse {
  TeacherHomeTipsResponse({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  TeacherHomeTipsResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
TeacherHomeTipsResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => TeacherHomeTipsResponse(  code: code ?? _code,
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

/// remindCount : 165
/// correctionCount : 883

class Obj {
  Obj({
      num? remindCount, 
      num? correctionCount,}){
    _remindCount = remindCount;
    _correctionCount = correctionCount;
}

  Obj.fromJson(dynamic json) {
    _remindCount = json['remindCount'];
    _correctionCount = json['correctionCount'];
  }
  num? _remindCount;
  num? _correctionCount;
Obj copyWith({  num? remindCount,
  num? correctionCount,
}) => Obj(  remindCount: remindCount ?? _remindCount,
  correctionCount: correctionCount ?? _correctionCount,
);
  num? get remindCount => _remindCount;
  num? get correctionCount => _correctionCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remindCount'] = _remindCount;
    map['correctionCount'] = _correctionCount;
    return map;
  }

}