/// code : 0
/// message : "系统正常"
/// obj : {"records":[{"id":"1647898280209838082","name":"ceshi","affiliatedGrade":1648226541879005200,"schoolYear":1649939393790709800,"periodsNum":1648230619078037500,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-04-17 17:42:18","updateTime":"2023-05-08 16:02:55","createUser":1,"updateUser":null},{"id":"1654410864692924417","name":"杨晋鑫的测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-05 17:01:02","updateTime":"2023-05-08 16:02:30","createUser":1,"updateUser":null},{"id":"1655379248834252802","name":"zah","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1648230619078037500,"coverImg":null,"status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-08 09:09:03","updateTime":null,"createUser":1,"updateUser":null},{"id":"1655383689352286210","name":"专项测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":null,"status":false,"isDelete":true,"journalView":0,"createTime":"2023-05-08 09:26:41","updateTime":"2023-05-08 17:18:48","createUser":1,"updateUser":1},{"id":"1655411551409115138","name":"专项测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1648230619078037500,"coverImg":"","status":false,"isDelete":true,"journalView":0,"createTime":"2023-05-08 11:17:24","updateTime":"2023-05-09 14:14:10","createUser":1,"updateUser":1},{"id":"1655411657986379777","name":"ceshi1","affiliatedGrade":1648226681310253000,"schoolYear":1648230558206103600,"periodsNum":1654400779413459000,"coverImg":"","status":false,"isDelete":true,"journalView":0,"createTime":"2023-05-08 11:17:49","updateTime":"2023-05-08 11:18:44","createUser":1,"updateUser":1},{"id":"1655818478972121090","name":"七年级新目标","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1655818586346303500,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-09 14:14:23","updateTime":"2023-05-09 19:01:19","createUser":1,"updateUser":null},{"id":"1656135961104953345","name":"武潇帅测试题库","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-10 11:15:57","updateTime":null,"createUser":1,"updateUser":null},{"id":"1656196921295450114","name":"全新测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-10 15:18:11","updateTime":null,"createUser":1,"updateUser":null}],"total":9,"size":10,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}
/// p : null
/// success : true

