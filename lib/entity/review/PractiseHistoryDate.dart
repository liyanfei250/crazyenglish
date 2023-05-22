/// code : 0
/// message : "系统正常"
/// obj : [{"exerciseId":1648489081851772929,"questionTypeName":"完形填空","time":"09:14:11","exerciseCount":16,"correctCount":11,"accuracy":"68.75"}]
/// p : null

class PractiseHistoryDate {

  PractiseHistoryDate({
    num? code,
    String? message,
    List<Obj>? obj,
    dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
  }

  PractiseHistoryDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
  PractiseHistoryDate copyWith({  num? code,
    String? message,
    List<Obj>? obj,
    dynamic p,
  }) => PractiseHistoryDate(  code: code ?? _code,
    message: message ?? _message,
    obj: obj ?? _obj,
    p: p ?? _p,
  );
  num? get code => _code;
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

/// operationClassId : 1657627484346724400
/// classId : 1655395694170124300
/// operationId : 1657627484292198400
/// name : "最新试题"
/// teacherId : 1651539603655626800
/// studentUserId : 1651531759961624600
/// deadline : "2023-05-18T08:47:29"
/// operationStatus : 2
/// studentStatus : 1
/// objectiveSize : 0
/// objectiveProperSize : 0
/// objectiveCompleteSize : 0
/// subjectiveSize : 1
/// subjectiveTotalScore : 0
/// subjectiveCompleteSize : 0
/// totalSize : 1
/// completeSize : 0
/// completeTime : null
/// classRanking : 0
/// isDelete : false
/// createUser : 1651539603655626800
/// createTime : "2023-05-14T14:02:44"
/// updateUser : 1651539603655626800
/// updateTime : "2023-05-14T14:02:44"
/// studentName : null
/// avatar : null
/// className : "精英班"
/// gradeId : null
/// gradeName : null
/// classOperationStatus : 1
/// classAccuracy : 0

class Obj {
  Obj({
    num? operationClassId,
    num? classId,
    num? operationId,
    String? name,
    String? journalName,
    num? teacherId,
    num? studentUserId,
    String? deadline,
    num? operationStatus,
    num? studentStatus,
    num? objectiveSize,
    num? objectiveProperSize,
    num? objectiveCompleteSize,
    num? subjectiveSize,
    num? subjectiveTotalScore,
    num? subjectiveCompleteSize,
    num? totalSize,
    num? completeSize,
    dynamic completeTime,
    num? classRanking,
    bool? isDelete,
    num? createUser,
    String? createTime,
    num? updateUser,
    String? updateTime,
    dynamic studentName,
    dynamic avatar,
    String? className,
    dynamic gradeId,
    dynamic gradeName,
    num? classOperationStatus,
    num? classAccuracy,
    num? exerciseId,
    num? subjectId,
    String? questionTypeName,
    String? time,
    num? exerciseCount,
    num? correctCount,
    String? accuracy,
  }){
    _operationClassId = operationClassId;
    _classId = classId;
    _operationId = operationId;
    _name = name;
    _journalName = journalName;
    _teacherId = teacherId;
    _studentUserId = studentUserId;
    _deadline = deadline;
    _operationStatus = operationStatus;
    _studentStatus = studentStatus;
    _objectiveSize = objectiveSize;
    _objectiveProperSize = objectiveProperSize;
    _objectiveCompleteSize = objectiveCompleteSize;
    _subjectiveSize = subjectiveSize;
    _subjectiveTotalScore = subjectiveTotalScore;
    _subjectiveCompleteSize = subjectiveCompleteSize;
    _totalSize = totalSize;
    _completeSize = completeSize;
    _completeTime = completeTime;
    _classRanking = classRanking;
    _isDelete = isDelete;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
    _studentName = studentName;
    _avatar = avatar;
    _className = className;
    _gradeId = gradeId;
    _gradeName = gradeName;
    _classOperationStatus = classOperationStatus;
    _classAccuracy = classAccuracy;
    _exerciseId = exerciseId;
    _subjectId = subjectId;
    _questionTypeName = questionTypeName;
    _time = time;
    _exerciseCount = exerciseCount;
    _correctCount = correctCount;
    _accuracy = accuracy;
  }

  Obj.fromJson(dynamic json) {
    _operationClassId = json['operationClassId'];
    _classId = json['classId'];
    _operationId = json['operationId'];
    _name = json['name'];
    _journalName = json['journalName'];
    _teacherId = json['teacherId'];
    _studentUserId = json['studentUserId'];
    _deadline = json['deadline'];
    _operationStatus = json['operationStatus'];
    _studentStatus = json['studentStatus'];
    _objectiveSize = json['objectiveSize'];
    _objectiveProperSize = json['objectiveProperSize'];
    _objectiveCompleteSize = json['objectiveCompleteSize'];
    _subjectiveSize = json['subjectiveSize'];
    _subjectiveTotalScore = json['subjectiveTotalScore'];
    _subjectiveCompleteSize = json['subjectiveCompleteSize'];
    _totalSize = json['totalSize'];
    _completeSize = json['completeSize'];
    _completeTime = json['completeTime'];
    _classRanking = json['classRanking'];
    _isDelete = json['isDelete'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
    _studentName = json['studentName'];
    _avatar = json['avatar'];
    _className = json['className'];
    _gradeId = json['gradeId'];
    _gradeName = json['gradeName'];
    _classOperationStatus = json['classOperationStatus'];
    _classAccuracy = json['classAccuracy'];
    _exerciseId = json['exerciseId'];
    _subjectId = json['subjectId'];
    _questionTypeName = json['questionTypeName'];
    _time = json['time'];
    _exerciseCount = json['exerciseCount'];
    _correctCount = json['correctCount'];
    _accuracy = json['accuracy'];
  }
  num? _operationClassId;
  num? _classId;
  num? _operationId;
  String? _name;
  String? _journalName;
  num? _teacherId;
  num? _studentUserId;
  String? _deadline;
  num? _operationStatus;
  num? _studentStatus;
  num? _objectiveSize;
  num? _objectiveProperSize;
  num? _objectiveCompleteSize;
  num? _subjectiveSize;
  num? _subjectiveTotalScore;
  num? _subjectiveCompleteSize;
  num? _totalSize;
  num? _completeSize;
  dynamic _completeTime;
  num? _classRanking;
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
  dynamic _studentName;
  dynamic _avatar;
  String? _className;
  dynamic _gradeId;
  dynamic _gradeName;
  num? _classOperationStatus;
  num? _classAccuracy;
  num? _exerciseId;
  num? _subjectId;
  String? _questionTypeName;
  String? _time;
  num? _exerciseCount;
  num? _correctCount;
  String? _accuracy;
  Obj copyWith({  num? operationClassId,
    num? classId,
    num? operationId,
    String? name,
    String? journalName,
    num? teacherId,
    num? studentUserId,
    String? deadline,
    num? operationStatus,
    num? studentStatus,
    num? objectiveSize,
    num? objectiveProperSize,
    num? objectiveCompleteSize,
    num? subjectiveSize,
    num? subjectiveTotalScore,
    num? subjectiveCompleteSize,
    num? totalSize,
    num? completeSize,
    dynamic completeTime,
    num? classRanking,
    bool? isDelete,
    num? createUser,
    String? createTime,
    num? updateUser,
    String? updateTime,
    dynamic studentName,
    dynamic avatar,
    String? className,
    dynamic gradeId,
    dynamic gradeName,
    num? classOperationStatus,
    num? classAccuracy,
    num? exerciseId,
    num? subjectId,
    String? questionTypeName,
    String? time,
    num? exerciseCount,
    num? correctCount,
    String? accuracy,
  }) => Obj(  operationClassId: operationClassId ?? _operationClassId,
    classId: classId ?? _classId,
    operationId: operationId ?? _operationId,
    name: name ?? _name,
    journalName: journalName ?? _journalName,
    teacherId: teacherId ?? _teacherId,
    studentUserId: studentUserId ?? _studentUserId,
    deadline: deadline ?? _deadline,
    operationStatus: operationStatus ?? _operationStatus,
    studentStatus: studentStatus ?? _studentStatus,
    objectiveSize: objectiveSize ?? _objectiveSize,
    objectiveProperSize: objectiveProperSize ?? _objectiveProperSize,
    objectiveCompleteSize: objectiveCompleteSize ?? _objectiveCompleteSize,
    subjectiveSize: subjectiveSize ?? _subjectiveSize,
    subjectiveTotalScore: subjectiveTotalScore ?? _subjectiveTotalScore,
    subjectiveCompleteSize: subjectiveCompleteSize ?? _subjectiveCompleteSize,
    totalSize: totalSize ?? _totalSize,
    completeSize: completeSize ?? _completeSize,
    completeTime: completeTime ?? _completeTime,
    classRanking: classRanking ?? _classRanking,
    isDelete: isDelete ?? _isDelete,
    createUser: createUser ?? _createUser,
    createTime: createTime ?? _createTime,
    updateUser: updateUser ?? _updateUser,
    updateTime: updateTime ?? _updateTime,
    studentName: studentName ?? _studentName,
    avatar: avatar ?? _avatar,
    className: className ?? _className,
    gradeId: gradeId ?? _gradeId,
    gradeName: gradeName ?? _gradeName,
    classOperationStatus: classOperationStatus ?? _classOperationStatus,
    classAccuracy: classAccuracy ?? _classAccuracy,
    exerciseId: exerciseId ?? _exerciseId,
    subjectId: subjectId ?? _subjectId,
    questionTypeName: questionTypeName ?? _questionTypeName,
    time: time ?? _time,
    exerciseCount: exerciseCount ?? _exerciseCount,
    correctCount: correctCount ?? _correctCount,
    accuracy: accuracy ?? _accuracy,
  );
  num? get operationClassId => _operationClassId;
  num? get classId => _classId;
  num? get operationId => _operationId;
  String? get name => _name;
  String? get journalName => _journalName;
  num? get teacherId => _teacherId;
  num? get studentUserId => _studentUserId;
  String? get deadline => _deadline;
  num? get operationStatus => _operationStatus;
  num? get studentStatus => _studentStatus;
  num? get objectiveSize => _objectiveSize;
  num? get objectiveProperSize => _objectiveProperSize;
  num? get objectiveCompleteSize => _objectiveCompleteSize;
  num? get subjectiveSize => _subjectiveSize;
  num? get subjectiveTotalScore => _subjectiveTotalScore;
  num? get subjectiveCompleteSize => _subjectiveCompleteSize;
  num? get totalSize => _totalSize;
  num? get completeSize => _completeSize;
  dynamic get completeTime => _completeTime;
  num? get classRanking => _classRanking;
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;
  dynamic get studentName => _studentName;
  dynamic get avatar => _avatar;
  String? get className => _className;
  dynamic get gradeId => _gradeId;
  dynamic get gradeName => _gradeName;
  num? get classOperationStatus => _classOperationStatus;
  num? get classAccuracy => _classAccuracy;
  num? get exerciseId => _exerciseId;
  num? get subjectId => _subjectId;
  String? get questionTypeName => _questionTypeName;
  String? get time => _time;
  num? get exerciseCount => _exerciseCount;
  num? get correctCount => _correctCount;
  String? get accuracy => _accuracy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['operationClassId'] = _operationClassId;
    map['classId'] = _classId;
    map['operationId'] = _operationId;
    map['name'] = _name;
    map['journalName'] = _journalName;
    map['teacherId'] = _teacherId;
    map['studentUserId'] = _studentUserId;
    map['deadline'] = _deadline;
    map['operationStatus'] = _operationStatus;
    map['studentStatus'] = _studentStatus;
    map['objectiveSize'] = _objectiveSize;
    map['objectiveProperSize'] = _objectiveProperSize;
    map['objectiveCompleteSize'] = _objectiveCompleteSize;
    map['subjectiveSize'] = _subjectiveSize;
    map['subjectiveTotalScore'] = _subjectiveTotalScore;
    map['subjectiveCompleteSize'] = _subjectiveCompleteSize;
    map['totalSize'] = _totalSize;
    map['completeSize'] = _completeSize;
    map['completeTime'] = _completeTime;
    map['classRanking'] = _classRanking;
    map['isDelete'] = _isDelete;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    map['studentName'] = _studentName;
    map['avatar'] = _avatar;
    map['className'] = _className;
    map['gradeId'] = _gradeId;
    map['gradeName'] = _gradeName;
    map['classOperationStatus'] = _classOperationStatus;
    map['classAccuracy'] = _classAccuracy;
    map['exerciseId'] = _exerciseId;
    map['subjectId'] = _subjectId;
    map['questionTypeName'] = _questionTypeName;
    map['time'] = _time;
    map['exerciseCount'] = _exerciseCount;
    map['correctCount'] = _correctCount;
    map['accuracy'] = _accuracy;
    return map;
  }

}