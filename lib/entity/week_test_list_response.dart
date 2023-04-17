/// code : 0
/// msg : "String"
/// data : {"records":[{"id":0,"name":"String","nameTitle":"String","sort":0,"weekTime":"DateTime","img":"String","createTime":"DateTime"}],"total":0,"size":0,"current":0,"orders":[{"column":"String","asc":true}],"optimizeCountSql":true,"searchCount":true,"countId":"String","maxLimit":0}

class WeekTestListResponse {
  int? _code;
  String? _msg;
  Data? _data;

  int? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  WeekTestListResponse({
      int? code, 
      String? msg, 
      Data? data}){
    _code = code;
    _msg = msg;
    _data = data;
}

  WeekTestListResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['obj'] != null ? Data.fromJson(json['obj']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _msg;
    if (_data != null) {
      map['obj'] = _data?.toJson();
    }
    return map;
  }

}

/// records : [{"id":0,"name":"String","nameTitle":"String","sort":0,"weekTime":"DateTime","img":"String","createTime":"DateTime"}]
/// total : 0
/// size : 0
/// current : 0
/// orders : [{"column":"String","asc":true}]
/// optimizeCountSql : true
/// searchCount : true
/// countId : "String"
/// maxLimit : 0

class Data {
  List<Records>? _records;
  int? _total;
  int? _size;
  int? _current;
  List<Orders>? _orders;
  bool? _optimizeCountSql;
  bool? _searchCount;
  String? _countId;
  int? _maxLimit;

  List<Records>? get records => _records;
  int? get total => _total;
  int? get size => _size;
  int? get current => _current;
  List<Orders>? get orders => _orders;
  bool? get optimizeCountSql => _optimizeCountSql;
  bool? get searchCount => _searchCount;
  String? get countId => _countId;
  int? get maxLimit => _maxLimit;

  Data({
      List<Records>? records, 
      int? total, 
      int? size, 
      int? current, 
      List<Orders>? orders, 
      bool? optimizeCountSql, 
      bool? searchCount, 
      String? countId, 
      int? maxLimit}){
    _records = records;
    _total = total;
    _size = size;
    _current = current;
    _orders = orders;
    _optimizeCountSql = optimizeCountSql;
    _searchCount = searchCount;
    _countId = countId;
    _maxLimit = maxLimit;
}

  Data.fromJson(dynamic json) {
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
    _countId = json['countId'];
    _maxLimit = json['maxLimit'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
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
    map['countId'] = _countId;
    map['maxLimit'] = _maxLimit;
    return map;
  }

}

/// column : "String"
/// asc : true

class Orders {
  String? _column;
  bool? _asc;

  String? get column => _column;
  bool? get asc => _asc;

  Orders({
      String? column, 
      bool? asc}){
    _column = column;
    _asc = asc;
}

  Orders.fromJson(dynamic json) {
    _column = json['column'];
    _asc = json['asc'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['column'] = _column;
    map['asc'] = _asc;
    return map;
  }

}

/// id : 0
/// name : "String"
/// nameTitle : "String"
/// sort : 0
/// weekTime : "DateTime"
/// img : "String"
/// createTime : "DateTime"

class Records {
  int? _id;
  String? _name;
  String? _nameTitle;
  int? _sort;
  String? _weekTime;
  String? _img;
  String? _createTime;

  int? get id => _id;
  String? get name => _name;
  String? get nameTitle => _nameTitle;
  int? get sort => _sort;
  String? get weekTime => _weekTime;
  String? get img => _img;
  String? get createTime => _createTime;

  Records({
      int? id, 
      String? name, 
      String? nameTitle, 
      int? sort, 
      String? weekTime, 
      String? img, 
      String? createTime}){
    _id = id;
    _name = name;
    _nameTitle = nameTitle;
    _sort = sort;
    _weekTime = weekTime;
    _img = img;
    _createTime = createTime;
}

  Records.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nameTitle = json['nameTitle'];
    _sort = json['sort'];
    _weekTime = json['weekTime'];
    _img = json['img'];
    _createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['nameTitle'] = _nameTitle;
    map['sort'] = _sort;
    map['weekTime'] = _weekTime;
    map['img'] = _img;
    map['createTime'] = _createTime;
    return map;
  }

}