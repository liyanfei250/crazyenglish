/// code : 0
/// message : "系统正常"
/// obj : {"records":[{"id":1656205268053438465,"operationClassId":1656205267856306178,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试"},{"id":1656205268053438466,"operationClassId":1656205267856306178,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试"},{"id":1656209921923137537,"operationClassId":1656209921721810945,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656209921923137538,"operationClassId":1656209921721810945,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656223809351778306,"operationClassId":1656223809016233985,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656223809414692865,"operationClassId":1656223809016233985,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656224128861274114,"operationClassId":1656224128727056385,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656224128861274115,"operationClassId":1656224128727056385,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656225875004555266,"operationClassId":1656225874870337537,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656225875004555267,"operationClassId":1656225874870337537,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"}],"total":10,"size":10,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}
/// p : null
/// success : true

class StudentWorkListResponse {
  StudentWorkListResponse({
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

  StudentWorkListResponse.fromJson(dynamic json) {
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
StudentWorkListResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => StudentWorkListResponse(  code: code ?? _code,
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

/// records : [{"id":1656205268053438465,"operationClassId":1656205267856306178,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试"},{"id":1656205268053438466,"operationClassId":1656205267856306178,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试"},{"id":1656209921923137537,"operationClassId":1656209921721810945,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656209921923137538,"operationClassId":1656209921721810945,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656223809351778306,"operationClassId":1656223809016233985,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656223809414692865,"operationClassId":1656223809016233985,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656224128861274114,"operationClassId":1656224128727056385,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656224128861274115,"operationClassId":1656224128727056385,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656225875004555266,"operationClassId":1656225874870337537,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651531759961624578,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"},{"id":1656225875004555267,"operationClassId":1656225874870337537,"classId":1655395694170124290,"teacherId":1651539603655626753,"studentUserId":1651533076075499521,"operationStatus":1,"objectiveSize":0,"objectiveProperSize":0,"objectiveCompleteSize":0,"subjectiveSize":1,"subjectiveTotalScore":0,"subjectiveCompleteSize":0,"totalSize":1,"completeSize":0,"completeTime":null,"name":"英语测试2"}]
/// total : 10
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
/// name : "英语测试"

class Records {
  Records({
      num? id, 
      num? operationClassId, 
      num? classId, 
      num? teacherId, 
      num? operationId,
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
      String? name,}){
    _id = id;
    _operationClassId = operationClassId;
    _classId = classId;
    _teacherId = teacherId;
    _operationId = operationId;
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

  Records.fromJson(dynamic json) {
    _id = json['id'];
    _operationClassId = json['operationClassId'];
    _classId = json['classId'];
    _teacherId = json['teacherId'];
    _operationId = json['operationId'];
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
  num? _id;
  num? _operationClassId;
  num? _classId;
  num? _teacherId;
  num? _operationId;
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
Records copyWith({  num? id,
  num? operationClassId,
  num? classId,
  num? teacherId,
  num? operationId,
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
}) => Records(  id: id ?? _id,
  operationClassId: operationClassId ?? _operationClassId,
  classId: classId ?? _classId,
  teacherId: teacherId ?? _teacherId,
  operationId: operationId ?? _operationId,
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
  num? get id => _id;
  num? get operationClassId => _operationClassId;
  num? get classId => _classId;
  num? get teacherId => _teacherId;
  num? get operationId => _operationId;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['operationClassId'] = _operationClassId;
    map['classId'] = _classId;
    map['teacherId'] = _teacherId;
    map['operationId'] = _operationId;
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