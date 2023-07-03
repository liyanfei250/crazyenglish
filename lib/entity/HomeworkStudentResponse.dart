/// code : 976
/// message : "success"
/// obj : {"pages":838,"records":[{"id":944,"operationClassId":657,"classId":924,"operationId":150,"name":"hillary.monahan","teacherId":217,"studentUserId":584,"deadline":"2023-05-19 10:36:48","operationStatus":79,"studentStatus":349,"objectiveSize":10,"objectiveProperSize":10,"objectiveCompleteSize":10,"subjectiveSize":10,"subjectiveTotalScore":493,"subjectiveCompleteSize":10,"totalSize":10,"completeSize":10,"completeTime":"2023-05-19 10:36:48","classRanking":374,"isDelete":true,"createUser":577,"createTime":"2023-05-19 10:36:48","updateUser":306,"updateTime":"2023-05-19 10:36:48","studentName":"hillary.monahan","avatar":"bw63op","className":"hillary.monahan","gradeId":539,"gradeName":"hillary.monahan","classOperationStatus":904,"classAccuracy":37}],"total":815,"size":290,"current":805,"orders":[{"column":"nd8bct","asc":true}],"optimizeCountSql":true,"searchCount":true,"hitCount":true,"countId":"166","maxLimit":494}
/// p : {}

class HomeworkStudentResponse {
  HomeworkStudentResponse({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  HomeworkStudentResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
HomeworkStudentResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => HomeworkStudentResponse(  code: code ?? _code,
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

/// pages : 838
/// records : [{"id":944,"operationClassId":657,"classId":924,"operationId":150,"name":"hillary.monahan","teacherId":217,"studentUserId":584,"deadline":"2023-05-19 10:36:48","operationStatus":79,"studentStatus":349,"objectiveSize":10,"objectiveProperSize":10,"objectiveCompleteSize":10,"subjectiveSize":10,"subjectiveTotalScore":493,"subjectiveCompleteSize":10,"totalSize":10,"completeSize":10,"completeTime":"2023-05-19 10:36:48","classRanking":374,"isDelete":true,"createUser":577,"createTime":"2023-05-19 10:36:48","updateUser":306,"updateTime":"2023-05-19 10:36:48","studentName":"hillary.monahan","avatar":"bw63op","className":"hillary.monahan","gradeId":539,"gradeName":"hillary.monahan","classOperationStatus":904,"classAccuracy":37}]
/// total : 815
/// size : 290
/// current : 805
/// orders : [{"column":"nd8bct","asc":true}]
/// optimizeCountSql : true
/// searchCount : true
/// hitCount : true
/// countId : "166"
/// maxLimit : 494

class Obj {
  Obj({
      num? pages, 
      List<Records>? records, 
      num? total, 
      num? size, 
      num? current, 
      List<Orders>? orders, 
      bool? optimizeCountSql, 
      bool? searchCount, 
      bool? hitCount, 
      String? countId, 
      num? maxLimit,}){
    _pages = pages;
    _records = records;
    _total = total;
    _size = size;
    _current = current;
    _orders = orders;
    _optimizeCountSql = optimizeCountSql;
    _searchCount = searchCount;
    _hitCount = hitCount;
    _countId = countId;
    _maxLimit = maxLimit;
}

  Obj.fromJson(dynamic json) {
    _pages = json['pages'];
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
        _orders?.add(Orders.fromJson(v));
      });
    }
    _optimizeCountSql = json['optimizeCountSql'];
    _searchCount = json['searchCount'];
    _hitCount = json['hitCount'];
    _countId = json['countId'];
    _maxLimit = json['maxLimit'];
  }
  num? _pages;
  List<Records>? _records;
  num? _total;
  num? _size;
  num? _current;
  List<Orders>? _orders;
  bool? _optimizeCountSql;
  bool? _searchCount;
  bool? _hitCount;
  String? _countId;
  num? _maxLimit;
Obj copyWith({  num? pages,
  List<Records>? records,
  num? total,
  num? size,
  num? current,
  List<Orders>? orders,
  bool? optimizeCountSql,
  bool? searchCount,
  bool? hitCount,
  String? countId,
  num? maxLimit,
}) => Obj(  pages: pages ?? _pages,
  records: records ?? _records,
  total: total ?? _total,
  size: size ?? _size,
  current: current ?? _current,
  orders: orders ?? _orders,
  optimizeCountSql: optimizeCountSql ?? _optimizeCountSql,
  searchCount: searchCount ?? _searchCount,
  hitCount: hitCount ?? _hitCount,
  countId: countId ?? _countId,
  maxLimit: maxLimit ?? _maxLimit,
);
  num? get pages => _pages;
  List<Records>? get records => _records;
  num? get total => _total;
  num? get size => _size;
  num? get current => _current;
  List<Orders>? get orders => _orders;
  bool? get optimizeCountSql => _optimizeCountSql;
  bool? get searchCount => _searchCount;
  bool? get hitCount => _hitCount;
  String? get countId => _countId;
  num? get maxLimit => _maxLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pages'] = _pages;
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
    map['searchCount'] = _searchCount;
    map['hitCount'] = _hitCount;
    map['countId'] = _countId;
    map['maxLimit'] = _maxLimit;
    return map;
  }

}

