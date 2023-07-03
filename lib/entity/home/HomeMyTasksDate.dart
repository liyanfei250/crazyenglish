/// code : 0
/// message : "系统正常"
/// obj : [{"id":1657627484367695874,"operationClassId":1657627484346724354,"classId":1655395694170124290,"operationId":1657627484292198402,"name":"最新试题","teacherId":1651539603655626753,"studentUserId":1651531759961624578,"deadline":"2023-05-18 08:47:29","timeRemaining":"1日23小时57分钟51秒","operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-14 14:02:44","updateUser":1651539603655626753,"updateTime":"2023-05-14 14:02:44"}]
/// p : null
/// success : true

class HomeMyTasksDate {
  HomeMyTasksDate({
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

  HomeMyTasksDate.fromJson(dynamic json) {
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
HomeMyTasksDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
  bool? success,
}) => HomeMyTasksDate(  code: code ?? _code,
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

/// id : 1657627484367695874
/// operationClassId : 1657627484346724354
/// classId : 1655395694170124290
/// operationId : 1657627484292198402
/// name : "最新试题"
/// teacherId : 1651539603655626753
/// studentUserId : 1651531759961624578
/// deadline : "2023-05-18 08:47:29"
/// timeRemaining : "1日23小时57分钟51秒"
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
/// isDelete : false
/// createUser : 1651539603655626753
/// createTime : "2023-05-14 14:02:44"
/// updateUser : 1651539603655626753
/// updateTime : "2023-05-14 14:02:44"

class Obj {
  Obj({
      num? id, 
      num? operationClassId, 
      num? classId, 
      num? operationId, 
      String? name, 
      num? teacherId, 
      num? studentUserId, 
      String? deadline, 
      String? timeRemaining, 
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
      bool? isDelete, 
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime,}){
    _id = id;
    _operationClassId = operationClassId;
    _classId = classId;
    _operationId = operationId;
    _name = name;
    _teacherId = teacherId;
    _studentUserId = studentUserId;
    _deadline = deadline;
    _timeRemaining = timeRemaining;
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
    _isDelete = isDelete;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _operationClassId = json['operationClassId'];
    _classId = json['classId'];
    _operationId = json['operationId'];
    _name = json['name'];
    _teacherId = json['teacherId'];
    _studentUserId = json['studentUserId'];
    _deadline = json['deadline'];
    _timeRemaining = json['timeRemaining'];
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
    _isDelete = json['isDelete'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
  }
  num? _id;
  num? _operationClassId;
  num? _classId;
  num? _operationId;
  String? _name;
  num? _teacherId;
  num? _studentUserId;
  String? _deadline;
  String? _timeRemaining;
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
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
Obj copyWith({  num? id,
  num? operationClassId,
  num? classId,
  num? operationId,
  String? name,
  num? teacherId,
  num? studentUserId,
  String? deadline,
  String? timeRemaining,
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
  bool? isDelete,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
}) => Obj(  id: id ?? _id,
  operationClassId: operationClassId ?? _operationClassId,
  classId: classId ?? _classId,
  operationId: operationId ?? _operationId,
  name: name ?? _name,
  teacherId: teacherId ?? _teacherId,
  studentUserId: studentUserId ?? _studentUserId,
  deadline: deadline ?? _deadline,
  timeRemaining: timeRemaining ?? _timeRemaining,
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
  isDelete: isDelete ?? _isDelete,
  createUser: createUser ?? _createUser,
  createTime: createTime ?? _createTime,
  updateUser: updateUser ?? _updateUser,
  updateTime: updateTime ?? _updateTime,
);
  num? get id => _id;
  num? get operationClassId => _operationClassId;
  num? get classId => _classId;
  num? get operationId => _operationId;
  String? get name => _name;
  num? get teacherId => _teacherId;
  num? get studentUserId => _studentUserId;
  String? get deadline => _deadline;
  String? get timeRemaining => _timeRemaining;
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
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['operationClassId'] = _operationClassId;
    map['classId'] = _classId;
    map['operationId'] = _operationId;
    map['name'] = _name;
    map['teacherId'] = _teacherId;
    map['studentUserId'] = _studentUserId;
    map['deadline'] = _deadline;
    map['timeRemaining'] = _timeRemaining;
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
    map['isDelete'] = _isDelete;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    return map;
  }

}