/// code : "319"
/// message : "success"
/// obj : [{"id":"992","operationClassId":"221","classId":"829","teacherId":"142","studentUserId":"16","operationStatus":"816","objectiveSize":"10","objectiveProperSize":"10","objectiveCompleteSize":"10","subjectiveSize":"10","subjectiveTotalScore":"490","subjectiveCompleteSize":"10","totalSize":"10","completeSize":"10","completeTime":"2023-05-08 13:22:59","name":"ivelisse.rippin"}]
/// p : {}

class StudentWorkListResponse {
  StudentWorkListResponse({
      String? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  StudentWorkListResponse.fromJson(dynamic json) {
    _code = json['code'].toString();
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
  }
  String? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
StudentWorkListResponse copyWith({  String? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => StudentWorkListResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  String? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    map['p'] = _p;
    return map;
  }

}

/// id : "992"
/// operationClassId : "221"
/// classId : "829"
/// teacherId : "142"
/// studentUserId : "16"
/// operationStatus : "816"
/// objectiveSize : "10"
/// objectiveProperSize : "10"
/// objectiveCompleteSize : "10"
/// subjectiveSize : "10"
/// subjectiveTotalScore : "490"
/// subjectiveCompleteSize : "10"
/// totalSize : "10"
/// completeSize : "10"
/// completeTime : "2023-05-08 13:22:59"
/// name : "ivelisse.rippin"

class Obj {
  Obj({
      String? id, 
      String? operationClassId, 
      String? classId, 
      String? teacherId, 
      String? studentUserId, 
      String? operationStatus, 
      String? objectiveSize, 
      String? objectiveProperSize, 
      String? objectiveCompleteSize, 
      String? subjectiveSize, 
      String? subjectiveTotalScore, 
      String? subjectiveCompleteSize, 
      String? totalSize, 
      String? completeSize, 
      String? completeTime, 
      String? name,}){
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
  }
  String? _id;
  String? _operationClassId;
  String? _classId;
  String? _teacherId;
  String? _studentUserId;
  String? _operationStatus;
  String? _objectiveSize;
  String? _objectiveProperSize;
  String? _objectiveCompleteSize;
  String? _subjectiveSize;
  String? _subjectiveTotalScore;
  String? _subjectiveCompleteSize;
  String? _totalSize;
  String? _completeSize;
  String? _completeTime;
  String? _name;
Obj copyWith({  String? id,
  String? operationClassId,
  String? classId,
  String? teacherId,
  String? studentUserId,
  String? operationStatus,
  String? objectiveSize,
  String? objectiveProperSize,
  String? objectiveCompleteSize,
  String? subjectiveSize,
  String? subjectiveTotalScore,
  String? subjectiveCompleteSize,
  String? totalSize,
  String? completeSize,
  String? completeTime,
  String? name,
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
);
  String? get id => _id;
  String? get operationClassId => _operationClassId;
  String? get classId => _classId;
  String? get teacherId => _teacherId;
  String? get studentUserId => _studentUserId;
  String? get operationStatus => _operationStatus;
  String? get objectiveSize => _objectiveSize;
  String? get objectiveProperSize => _objectiveProperSize;
  String? get objectiveCompleteSize => _objectiveCompleteSize;
  String? get subjectiveSize => _subjectiveSize;
  String? get subjectiveTotalScore => _subjectiveTotalScore;
  String? get subjectiveCompleteSize => _subjectiveCompleteSize;
  String? get totalSize => _totalSize;
  String? get completeSize => _completeSize;
  String? get completeTime => _completeTime;
  String? get name => _name;

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
    return map;
  }

}