/// column : "nd8bct"
/// asc : true

class Orders {
  Orders({
      String? column, 
      bool? asc,}){
    _column = column;
    _asc = asc;
}

  Orders.fromJson(dynamic json) {
    _column = json['column'];
    _asc = json['asc'];
  }
  String? _column;
  bool? _asc;
Orders copyWith({  String? column,
  bool? asc,
}) => Orders(  column: column ?? _column,
  asc: asc ?? _asc,
);
  String? get column => _column;
  bool? get asc => _asc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['column'] = _column;
    map['asc'] = _asc;
    return map;
  }

}

/// id : 944
/// operationClassId : 657
/// classId : 924
/// operationId : 150
/// name : "hillary.monahan"
/// teacherId : 217
/// studentUserId : 584
/// deadline : "2023-05-19 10:36:48"
/// operationStatus : 79
/// studentStatus : 349
/// objectiveSize : 10
/// objectiveProperSize : 10
/// objectiveCompleteSize : 10
/// subjectiveSize : 10
/// subjectiveTotalScore : 493
/// subjectiveCompleteSize : 10
/// totalSize : 10
/// completeSize : 10
/// completeTime : "2023-05-19 10:36:48"
/// classRanking : 374
/// isDelete : true
/// createUser : 577
/// createTime : "2023-05-19 10:36:48"
/// updateUser : 306
/// updateTime : "2023-05-19 10:36:48"
/// studentName : "hillary.monahan"
/// avatar : "bw63op"
/// className : "hillary.monahan"
/// gradeId : 539
/// gradeName : "hillary.monahan"
/// classOperationStatus : 904
/// classAccuracy : 37

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
      String? completeTime, 
      num? classRanking, 
      bool? isDelete, 
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime, 
      String? studentName, 
      String? avatar, 
      String? className, 
      num? gradeId, 
      String? gradeName, 
      num? classOperationStatus, 
      num? classAccuracy,}){
    _id = id;
    _operationClassId = operationClassId;
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
    _id = json['id'];
    _operationClassId = json['operationClassId'];
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
  num? _id;
  num? _operationClassId;
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
  String? _completeTime;
  num? _classRanking;
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
  String? _studentName;
  String? _avatar;
  String? _className;
  num? _gradeId;
  String? _gradeName;
  num? _classOperationStatus;
  num? _classAccuracy;
Records copyWith({  num? id,
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
  String? completeTime,
  num? classRanking,
  bool? isDelete,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
  String? studentName,
  String? avatar,
  String? className,
  num? gradeId,
  String? gradeName,
  num? classOperationStatus,
  num? classAccuracy,
}) => Records(  id: id ?? _id,
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
  num? get id => _id;
  num? get operationClassId => _operationClassId;
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
  String? get completeTime => _completeTime;
  num? get classRanking => _classRanking;
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;
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
    map['operationClassId'] = _operationClassId;
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