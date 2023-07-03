/// code : 0
/// message : "系统正常"
/// obj : {"records":[{"id":1657167397245235202,"p":null,"operationId":1657167397081657346,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-13T07:34:31","updateUser":1651539603655626753,"updateTime":"2023-05-13T07:34:31"},{"id":1656836735124451330,"p":null,"operationId":1656836734969262082,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-12T09:40:35","updateUser":1651539603655626753,"updateTime":"2023-05-12T09:40:35"},{"id":1656225874870337537,"p":null,"operationId":1656225845350825986,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T17:13:07","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:13:07"},{"id":1656224128727056385,"p":null,"operationId":1656223958555754498,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T17:05:39","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:05:39"},{"id":1656223809016233985,"p":null,"operationId":1656223088527081473,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T17:02:11","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:02:11"},{"id":1656209921721810945,"p":null,"operationId":1656209920803258369,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":0,"studentCompleteSize":null,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T16:09:51","updateUser":1651539603655626753,"updateTime":"2023-05-10T16:09:51"},{"id":1656205267856306178,"p":null,"operationId":1656205266858061825,"operationStatus":1,"name":"英语测试","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":null,"accuracy":null,"score":null,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T15:51:21","updateUser":1651539603655626753,"updateTime":"2023-05-10T15:51:21"}],"total":7,"size":20,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}
/// p : null
/// success : true

