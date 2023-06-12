/// code : 0
/// message : "系统正常"
/// obj : {"topThree":[{"id":1667095996286972000,"isDelete":false,"createUser":1651539603655626800,"createTime":"2023-06-09T17:07:13","updateUser":1651533076075499500,"updateTime":"2023-06-09T17:11:10","operationClassId":1667095996182114300,"classId":1655395694170124300,"operationId":1667095995569746000,"name":"测试流程3","teacherId":1651539603655626800,"studentUserId":1651533076075499500,"deadline":"2023-06-11T17:07:04","operationStatus":4,"studentStatus":2,"hasSubjective":false,"isCorrection":false,"objectiveSize":4,"objectiveProperSize":2,"objectiveCompleteSize":4,"subjectiveSize":0,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":4,"completeSize":4,"completeTime":"2023-06-09T17:11:10","classRanking":1,"studentName":"李四","avatar":"http://cdn-files-test.crazyenglishweekly.com/static/userProfile.png","className":null,"gradeId":null,"gradeName":null,"classOperationStatus":null,"classAccuracy":null},{"id":1667095996266000400,"isDelete":false,"createUser":1651539603655626800,"createTime":"2023-06-09T17:07:13","updateUser":1651533076075499500,"updateTime":"2023-06-09T17:11:10","operationClassId":1667095996182114300,"classId":1655395694170124300,"operationId":1667095995569746000,"name":"测试流程3","teacherId":1651539603655626800,"studentUserId":1651531759961624600,"deadline":"2023-06-11T17:07:04","operationStatus":4,"studentStatus":2,"hasSubjective":false,"isCorrection":false,"objectiveSize":4,"objectiveProperSize":2,"objectiveCompleteSize":4,"subjectiveSize":0,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":4,"completeSize":4,"completeTime":"2023-06-09T17:08:27","classRanking":1,"studentName":"张三","avatar":"http://cdn-files-test.crazyenglishweekly.com/crazyenglish/app/1651531759961624578/headimg_1651531759961624578_imgimage_cropper_512FD8C6-236B-44E7-8C96-4AC744ED1858-1231-000000F54C397D7D.jpg","className":null,"gradeId":null,"gradeName":null,"classOperationStatus":null,"classAccuracy":null}],"notSubmit":[{"id":118,"isDelete":true,"createUser":91,"createTime":"2023-06-09 16:43:03","updateUser":392,"updateTime":"2023-06-09 16:43:03","operationClassId":202,"classId":668,"operationId":966,"name":"shawnee.hudson","teacherId":407,"studentUserId":933,"deadline":"2023-06-09 16:43:03","operationStatus":851,"studentStatus":307,"hasSubjective":true,"isCorrection":true,"objectiveSize":10,"objectiveProperSize":10,"objectiveCompleteSize":10,"subjectiveSize":10,"subjectiveTotalScore":155,"subjectiveCompleteSize":10,"totalSize":10,"completeSize":10,"completeTime":"2023-06-09 16:43:03","classRanking":972,"studentName":"shawnee.hudson","avatar":"3z19m4","className":"shawnee.hudson","gradeId":80,"gradeName":"shawnee.hudson","classOperationStatus":509,"classAccuracy":160}]}
/// p : null

