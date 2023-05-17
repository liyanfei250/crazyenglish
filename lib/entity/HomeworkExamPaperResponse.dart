/// code : 0
/// message : "系统正常"
/// obj : {"records":[{"id":1657251162470559746,"p":null,"paperType":1,"name":"英语测试2","totalSize":0,"classifyIds":"","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T13:07:22","updateUser":1651539603655626753,"updateTime":"2023-05-13T13:07:22"},{"id":1657196730890399745,"p":null,"paperType":0,"name":"银河护卫队","totalSize":0,"classifyIds":"","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T09:31:05","updateUser":1651539603655626753,"updateTime":"2023-05-13T09:31:05"},{"id":1657194518248239106,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T09:22:17","updateUser":1651539603655626753,"updateTime":"2023-05-13T09:22:17"},{"id":1657167397186514945,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T07:34:31","updateUser":1651539603655626753,"updateTime":"2023-05-13T07:34:31"},{"id":1656836735057342466,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-12T09:40:35","updateUser":1651539603655626753,"updateTime":"2023-05-12T09:40:35"},{"id":1656225860639064065,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307,1646439861824098314,1646704435479547905,1646439861824098308,1654413392935489537,1646439861824098306","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T17:13:07","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:13:07"},{"id":1656224128395706369,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T17:05:39","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:05:39"},{"id":1656223808642940929,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T17:02:11","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:02:11"},{"id":1656209921323352066,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T16:09:51","updateUser":1651539603655626753,"updateTime":"2023-05-10T16:09:51"},{"id":1656205267453652994,"p":null,"paperType":1,"name":"英语测试","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T15:51:21","updateUser":1651539603655626753,"updateTime":"2023-05-10T15:51:21"}],"total":10,"size":10,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}
/// p : null
/// success : true

class HomeworkExamPaperResponse {
  HomeworkExamPaperResponse({
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

  HomeworkExamPaperResponse.fromJson(dynamic json) {
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
HomeworkExamPaperResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => HomeworkExamPaperResponse(  code: code ?? _code,
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

/// records : [{"id":1657251162470559746,"p":null,"paperType":1,"name":"英语测试2","totalSize":0,"classifyIds":"","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T13:07:22","updateUser":1651539603655626753,"updateTime":"2023-05-13T13:07:22"},{"id":1657196730890399745,"p":null,"paperType":0,"name":"银河护卫队","totalSize":0,"classifyIds":"","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T09:31:05","updateUser":1651539603655626753,"updateTime":"2023-05-13T09:31:05"},{"id":1657194518248239106,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T09:22:17","updateUser":1651539603655626753,"updateTime":"2023-05-13T09:22:17"},{"id":1657167397186514945,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-13T07:34:31","updateUser":1651539603655626753,"updateTime":"2023-05-13T07:34:31"},{"id":1656836735057342466,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-12T09:40:35","updateUser":1651539603655626753,"updateTime":"2023-05-12T09:40:35"},{"id":1656225860639064065,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307,1646439861824098314,1646704435479547905,1646439861824098308,1654413392935489537,1646439861824098306","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T17:13:07","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:13:07"},{"id":1656224128395706369,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T17:05:39","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:05:39"},{"id":1656223808642940929,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T17:02:11","updateUser":1651539603655626753,"updateTime":"2023-05-10T17:02:11"},{"id":1656209921323352066,"p":null,"paperType":1,"name":"英语测试2","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T16:09:51","updateUser":1651539603655626753,"updateTime":"2023-05-10T16:09:51"},{"id":1656205267453652994,"p":null,"paperType":1,"name":"英语测试","totalSize":1,"classifyIds":"1646439861824098307","isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-10T15:51:21","updateUser":1651539603655626753,"updateTime":"2023-05-10T15:51:21"}]
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

/// id : 1657251162470559746
/// p : null
/// paperType : 1
/// name : "英语测试2"
/// totalSize : 0
/// classifyIds : ""
/// isDelete : false
/// createUser : 1651539603655626753
/// createTime : "2023-05-13T13:07:22"
/// updateUser : 1651539603655626753
/// updateTime : "2023-05-13T13:07:22"

class Records {
  Records({
      num? id, 
      dynamic p, 
      num? paperType, 
      String? name, 
      num? totalSize, 
      String? classifyIds, 
      String? classifyNames,
      bool? isDelete,
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime,}){
    _id = id;
    _p = p;
    _paperType = paperType;
    _name = name;
    _totalSize = totalSize;
    _classifyIds = classifyIds;
    _classifyNames = classifyNames;
    _isDelete = isDelete;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
}

  Records.fromJson(dynamic json) {
    _id = json['id'];
    _p = json['p'];
    _paperType = json['paperType'];
    _name = json['name'];
    _totalSize = json['totalSize'];
    _classifyIds = json['classifyIds'];
    _classifyNames = json['classifyNames'];
    _isDelete = json['isDelete'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
  }
  num? _id;
  dynamic _p;
  num? _paperType;
  String? _name;
  num? _totalSize;
  String? _classifyIds;
  String? _classifyNames;
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
Records copyWith({  num? id,
  dynamic p,
  num? paperType,
  String? name,
  num? totalSize,
  String? classifyIds,
  String? classifyNames,
  bool? isDelete,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
}) => Records(  id: id ?? _id,
  p: p ?? _p,
  paperType: paperType ?? _paperType,
  name: name ?? _name,
  totalSize: totalSize ?? _totalSize,
  classifyIds: classifyIds ?? _classifyIds,
  classifyNames: classifyNames ?? _classifyNames,
  isDelete: isDelete ?? _isDelete,
  createUser: createUser ?? _createUser,
  createTime: createTime ?? _createTime,
  updateUser: updateUser ?? _updateUser,
  updateTime: updateTime ?? _updateTime,
);
  num? get id => _id;
  dynamic get p => _p;
  num? get paperType => _paperType;
  String? get name => _name;
  num? get totalSize => _totalSize;
  String? get classifyIds => _classifyIds;
  String? get classifyNames => _classifyNames;
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['p'] = _p;
    map['paperType'] = _paperType;
    map['name'] = _name;
    map['totalSize'] = _totalSize;
    map['classifyIds'] = _classifyIds;
    map['classifyNames'] = _classifyNames;
    map['isDelete'] = _isDelete;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    return map;
  }

}