class HomeworkHistoryResponse {
  HomeworkHistoryResponse({
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

  HomeworkHistoryResponse.fromJson(dynamic json) {
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
HomeworkHistoryResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => HomeworkHistoryResponse(  code: code ?? _code,
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

/// records : [{"id":1657167397245235202,"p":null,"operationId":1657167397081657346,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-13T07:34:31","updateUser":1651539603655626753,"updateTime":"2023-05-13T07:34:31"},{"id":1656836735124451330,"p":null,"operationId":1656836734969262082,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-12T09:40:35","updateUser":1651539603655626753,"updateTime":"2023-05-12T09:40:35"},{"id":1656225874870337537,"p":null,"operationId":1656225845350825986,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T17:13:07","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:13:07"},{"id":1656224128727056385,"p":null,"operationId":1656223958555754498,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T17:05:39","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:05:39"},{"id":1656223809016233985,"p":null,"operationId":1656223088527081473,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":0,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T17:02:11","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:02:11"},{"id":1656209921721810945,"p":null,"operationId":1656209920803258369,"operationStatus":1,"name":"英语测试2","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":0,"studentCompleteSize":null,"accuracy":0.000000,"score":0.000000,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T16:09:51","updateUser":1651539603655626753,"updateTime":"2023-05-10T16:09:51"},{"id":1656205267856306178,"p":null,"operationId":1656205266858061825,"operationStatus":1,"name":"英语测试","teacherId":1651539603655626753,"paperType":1,"deadline":"2023-05-15T15:37:19","classify_ids":null,"schoolClassId":1655395694170124290,"totalSize":1,"studentTotalSize":2,"studentCompleteSize":null,"accuracy":null,"score":null,"actionSize":null,"createUser":1651539603655626753,"createTime":"2023-05-10T15:51:21","updateUser":1651539603655626753,"updateTime":"2023-05-10T15:51:21"}]
/// total : 7
/// size : 20
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
      List<History>? records,
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
        _records?.add(History.fromJson(v));
      });
    }
    _total = json['total'];
    _size = json['size'];
    _current = json['current'];
    if (json['orders'] != null) {
    }
    _optimizeCountSql = json['optimizeCountSql'];
    _hitCount = json['hitCount'];
    _countId = json['countId'];
    _maxLimit = json['maxLimit'];
    _searchCount = json['searchCount'];
    _pages = json['pages'];
  }
  List<History>? _records;
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
Obj copyWith({  List<History>? records,
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
  List<History>? get records => _records;
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

/// id : 1657167397245235202
/// p : null
/// operationId : 1657167397081657346
/// operationStatus : 1
/// name : "英语测试2"
/// teacherId : 1651539603655626753
/// paperType : 1
/// deadline : "2023-05-15T15:37:19"
/// classify_ids : null
/// schoolClassId : 1655395694170124290
/// totalSize : 1
/// studentTotalSize : 2
/// studentCompleteSize : 0
/// accuracy : 0.000000
/// score : 0.000000
/// actionSize : null
/// createUser : 1651539603655626753
/// createTime : "2023-05-13T07:34:31"
/// updateUser : 1651539603655626753
/// updateTime : "2023-05-13T07:34:31"

class History {
  History({
      num? id, 
      dynamic p, 
      num? operationId, 
      num? operationStatus, 
      String? name, 
      num? teacherId, 
      num? paperType, 
      String? deadline, 
      dynamic classifyIds, 
      num? schoolClassId, 
      num? totalSize, 
      num? studentTotalSize, 
      num? studentCompleteSize, 
      num? accuracy, 
      num? score, 
      dynamic actionSize, 
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime,}){
    _id = id;
    _p = p;
    _operationId = operationId;
    _operationStatus = operationStatus;
    _name = name;
    _teacherId = teacherId;
    _paperType = paperType;
    _deadline = deadline;
    _classifyIds = classifyIds;
    _schoolClassId = schoolClassId;
    _totalSize = totalSize;
    _studentTotalSize = studentTotalSize;
    _studentCompleteSize = studentCompleteSize;
    _accuracy = accuracy;
    _score = score;
    _actionSize = actionSize;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
}

  History.fromJson(dynamic json) {
    _id = json['id'];
    _p = json['p'];
    _operationId = json['operationId'];
    _operationStatus = json['operationStatus'];
    _name = json['name'];
    _teacherId = json['teacherId'];
    _paperType = json['paperType'];
    _deadline = json['deadline'];
    _classifyIds = json['classify_ids'];
    _schoolClassId = json['schoolClassId'];
    _totalSize = json['totalSize'];
    _studentTotalSize = json['studentTotalSize'];
    _studentCompleteSize = json['studentCompleteSize'];
    _accuracy = json['accuracy'];
    _score = json['score'];
    _actionSize = json['actionSize'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
  }
  num? _id;
  dynamic _p;
  num? _operationId;
  num? _operationStatus;
  String? _name;
  num? _teacherId;
  num? _paperType;
  String? _deadline;
  dynamic _classifyIds;
  num? _schoolClassId;
  num? _totalSize;
  num? _studentTotalSize;
  num? _studentCompleteSize;
  num? _accuracy;
  num? _score;
  dynamic _actionSize;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
History copyWith({  num? id,
  dynamic p,
  num? operationId,
  num? operationStatus,
  String? name,
  num? teacherId,
  num? paperType,
  String? deadline,
  dynamic classifyIds,
  num? schoolClassId,
  num? totalSize,
  num? studentTotalSize,
  num? studentCompleteSize,
  num? accuracy,
  num? score,
  dynamic actionSize,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
}) => History(  id: id ?? _id,
  p: p ?? _p,
  operationId: operationId ?? _operationId,
  operationStatus: operationStatus ?? _operationStatus,
  name: name ?? _name,
  teacherId: teacherId ?? _teacherId,
  paperType: paperType ?? _paperType,
  deadline: deadline ?? _deadline,
  classifyIds: classifyIds ?? _classifyIds,
  schoolClassId: schoolClassId ?? _schoolClassId,
  totalSize: totalSize ?? _totalSize,
  studentTotalSize: studentTotalSize ?? _studentTotalSize,
  studentCompleteSize: studentCompleteSize ?? _studentCompleteSize,
  accuracy: accuracy ?? _accuracy,
  score: score ?? _score,
  actionSize: actionSize ?? _actionSize,
  createUser: createUser ?? _createUser,
  createTime: createTime ?? _createTime,
  updateUser: updateUser ?? _updateUser,
  updateTime: updateTime ?? _updateTime,
);
  num? get id => _id;
  dynamic get p => _p;
  num? get operationId => _operationId;
  num? get operationStatus => _operationStatus;
  String? get name => _name;
  num? get teacherId => _teacherId;
  num? get paperType => _paperType;
  String? get deadline => _deadline;
  dynamic get classifyIds => _classifyIds;
  num? get schoolClassId => _schoolClassId;
  num? get totalSize => _totalSize;
  num? get studentTotalSize => _studentTotalSize;
  num? get studentCompleteSize => _studentCompleteSize;
  num? get accuracy => _accuracy;
  num? get score => _score;
  dynamic get actionSize => _actionSize;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['p'] = _p;
    map['operationId'] = _operationId;
    map['operationStatus'] = _operationStatus;
    map['name'] = _name;
    map['teacherId'] = _teacherId;
    map['paperType'] = _paperType;
    map['deadline'] = _deadline;
    map['classify_ids'] = _classifyIds;
    map['schoolClassId'] = _schoolClassId;
    map['totalSize'] = _totalSize;
    map['studentTotalSize'] = _studentTotalSize;
    map['studentCompleteSize'] = _studentCompleteSize;
    map['accuracy'] = _accuracy;
    map['score'] = _score;
    map['actionSize'] = _actionSize;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    return map;
  }

}