class TeacherWeekListResponse {
  TeacherWeekListResponse({
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

  TeacherWeekListResponse.fromJson(dynamic json) {
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
TeacherWeekListResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => TeacherWeekListResponse(  code: code ?? _code,
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

/// records : [{"id":"1647898280209838082","name":"ceshi","affiliatedGrade":1648226541879005200,"schoolYear":1649939393790709800,"periodsNum":1648230619078037500,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-04-17 17:42:18","updateTime":"2023-05-08 16:02:55","createUser":1,"updateUser":null},{"id":"1654410864692924417","name":"杨晋鑫的测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-05 17:01:02","updateTime":"2023-05-08 16:02:30","createUser":1,"updateUser":null},{"id":"1655379248834252802","name":"zah","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1648230619078037500,"coverImg":null,"status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-08 09:09:03","updateTime":null,"createUser":1,"updateUser":null},{"id":"1655383689352286210","name":"专项测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":null,"status":false,"isDelete":true,"journalView":0,"createTime":"2023-05-08 09:26:41","updateTime":"2023-05-08 17:18:48","createUser":1,"updateUser":1},{"id":"1655411551409115138","name":"专项测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1648230619078037500,"coverImg":"","status":false,"isDelete":true,"journalView":0,"createTime":"2023-05-08 11:17:24","updateTime":"2023-05-09 14:14:10","createUser":1,"updateUser":1},{"id":"1655411657986379777","name":"ceshi1","affiliatedGrade":1648226681310253000,"schoolYear":1648230558206103600,"periodsNum":1654400779413459000,"coverImg":"","status":false,"isDelete":true,"journalView":0,"createTime":"2023-05-08 11:17:49","updateTime":"2023-05-08 11:18:44","createUser":1,"updateUser":1},{"id":"1655818478972121090","name":"七年级新目标","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1655818586346303500,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-09 14:14:23","updateTime":"2023-05-09 19:01:19","createUser":1,"updateUser":null},{"id":"1656135961104953345","name":"武潇帅测试题库","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-10 11:15:57","updateTime":null,"createUser":1,"updateUser":null},{"id":"1656196921295450114","name":"全新测试数据","affiliatedGrade":1648226541879005200,"schoolYear":1648230558206103600,"periodsNum":1654400716477927400,"coverImg":"","status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-10 15:18:11","updateTime":null,"createUser":1,"updateUser":null}]
/// total : 9
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

/// id : "1647898280209838082"
/// name : "ceshi"
/// affiliatedGrade : 1648226541879005200
/// schoolYear : 1649939393790709800
/// periodsNum : 1648230619078037500
/// coverImg : ""
/// status : false
/// isDelete : false
/// journalView : 0
/// createTime : "2023-04-17 17:42:18"
/// updateTime : "2023-05-08 16:02:55"
/// createUser : 1
/// updateUser : null

class Records {
  Records({
      String? id, 
      String? name, 
      num? affiliatedGrade, 
      num? schoolYear, 
      num? periodsNum, 
      String? coverImg, 
      bool? status, 
      bool? isDelete, 
      num? journalView, 
      String? createTime, 
      String? updateTime, 
      num? createUser, 
      dynamic updateUser,}){
    _id = id;
    _name = name;
    _affiliatedGrade = affiliatedGrade;
    _schoolYear = schoolYear;
    _periodsNum = periodsNum;
    _coverImg = coverImg;
    _status = status;
    _isDelete = isDelete;
    _journalView = journalView;
    _createTime = createTime;
    _updateTime = updateTime;
    _createUser = createUser;
    _updateUser = updateUser;
}

  Records.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _affiliatedGrade = json['affiliatedGrade'];
    _schoolYear = json['schoolYear'];
    _periodsNum = json['periodsNum'];
    _coverImg = json['coverImg'];
    _status = json['status'];
    _isDelete = json['isDelete'];
    _journalView = json['journalView'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _createUser = json['createUser'];
    _updateUser = json['updateUser'];
  }
  String? _id;
  String? _name;
  num? _affiliatedGrade;
  num? _schoolYear;
  num? _periodsNum;
  String? _coverImg;
  bool? _status;
  bool? _isDelete;
  num? _journalView;
  String? _createTime;
  String? _updateTime;
  num? _createUser;
  dynamic _updateUser;
Records copyWith({  String? id,
  String? name,
  num? affiliatedGrade,
  num? schoolYear,
  num? periodsNum,
  String? coverImg,
  bool? status,
  bool? isDelete,
  num? journalView,
  String? createTime,
  String? updateTime,
  num? createUser,
  dynamic updateUser,
}) => Records(  id: id ?? _id,
  name: name ?? _name,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
  schoolYear: schoolYear ?? _schoolYear,
  periodsNum: periodsNum ?? _periodsNum,
  coverImg: coverImg ?? _coverImg,
  status: status ?? _status,
  isDelete: isDelete ?? _isDelete,
  journalView: journalView ?? _journalView,
  createTime: createTime ?? _createTime,
  updateTime: updateTime ?? _updateTime,
  createUser: createUser ?? _createUser,
  updateUser: updateUser ?? _updateUser,
);
  String? get id => _id;
  String? get name => _name;
  num? get affiliatedGrade => _affiliatedGrade;
  num? get schoolYear => _schoolYear;
  num? get periodsNum => _periodsNum;
  String? get coverImg => _coverImg;
  bool? get status => _status;
  bool? get isDelete => _isDelete;
  num? get journalView => _journalView;
  String? get createTime => _createTime;
  String? get updateTime => _updateTime;
  num? get createUser => _createUser;
  dynamic get updateUser => _updateUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['affiliatedGrade'] = _affiliatedGrade;
    map['schoolYear'] = _schoolYear;
    map['periodsNum'] = _periodsNum;
    map['coverImg'] = _coverImg;
    map['status'] = _status;
    map['isDelete'] = _isDelete;
    map['journalView'] = _journalView;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['createUser'] = _createUser;
    map['updateUser'] = _updateUser;
    return map;
  }

}