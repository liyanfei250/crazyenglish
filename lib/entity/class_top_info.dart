/// code : 0
/// message : "系统正常"
/// obj : {"id":1655395694170124290,"name":"精英班","status":1,"studentSize":2,"accuracy":77.5000000000,"score":85.0000000000,"effort":86.0000000000,"operationSize":0,"studentInfos":null}
/// p : null
/// success : true

class ClassTopInfo {
  ClassTopInfo({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p, 
      bool? success,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
    _success = success;
}

  ClassTopInfo.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
    _success = json['success'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
  bool? _success;
ClassTopInfo copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => ClassTopInfo(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
  success: success ?? _success,
);
  num? get code => _code;
  String? get message => _message;
  Obj? get obj => _obj;
  dynamic get p => _p;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.toJson();
    }
    map['p'] = _p;
    map['success'] = _success;
    return map;
  }

}

/// id : 1655395694170124290
/// name : "精英班"
/// status : 1
/// studentSize : 2
/// accuracy : 77.5000000000
/// score : 85.0000000000
/// effort : 86.0000000000
/// operationSize : 0
/// studentInfos : null

class Obj {
  Obj({
      num? id, 
      String? name, 
      num? status, 
      num? studentSize, 
      num? accuracy, 
      num? score, 
      num? effort, 
      num? operationSize, 
      dynamic studentInfos,}){
    _id = id;
    _name = name;
    _status = status;
    _studentSize = studentSize;
    _accuracy = accuracy;
    _score = score;
    _effort = effort;
    _operationSize = operationSize;
    _studentInfos = studentInfos;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _studentSize = json['studentSize'];
    _accuracy = json['accuracy'];
    _score = json['score'];
    _effort = json['effort'];
    _operationSize = json['operationSize'];
    _studentInfos = json['studentInfos'];
  }
  num? _id;
  String? _name;
  num? _status;
  num? _studentSize;
  num? _accuracy;
  num? _score;
  num? _effort;
  num? _operationSize;
  dynamic _studentInfos;
Obj copyWith({  num? id,
  String? name,
  num? status,
  num? studentSize,
  num? accuracy,
  num? score,
  num? effort,
  num? operationSize,
  dynamic studentInfos,
}) => Obj(  id: id ?? _id,
  name: name ?? _name,
  status: status ?? _status,
  studentSize: studentSize ?? _studentSize,
  accuracy: accuracy ?? _accuracy,
  score: score ?? _score,
  effort: effort ?? _effort,
  operationSize: operationSize ?? _operationSize,
  studentInfos: studentInfos ?? _studentInfos,
);
  num? get id => _id;
  String? get name => _name;
  num? get status => _status;
  num? get studentSize => _studentSize;
  num? get accuracy => _accuracy;
  num? get score => _score;
  num? get effort => _effort;
  num? get operationSize => _operationSize;
  dynamic get studentInfos => _studentInfos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['studentSize'] = _studentSize;
    map['accuracy'] = _accuracy;
    map['score'] = _score;
    map['effort'] = _effort;
    map['operationSize'] = _operationSize;
    map['studentInfos'] = _studentInfos;
    return map;
  }

}