class ReportResponse {
  ReportResponse({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  ReportResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
ReportResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => ReportResponse(  code: code ?? _code,
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

/// topThree : [{"id":1667095996286972000,"isDelete":false,"createUser":1651539603655626800,"createTime":"2023-06-09T17:07:13","updateUser":1651533076075499500,"updateTime":"2023-06-09T17:11:10","operationClassId":1667095996182114300,"classId":1655395694170124300,"operationId":1667095995569746000,"name":"测试流程3","teacherId":1651539603655626800,"studentUserId":1651533076075499500,"deadline":"2023-06-11T17:07:04","operationStatus":4,"studentStatus":2,"hasSubjective":false,"isCorrection":false,"objectiveSize":4,"objectiveProperSize":2,"objectiveCompleteSize":4,"subjectiveSize":0,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":4,"completeSize":4,"completeTime":"2023-06-09T17:11:10","classRanking":1,"studentName":"李四","avatar":"http://cdn-files-test.crazyenglishweekly.com/static/userProfile.png","className":null,"gradeId":null,"gradeName":null,"classOperationStatus":null,"classAccuracy":null},{"id":1667095996266000400,"isDelete":false,"createUser":1651539603655626800,"createTime":"2023-06-09T17:07:13","updateUser":1651533076075499500,"updateTime":"2023-06-09T17:11:10","operationClassId":1667095996182114300,"classId":1655395694170124300,"operationId":1667095995569746000,"name":"测试流程3","teacherId":1651539603655626800,"studentUserId":1651531759961624600,"deadline":"2023-06-11T17:07:04","operationStatus":4,"studentStatus":2,"hasSubjective":false,"isCorrection":false,"objectiveSize":4,"objectiveProperSize":2,"objectiveCompleteSize":4,"subjectiveSize":0,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":4,"completeSize":4,"completeTime":"2023-06-09T17:08:27","classRanking":1,"studentName":"张三","avatar":"http://cdn-files-test.crazyenglishweekly.com/crazyenglish/app/1651531759961624578/headimg_1651531759961624578_imgimage_cropper_512FD8C6-236B-44E7-8C96-4AC744ED1858-1231-000000F54C397D7D.jpg","className":null,"gradeId":null,"gradeName":null,"classOperationStatus":null,"classAccuracy":null}]
/// notSubmit : [{"id":118,"isDelete":true,"createUser":91,"createTime":"2023-06-09 16:43:03","updateUser":392,"updateTime":"2023-06-09 16:43:03","operationClassId":202,"classId":668,"operationId":966,"name":"shawnee.hudson","teacherId":407,"studentUserId":933,"deadline":"2023-06-09 16:43:03","operationStatus":851,"studentStatus":307,"hasSubjective":true,"isCorrection":true,"objectiveSize":10,"objectiveProperSize":10,"objectiveCompleteSize":10,"subjectiveSize":10,"subjectiveTotalScore":155,"subjectiveCompleteSize":10,"totalSize":10,"completeSize":10,"completeTime":"2023-06-09 16:43:03","classRanking":972,"studentName":"shawnee.hudson","avatar":"3z19m4","className":"shawnee.hudson","gradeId":80,"gradeName":"shawnee.hudson","classOperationStatus":509,"classAccuracy":160}]

class Obj {
  Obj({
      List<TopThree>? topThree, 
      List<NotSubmit>? notSubmit,}){
    _topThree = topThree;
    _notSubmit = notSubmit;
}

  Obj.fromJson(dynamic json) {
    if (json['topThree'] != null) {
      _topThree = [];
      json['topThree'].forEach((v) {
        _topThree?.add(TopThree.fromJson(v));
      });
    }
    if (json['notSubmit'] != null) {
      _notSubmit = [];
      json['notSubmit'].forEach((v) {
        _notSubmit?.add(NotSubmit.fromJson(v));
      });
    }
  }
  List<TopThree>? _topThree;
  List<NotSubmit>? _notSubmit;
Obj copyWith({  List<TopThree>? topThree,
  List<NotSubmit>? notSubmit,
}) => Obj(  topThree: topThree ?? _topThree,
  notSubmit: notSubmit ?? _notSubmit,
);
  List<TopThree>? get topThree => _topThree;
  List<NotSubmit>? get notSubmit => _notSubmit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topThree != null) {
      map['topThree'] = _topThree?.map((v) => v.toJson()).toList();
    }
    if (_notSubmit != null) {
      map['notSubmit'] = _notSubmit?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 118
/// isDelete : true
/// createUser : 91
/// createTime : "2023-06-09 16:43:03"
/// updateUser : 392
/// updateTime : "2023-06-09 16:43:03"
/// operationClassId : 202
/// classId : 668
/// operationId : 966
/// name : "shawnee.hudson"
/// teacherId : 407
/// studentUserId : 933
/// deadline : "2023-06-09 16:43:03"
/// operationStatus : 851
/// studentStatus : 307
/// hasSubjective : true
/// isCorrection : true
/// objectiveSize : 10
/// objectiveProperSize : 10
/// objectiveCompleteSize : 10
/// subjectiveSize : 10
/// subjectiveTotalScore : 155
/// subjectiveCompleteSize : 10
/// totalSize : 10
/// completeSize : 10
/// completeTime : "2023-06-09 16:43:03"
/// classRanking : 972
/// studentName : "shawnee.hudson"
/// avatar : "3z19m4"
/// className : "shawnee.hudson"
/// gradeId : 80
/// gradeName : "shawnee.hudson"
/// classOperationStatus : 509
/// classAccuracy : 160

class NotSubmit {
  NotSubmit({
      num? id, 
      bool? isDelete, 
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime, 
      num? operationClassId, 
      num? classId, 
      num? operationId, 
      String? name, 
      num? teacherId, 
      num? studentUserId, 
      String? deadline, 
      num? operationStatus, 
      num? studentStatus, 
      bool? hasSubjective, 
      bool? isCorrection, 
      num? objectiveSize, 
      num? objectiveProperSize, 
      num? objectiveCompleteSize, 
      num? subjectiveSize, 
      num? subjectiveTotalScore, 
      num? subjectiveCompleteSize, 
      num? totalSize, 
      num? completeSize, 
      String? completeTime, 
      num? classRanking, 
      String? studentName, 
      String? avatar, 
      String? className, 
      num? gradeId, 
      String? gradeName, 
      num? classOperationStatus, 
      num? classAccuracy,}){
    _id = id;
    _isDelete = isDelete;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
    _operationClassId = operationClassId;
    _classId = classId;
    _operationId = operationId;
    _name = name;
    _teacherId = teacherId;
    _studentUserId = studentUserId;
    _deadline = deadline;
    _operationStatus = operationStatus;
    _studentStatus = studentStatus;
    _hasSubjective = hasSubjective;
    _isCorrection = isCorrection;
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
    _studentName = studentName;
    _avatar = avatar;
    _className = className;
    _gradeId = gradeId;
    _gradeName = gradeName;
    _classOperationStatus = classOperationStatus;
    _classAccuracy = classAccuracy;
}

  NotSubmit.fromJson(dynamic json) {
    _id = json['id'];
    _isDelete = json['isDelete'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
    _operationClassId = json['operationClassId'];
    _classId = json['classId'];
    _operationId = json['operationId'];
    _name = json['name'];
    _teacherId = json['teacherId'];
    _studentUserId = json['studentUserId'];
    _deadline = json['deadline'];
    _operationStatus = json['operationStatus'];
    _studentStatus = json['studentStatus'];
    _hasSubjective = json['hasSubjective'];
    _isCorrection = json['isCorrection'];
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
    _studentName = json['studentName'];
    _avatar = json['avatar'];
    _className = json['className'];
    _gradeId = json['gradeId'];
    _gradeName = json['gradeName'];
    _classOperationStatus = json['classOperationStatus'];
    _classAccuracy = json['classAccuracy'];
  }
  num? _id;
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
  num? _operationClassId;
  num? _classId;
  num? _operationId;
  String? _name;
  num? _teacherId;
  num? _studentUserId;
  String? _deadline;
  num? _operationStatus;
  num? _studentStatus;
  bool? _hasSubjective;
  bool? _isCorrection;
  num? _objectiveSize;
  num? _objectiveProperSize;
  num? _objectiveCompleteSize;
  num? _subjectiveSize;
  num? _subjectiveTotalScore;
  num? _subjectiveCompleteSize;
  num? _totalSize;
  num? _completeSize;
  String? _completeTime;
  num? _classRanking;
  String? _studentName;
  String? _avatar;
  String? _className;
  num? _gradeId;
  String? _gradeName;
  num? _classOperationStatus;
  num? _classAccuracy;
NotSubmit copyWith({  num? id,
  bool? isDelete,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
  num? operationClassId,
  num? classId,
  num? operationId,
  String? name,
  num? teacherId,
  num? studentUserId,
  String? deadline,
  num? operationStatus,
  num? studentStatus,
  bool? hasSubjective,
  bool? isCorrection,
  num? objectiveSize,
  num? objectiveProperSize,
  num? objectiveCompleteSize,
  num? subjectiveSize,
  num? subjectiveTotalScore,
  num? subjectiveCompleteSize,
  num? totalSize,
  num? completeSize,
  String? completeTime,
  num? classRanking,
  String? studentName,
  String? avatar,
  String? className,
  num? gradeId,
  String? gradeName,
  num? classOperationStatus,
  num? classAccuracy,
}) => NotSubmit(  id: id ?? _id,
  isDelete: isDelete ?? _isDelete,
  createUser: createUser ?? _createUser,
  createTime: createTime ?? _createTime,
  updateUser: updateUser ?? _updateUser,
  updateTime: updateTime ?? _updateTime,
  operationClassId: operationClassId ?? _operationClassId,
  classId: classId ?? _classId,
  operationId: operationId ?? _operationId,
  name: name ?? _name,
  teacherId: teacherId ?? _teacherId,
  studentUserId: studentUserId ?? _studentUserId,
  deadline: deadline ?? _deadline,
  operationStatus: operationStatus ?? _operationStatus,
  studentStatus: studentStatus ?? _studentStatus,
  hasSubjective: hasSubjective ?? _hasSubjective,
  isCorrection: isCorrection ?? _isCorrection,
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
  studentName: studentName ?? _studentName,
  avatar: avatar ?? _avatar,
  className: className ?? _className,
  gradeId: gradeId ?? _gradeId,
  gradeName: gradeName ?? _gradeName,
  classOperationStatus: classOperationStatus ?? _classOperationStatus,
  classAccuracy: classAccuracy ?? _classAccuracy,
);
  num? get id => _id;
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;
  num? get operationClassId => _operationClassId;
  num? get classId => _classId;
  num? get operationId => _operationId;
  String? get name => _name;
  num? get teacherId => _teacherId;
  num? get studentUserId => _studentUserId;
  String? get deadline => _deadline;
  num? get operationStatus => _operationStatus;
  num? get studentStatus => _studentStatus;
  bool? get hasSubjective => _hasSubjective;
  bool? get isCorrection => _isCorrection;
  num? get objectiveSize => _objectiveSize;
  num? get objectiveProperSize => _objectiveProperSize;
  num? get objectiveCompleteSize => _objectiveCompleteSize;
  num? get subjectiveSize => _subjectiveSize;
  num? get subjectiveTotalScore => _subjectiveTotalScore;
  num? get subjectiveCompleteSize => _subjectiveCompleteSize;
  num? get totalSize => _totalSize;
  num? get completeSize => _completeSize;
  String? get completeTime => _completeTime;
  num? get classRanking => _classRanking;
  String? get studentName => _studentName;
  String? get avatar => _avatar;
  String? get className => _className;
  num? get gradeId => _gradeId;
  String? get gradeName => _gradeName;
  num? get classOperationStatus => _classOperationStatus;
  num? get classAccuracy => _classAccuracy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['isDelete'] = _isDelete;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    map['operationClassId'] = _operationClassId;
    map['classId'] = _classId;
    map['operationId'] = _operationId;
    map['name'] = _name;
    map['teacherId'] = _teacherId;
    map['studentUserId'] = _studentUserId;
    map['deadline'] = _deadline;
    map['operationStatus'] = _operationStatus;
    map['studentStatus'] = _studentStatus;
    map['hasSubjective'] = _hasSubjective;
    map['isCorrection'] = _isCorrection;
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
    map['studentName'] = _studentName;
    map['avatar'] = _avatar;
    map['className'] = _className;
    map['gradeId'] = _gradeId;
    map['gradeName'] = _gradeName;
    map['classOperationStatus'] = _classOperationStatus;
    map['classAccuracy'] = _classAccuracy;
    return map;
  }

}

/// id : 1667095996286972000
/// isDelete : false
/// createUser : 1651539603655626800
/// createTime : "2023-06-09T17:07:13"
/// updateUser : 1651533076075499500
/// updateTime : "2023-06-09T17:11:10"
/// operationClassId : 1667095996182114300
/// classId : 1655395694170124300
/// operationId : 1667095995569746000
/// name : "测试流程3"
/// teacherId : 1651539603655626800
/// studentUserId : 1651533076075499500
/// deadline : "2023-06-11T17:07:04"
/// operationStatus : 4
/// studentStatus : 2
/// hasSubjective : false
/// isCorrection : false
/// objectiveSize : 4
/// objectiveProperSize : 2
/// objectiveCompleteSize : 4
/// subjectiveSize : 0
/// subjectiveTotalScore : 0
/// subjectiveCompleteSize : 0
/// totalSize : 4
/// completeSize : 4
/// completeTime : "2023-06-09T17:11:10"
/// classRanking : 1
/// studentName : "李四"
/// avatar : "http://cdn-files-test.crazyenglishweekly.com/static/userProfile.png"
/// className : null
/// gradeId : null
/// gradeName : null
/// classOperationStatus : null
/// classAccuracy : null

class TopThree {
  TopThree({
      num? id, 
      bool? isDelete, 
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime, 
      num? operationClassId, 
      num? classId, 
      num? operationId, 
      String? name, 
      num? teacherId, 
      num? studentUserId, 
      String? deadline, 
      num? operationStatus, 
      num? studentStatus, 
      bool? hasSubjective, 
      bool? isCorrection, 
      num? objectiveSize, 
      num? objectiveProperSize, 
      num? objectiveCompleteSize, 
      num? subjectiveSize, 
      num? subjectiveTotalScore, 
      num? subjectiveCompleteSize, 
      num? totalSize, 
      num? completeSize, 
      String? completeTime, 
      num? classRanking, 
      String? studentName, 
      String? avatar, 
      dynamic className, 
      dynamic gradeId, 
      dynamic gradeName, 
      dynamic classOperationStatus, 
      dynamic classAccuracy,}){
    _id = id;
    _isDelete = isDelete;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
    _operationClassId = operationClassId;
    _classId = classId;
    _operationId = operationId;
    _name = name;
    _teacherId = teacherId;
    _studentUserId = studentUserId;
    _deadline = deadline;
    _operationStatus = operationStatus;
    _studentStatus = studentStatus;
    _hasSubjective = hasSubjective;
    _isCorrection = isCorrection;
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
    _studentName = studentName;
    _avatar = avatar;
    _className = className;
    _gradeId = gradeId;
    _gradeName = gradeName;
    _classOperationStatus = classOperationStatus;
    _classAccuracy = classAccuracy;
}

  TopThree.fromJson(dynamic json) {
    _id = json['id'];
    _isDelete = json['isDelete'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
    _operationClassId = json['operationClassId'];
    _classId = json['classId'];
    _operationId = json['operationId'];
    _name = json['name'];
    _teacherId = json['teacherId'];
    _studentUserId = json['studentUserId'];
    _deadline = json['deadline'];
    _operationStatus = json['operationStatus'];
    _studentStatus = json['studentStatus'];
    _hasSubjective = json['hasSubjective'];
    _isCorrection = json['isCorrection'];
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
    _studentName = json['studentName'];
    _avatar = json['avatar'];
    _className = json['className'];
    _gradeId = json['gradeId'];
    _gradeName = json['gradeName'];
    _classOperationStatus = json['classOperationStatus'];
    _classAccuracy = json['classAccuracy'];
  }
  num? _id;
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
  num? _operationClassId;
  num? _classId;
  num? _operationId;
  String? _name;
  num? _teacherId;
  num? _studentUserId;
  String? _deadline;
  num? _operationStatus;
  num? _studentStatus;
  bool? _hasSubjective;
  bool? _isCorrection;
  num? _objectiveSize;
  num? _objectiveProperSize;
  num? _objectiveCompleteSize;
  num? _subjectiveSize;
  num? _subjectiveTotalScore;
  num? _subjectiveCompleteSize;
  num? _totalSize;
  num? _completeSize;
  String? _completeTime;
  num? _classRanking;
  String? _studentName;
  String? _avatar;
  dynamic _className;
  dynamic _gradeId;
  dynamic _gradeName;
  dynamic _classOperationStatus;
  dynamic _classAccuracy;
TopThree copyWith({  num? id,
  bool? isDelete,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
  num? operationClassId,
  num? classId,
  num? operationId,
  String? name,
  num? teacherId,
  num? studentUserId,
  String? deadline,
  num? operationStatus,
  num? studentStatus,
  bool? hasSubjective,
  bool? isCorrection,
  num? objectiveSize,
  num? objectiveProperSize,
  num? objectiveCompleteSize,
  num? subjectiveSize,
  num? subjectiveTotalScore,
  num? subjectiveCompleteSize,
  num? totalSize,
  num? completeSize,
  String? completeTime,
  num? classRanking,
  String? studentName,
  String? avatar,
  dynamic className,
  dynamic gradeId,
  dynamic gradeName,
  dynamic classOperationStatus,
  dynamic classAccuracy,
}) => TopThree(  id: id ?? _id,
  isDelete: isDelete ?? _isDelete,
  createUser: createUser ?? _createUser,
  createTime: createTime ?? _createTime,
  updateUser: updateUser ?? _updateUser,
  updateTime: updateTime ?? _updateTime,
  operationClassId: operationClassId ?? _operationClassId,
  classId: classId ?? _classId,
  operationId: operationId ?? _operationId,
  name: name ?? _name,
  teacherId: teacherId ?? _teacherId,
  studentUserId: studentUserId ?? _studentUserId,
  deadline: deadline ?? _deadline,
  operationStatus: operationStatus ?? _operationStatus,
  studentStatus: studentStatus ?? _studentStatus,
  hasSubjective: hasSubjective ?? _hasSubjective,
  isCorrection: isCorrection ?? _isCorrection,
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
  studentName: studentName ?? _studentName,
  avatar: avatar ?? _avatar,
  className: className ?? _className,
  gradeId: gradeId ?? _gradeId,
  gradeName: gradeName ?? _gradeName,
  classOperationStatus: classOperationStatus ?? _classOperationStatus,
  classAccuracy: classAccuracy ?? _classAccuracy,
);
  num? get id => _id;
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;
  num? get operationClassId => _operationClassId;
  num? get classId => _classId;
  num? get operationId => _operationId;
  String? get name => _name;
  num? get teacherId => _teacherId;
  num? get studentUserId => _studentUserId;
  String? get deadline => _deadline;
  num? get operationStatus => _operationStatus;
  num? get studentStatus => _studentStatus;
  bool? get hasSubjective => _hasSubjective;
  bool? get isCorrection => _isCorrection;
  num? get objectiveSize => _objectiveSize;
  num? get objectiveProperSize => _objectiveProperSize;
  num? get objectiveCompleteSize => _objectiveCompleteSize;
  num? get subjectiveSize => _subjectiveSize;
  num? get subjectiveTotalScore => _subjectiveTotalScore;
  num? get subjectiveCompleteSize => _subjectiveCompleteSize;
  num? get totalSize => _totalSize;
  num? get completeSize => _completeSize;
  String? get completeTime => _completeTime;
  num? get classRanking => _classRanking;
  String? get studentName => _studentName;
  String? get avatar => _avatar;
  dynamic get className => _className;
  dynamic get gradeId => _gradeId;
  dynamic get gradeName => _gradeName;
  dynamic get classOperationStatus => _classOperationStatus;
  dynamic get classAccuracy => _classAccuracy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['isDelete'] = _isDelete;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    map['operationClassId'] = _operationClassId;
    map['classId'] = _classId;
    map['operationId'] = _operationId;
    map['name'] = _name;
    map['teacherId'] = _teacherId;
    map['studentUserId'] = _studentUserId;
    map['deadline'] = _deadline;
    map['operationStatus'] = _operationStatus;
    map['studentStatus'] = _studentStatus;
    map['hasSubjective'] = _hasSubjective;
    map['isCorrection'] = _isCorrection;
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
    map['studentName'] = _studentName;
    map['avatar'] = _avatar;
    map['className'] = _className;
    map['gradeId'] = _gradeId;
    map['gradeName'] = _gradeName;
    map['classOperationStatus'] = _classOperationStatus;
    map['classAccuracy'] = _classAccuracy;
    return map;
  }

}