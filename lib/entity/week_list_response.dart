/// code : 0
/// message : "系统正常"
/// obj : [{"id":1648136972349313025,"p":null,"name":"ceshi","affiliatedGrade":2,"schoolYear":2,"periodsNum":21,"coverImg":null,"status":false,"isDelete":false,"createTime":"2023-04-18T09:30:50","updateTime":null,"createUser":1,"updateUser":null}]
/// p : {"records":[],"total":1,"size":50,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}

class WeekListResponse {
  WeekListResponse({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      P? p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  WeekListResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'] != null ? P.fromJson(json['p']) : null;
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  P? _p;
WeekListResponse copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  P? p,
}) => WeekListResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
  P? get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    if (_p != null) {
      map['p'] = _p?.toJson();
    }
    return map;
  }

}

/// records : []
/// total : 1
/// size : 50
/// current : 1
/// orders : []
/// optimizeCountSql : true
/// hitCount : false
/// countId : null
/// maxLimit : null
/// searchCount : true
/// pages : 1

class P {
  P({
      List<dynamic>? records, 
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

  P.fromJson(dynamic json) {
    if (json['records'] != null) {
      _records = [];
      json['records'].forEach((v) {
        // _records?.add(Dynamic.fromJson(v));
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
  List<dynamic>? _records;
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
P copyWith({  List<dynamic>? records,
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
}) => P(  records: records ?? _records,
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
  List<dynamic>? get records => _records;
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

/// id : 1648136972349313025
/// p : null
/// name : "ceshi"
/// affiliatedGrade : 2
/// schoolYear : 2
/// periodsNum : 21
/// coverImg : null
/// status : false
/// isDelete : false
/// createTime : "2023-04-18T09:30:50"
/// updateTime : null
/// createUser : 1
/// updateUser : null

class Obj {
  Obj({
      num? id, 
      dynamic p, 
      String? name, 
      num? affiliatedGrade, 
      num? schoolYear, 
      num? periodsNum,
    String? coverImg,
      bool? status, 
      bool? isDelete, 
      String? createTime, 
      dynamic updateTime, 
      num? createUser, 
      dynamic updateUser,}){
    _id = id;
    _p = p;
    _name = name;
    _affiliatedGrade = affiliatedGrade;
    _schoolYear = schoolYear;
    _periodsNum = periodsNum;
    _coverImg = coverImg;
    _status = status;
    _isDelete = isDelete;
    _createTime = createTime;
    _updateTime = updateTime;
    _createUser = createUser;
    _updateUser = updateUser;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _p = json['p'];
    _name = json['name'];
    _affiliatedGrade = json['affiliatedGrade'];
    _schoolYear = json['schoolYear'];
    _periodsNum = json['periodsNum'];
    _coverImg = json['coverImg'];
    _status = json['status'];
    _isDelete = json['isDelete'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _createUser = json['createUser'];
    _updateUser = json['updateUser'];
  }
  num? _id;
  dynamic _p;
  String? _name;
  num? _affiliatedGrade;
  num? _schoolYear;
  num? _periodsNum;
  String? _coverImg;
  bool? _status;
  bool? _isDelete;
  String? _createTime;
  dynamic _updateTime;
  num? _createUser;
  dynamic _updateUser;
Obj copyWith({  num? id,
  dynamic p,
  String? name,
  num? affiliatedGrade,
  num? schoolYear,
  num? periodsNum,
  String? coverImg,
  bool? status,
  bool? isDelete,
  String? createTime,
  dynamic updateTime,
  num? createUser,
  dynamic updateUser,
}) => Obj(  id: id ?? _id,
  p: p ?? _p,
  name: name ?? _name,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
  schoolYear: schoolYear ?? _schoolYear,
  periodsNum: periodsNum ?? _periodsNum,
  coverImg: coverImg ?? _coverImg,
  status: status ?? _status,
  isDelete: isDelete ?? _isDelete,
  createTime: createTime ?? _createTime,
  updateTime: updateTime ?? _updateTime,
  createUser: createUser ?? _createUser,
  updateUser: updateUser ?? _updateUser,
);
  num? get id => _id;
  dynamic get p => _p;
  String? get name => _name;
  num? get affiliatedGrade => _affiliatedGrade;
  num? get schoolYear => _schoolYear;
  num? get periodsNum => _periodsNum;
  String? get coverImg => _coverImg;
  bool? get status => _status;
  bool? get isDelete => _isDelete;
  String? get createTime => _createTime;
  dynamic get updateTime => _updateTime;
  num? get createUser => _createUser;
  dynamic get updateUser => _updateUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['p'] = _p;
    map['name'] = _name;
    map['affiliatedGrade'] = _affiliatedGrade;
    map['schoolYear'] = _schoolYear;
    map['periodsNum'] = _periodsNum;
    map['coverImg'] = _coverImg;
    map['status'] = _status;
    map['isDelete'] = _isDelete;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['createUser'] = _createUser;
    map['updateUser'] = _updateUser;
    return map;
  }

}