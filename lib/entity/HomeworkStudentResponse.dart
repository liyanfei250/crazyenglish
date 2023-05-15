/// code : 0
/// message : "系统正常"
/// obj : [{"id":1656205268053438465,"operationClassId":1656205267856306178,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"张三","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png"},{"id":1656205268053438466,"operationClassId":1656205267856306178,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"李四","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png"}]
/// p : null
/// success : true

class HomeworkStudentResponse {
  HomeworkStudentResponse({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p, 
      bool? success,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
    _success = success;
}

  HomeworkStudentResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
    _success = json['success'];
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
  bool? _success;
HomeworkStudentResponse copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
  bool? success,
}) => HomeworkStudentResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
  success: success ?? _success,
);
  num? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
  dynamic get p => _p;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    map['p'] = _p;
    map['success'] = _success;
    return map;
  }

}

/// id : 1656205268053438465
/// operationClassId : 1656205267856306178
/// classId : 1655395694170124290
/// teacherId : 1651539603655626753
/// studentUserId : 1651531759961624578
/// operationStatus : 1
/// objectiveSize : 0
/// objectiveProperSize : 0
/// objectiveCompleteSize : 0
/// subjectiveSize : 1
/// subjectiveTotalScore : 0
/// subjectiveCompleteSize : 0
/// totalSize : 1
/// completeSize : 0
/// completeTime : null
/// name : "张三"
/// avatar : "https://questions-test.jfwedu.com.cn/img%2Fuser.png"

class Obj {
  Obj({
      num? id, 
      num? operationClassId, 
      num? classId, 
      num? teacherId, 
      num? studentUserId, 
      num? operationStatus, 
      num? objectiveSize, 
      num? objectiveProperSize, 
      num? objectiveCompleteSize, 
      num? subjectiveSize, 
      num? subjectiveTotalScore, 
      num? subjectiveCompleteSize, 
      num? totalSize, 
      num? completeSize, 
      dynamic completeTime, 
      String? name, 
      String? avatar,}){
    _id = id;
    _operationClassId = operationClassId;
    _classId = classId;
    _teacherId = teacherId;
    _studentUserId = studentUserId;
    _operationStatus = operationStatus;
    _objectiveSize = objectiveSize;
    _objectiveProperSize = objectiveProperSize;
    _objectiveCompleteSize = objectiveCompleteSize;
    _subjectiveSize = subjectiveSize;
    _subjectiveTotalScore = subjectiveTotalScore;
    _subjectiveCompleteSize = subjectiveCompleteSize;
    _totalSize = totalSize;
    _completeSize = completeSize;
    _completeTime = completeTime;
    _name = name;
    _avatar = avatar;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _operationClassId = json['operationClassId'];
    _classId = json['classId'];
    _teacherId = json['teacherId'];
    _studentUserId = json['studentUserId'];
    _operationStatus = json['operationStatus'];
    _objectiveSize = json['objectiveSize'];
    _objectiveProperSize = json['objectiveProperSize'];
    _objectiveCompleteSize = json['objectiveCompleteSize'];
    _subjectiveSize = json['subjectiveSize'];
    _subjectiveTotalScore = json['subjectiveTotalScore'];
    _subjectiveCompleteSize = json['subjectiveCompleteSize'];
    _totalSize = json['totalSize'];
    _completeSize = json['completeSize'];
    _completeTime = json['completeTime'];
    _name = json['name'];
    _avatar = json['avatar'];
  }
  num? _id;
  num? _operationClassId;
  num? _classId;
  num? _teacherId;
  num? _studentUserId;
  num? _operationStatus;
  num? _objectiveSize;
  num? _objectiveProperSize;
  num? _objectiveCompleteSize;
  num? _subjectiveSize;
  num? _subjectiveTotalScore;
  num? _subjectiveCompleteSize;
  num? _totalSize;
  num? _completeSize;
  dynamic _completeTime;
  String? _name;
  String? _avatar;
Obj copyWith({  num? id,
  num? operationClassId,
  num? classId,
  num? teacherId,
  num? studentUserId,
  num? operationStatus,
  num? objectiveSize,
  num? objectiveProperSize,
  num? objectiveCompleteSize,
  num? subjectiveSize,
  num? subjectiveTotalScore,
  num? subjectiveCompleteSize,
  num? totalSize,
  num? completeSize,
  dynamic completeTime,
  String? name,
  String? avatar,
}) => Obj(  id: id ?? _id,
  operationClassId: operationClassId ?? _operationClassId,
  classId: classId ?? _classId,
  teacherId: teacherId ?? _teacherId,
  studentUserId: studentUserId ?? _studentUserId,
  operationStatus: operationStatus ?? _operationStatus,
  objectiveSize: objectiveSize ?? _objectiveSize,
  objectiveProperSize: objectiveProperSize ?? _objectiveProperSize,
  objectiveCompleteSize: objectiveCompleteSize ?? _objectiveCompleteSize,
  subjectiveSize: subjectiveSize ?? _subjectiveSize,
  subjectiveTotalScore: subjectiveTotalScore ?? _subjectiveTotalScore,
  subjectiveCompleteSize: subjectiveCompleteSize ?? _subjectiveCompleteSize,
  totalSize: totalSize ?? _totalSize,
  completeSize: completeSize ?? _completeSize,
  completeTime: completeTime ?? _completeTime,
  name: name ?? _name,
  avatar: avatar ?? _avatar,
);
  num? get id => _id;
  num? get operationClassId => _operationClassId;
  num? get classId => _classId;
  num? get teacherId => _teacherId;
  num? get studentUserId => _studentUserId;
  num? get operationStatus => _operationStatus;
  num? get objectiveSize => _objectiveSize;
  num? get objectiveProperSize => _objectiveProperSize;
  num? get objectiveCompleteSize => _objectiveCompleteSize;
  num? get subjectiveSize => _subjectiveSize;
  num? get subjectiveTotalScore => _subjectiveTotalScore;
  num? get subjectiveCompleteSize => _subjectiveCompleteSize;
  num? get totalSize => _totalSize;
  num? get completeSize => _completeSize;
  dynamic get completeTime => _completeTime;
  String? get name => _name;
  String? get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['operationClassId'] = _operationClassId;
    map['classId'] = _classId;
    map['teacherId'] = _teacherId;
    map['studentUserId'] = _studentUserId;
    map['operationStatus'] = _operationStatus;
    map['objectiveSize'] = _objectiveSize;
    map['objectiveProperSize'] = _objectiveProperSize;
    map['objectiveCompleteSize'] = _objectiveCompleteSize;
    map['subjectiveSize'] = _subjectiveSize;
    map['subjectiveTotalScore'] = _subjectiveTotalScore;
    map['subjectiveCompleteSize'] = _subjectiveCompleteSize;
    map['totalSize'] = _totalSize;
    map['completeSize'] = _completeSize;
    map['completeTime'] = _completeTime;
    map['name'] = _name;
    map['avatar'] = _avatar;
    return map;
  }

}