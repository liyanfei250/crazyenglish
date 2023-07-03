/// code : 0
/// message : "系统正常"
/// obj : {"records":[{"operationClassId":1657627484346724400,"classId":1655395694170124300,"operationId":1657627484292198400,"name":"最新试题","teacherId":1651539603655626800,"studentUserId":1651531759961624600,"deadline":"2023-05-18T08:47:29","operationStatus":2,"studentStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"classRanking":0,"isDelete":false,"createUser":1651539603655626800,"createTime":"2023-05-14T14:02:44","updateUser":1651539603655626800,"updateTime":"2023-05-14T14:02:44","studentName":null,"avatar":null,"className":"精英班","gradeId":null,"gradeName":null,"classOperationStatus":1,"classAccuracy":0}],"total":1,"size":10,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}
/// p : null

class HistoryHomeworkDate {
  HistoryHomeworkDate({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  HistoryHomeworkDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
HistoryHomeworkDate copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => HistoryHomeworkDate(  code: code ?? _code,
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

/// records : [{"operationClassId":1657627484346724400,"classId":1655395694170124300,"operationId":1657627484292198400,"name":"最新试题","teacherId":1651539603655626800,"studentUserId":1651531759961624600,"deadline":"2023-05-18T08:47:29","operationStatus":2,"studentStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"classRanking":0,"isDelete":false,"createUser":1651539603655626800,"createTime":"2023-05-14T14:02:44","updateUser":1651539603655626800,"updateTime":"2023-05-14T14:02:44","studentName":null,"avatar":null,"className":"精英班","gradeId":null,"gradeName":null,"classOperationStatus":1,"classAccuracy":0}]
/// total : 1
/// size : 10
/// current : 1
/// orders : []
/// optimizeCountSql : true
/// hitCount : false
/// countId : null
/// maxLimit : null
/// searchCount : true
/// pages : 1

class Obj {
  Obj({
      List<Records>? records, 
      num? total, 
      num? size, 
      num? current, 
      List<dynamic>? orders, 
      bool? optimizeCountSql, 
      bool? hitCount, 
      dynamic countId, 
      dynamic maxLimit, 
      bool? searchCount, 
      num? pages,}){
    _records = records;
    _total = total;
    _size = size;
    _current = current;
    _orders = orders;
    _optimizeCountSql = optimizeCountSql;
    _hitCount = hitCount;
    _countId = countId;
    _maxLimit = maxLimit;
    _searchCount = searchCount;
    _pages = pages;
}

  Obj.fromJson(dynamic json) {
    if (json['records'] != null) {
      _records = [];
      json['records'].forEach((v) {
        _records?.add(Records.fromJson(v));
      });
    }
    _total = json['total'];
    _size = json['size'];
    _current = json['current'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        // _orders?.add(Dynamic.fromJson(v));
      });
    }
    _optimizeCountSql = json['optimizeCountSql'];
    _hitCount = json['hitCount'];
    _countId = json['countId'];
    _maxLimit = json['maxLimit'];
    _searchCount = json['searchCount'];
    _pages = json['pages'];
  }
  List<Records>? _records;
  num? _total;
  num? _size;
  num? _current;
  List<dynamic>? _orders;
  bool? _optimizeCountSql;
  bool? _hitCount;
  dynamic _countId;
  dynamic _maxLimit;
  bool? _searchCount;
  num? _pages;
Obj copyWith({  List<Records>? records,
  num? total,
  num? size,
  num? current,
  List<dynamic>? orders,
  bool? optimizeCountSql,
  bool? hitCount,
  dynamic countId,
  dynamic maxLimit,
  bool? searchCount,
  num? pages,
}) => Obj(  records: records ?? _records,
  total: total ?? _total,
  size: size ?? _size,
  current: current ?? _current,
  orders: orders ?? _orders,
  optimizeCountSql: optimizeCountSql ?? _optimizeCountSql,
  hitCount: hitCount ?? _hitCount,
  countId: countId ?? _countId,
  maxLimit: maxLimit ?? _maxLimit,
  searchCount: searchCount ?? _searchCount,
  pages: pages ?? _pages,
);
  List<Records>? get records => _records;
  num? get total => _total;
  num? get size => _size;
  num? get current => _current;
  List<dynamic>? get orders => _orders;
  bool? get optimizeCountSql => _optimizeCountSql;
  bool? get hitCount => _hitCount;
  dynamic get countId => _countId;
  dynamic get maxLimit => _maxLimit;
  bool? get searchCount => _searchCount;
  num? get pages => _pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_records != null) {
      map['records'] = _records?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    map['size'] = _size;
    map['current'] = _current;
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    map['optimizeCountSql'] = _optimizeCountSql;
    map['hitCount'] = _hitCount;
    map['countId'] = _countId;
    map['maxLimit'] = _maxLimit;
    map['searchCount'] = _searchCount;
    map['pages'] = _pages;
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

class Records {
  Records({
      num? id,
      num? operationClassId,
      num? classId,
      num? operationId, 
      String? name, 
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
      num? classAccuracy,}){
    _operationClassId = operationClassId;
    _id = id;
    _classId = classId;
    _operationId = operationId;
    _name = name;
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
}

  Records.fromJson(dynamic json) {
    _operationClassId = json['operationClassId'];
    _id = json['id'];
    _classId = json['classId'];
    _operationId = json['operationId'];
    _name = json['name'];
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
  }
  num? _operationClassId;
  num? _id;
  num? _classId;
  num? _operationId;
  String? _name;
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
Records copyWith({
  num? id,
  num? operationClassId,
  num? classId,
  num? operationId,
  String? name,
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
}) => Records(
  id: id ?? _id,
  operationClassId: operationClassId ?? _operationClassId,
  classId: classId ?? _classId,
  operationId: operationId ?? _operationId,
  name: name ?? _name,
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
);
  num? get operationClassId => _operationClassId;
  num? get id => _id;
  num? get classId => _classId;
  num? get operationId => _operationId;
  String? get name => _name;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['operationClassId'] = _operationClassId;
    map['id'] = _id;
    map['classId'] = _classId;
    map['operationId'] = _operationId;
    map['name'] = _name;
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
    return map;
  }

}