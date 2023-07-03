/// code : 0
/// message : "系统正常"
/// obj : {"records":[{"userId":1651531759961624578,"nickname":"太阳","actualname":"张三","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","studyTime":100,"effort":96.000000,"accuracy":null,"score":null,"totalSize":20,"timeInfos":null,"className":null},{"userId":1651533076075499521,"nickname":"月亮","actualname":"李四","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","studyTime":20,"effort":76.000000,"accuracy":null,"score":null,"totalSize":30,"timeInfos":null,"className":null}],"total":2,"size":10,"current":1,"orders":[],"optimizeCountSql":true,"hitCount":false,"countId":null,"maxLimit":null,"searchCount":true,"pages":1}
/// p : null
/// success : true

class ClassBottomInfo {
  ClassBottomInfo({
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

  ClassBottomInfo.fromJson(dynamic json) {
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
ClassBottomInfo copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => ClassBottomInfo(  code: code ?? _code,
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

/// records : [{"userId":1651531759961624578,"nickname":"太阳","actualname":"张三","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","studyTime":100,"effort":96.000000,"accuracy":null,"score":null,"totalSize":20,"timeInfos":null,"className":null},{"userId":1651533076075499521,"nickname":"月亮","actualname":"李四","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","studyTime":20,"effort":76.000000,"accuracy":null,"score":null,"totalSize":30,"timeInfos":null,"className":null}]
/// total : 2
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

/// userId : 1651531759961624578
/// nickname : "太阳"
/// actualname : "张三"
/// avatar : "https://questions-test.jfwedu.com.cn/img%2Fuser.png"
/// studyTime : 100
/// effort : 96.000000
/// accuracy : null
/// score : null
/// totalSize : 20
/// timeInfos : null
/// className : null

class Records {
  Records({
      num? userId, 
      String? nickname, 
      String? actualname, 
      String? avatar, 
      num? studyTime, 
      num? effort, 
      dynamic accuracy, 
      dynamic score, 
      num? totalSize, 
      dynamic timeInfos, 
      dynamic className,}){
    _userId = userId;
    _nickname = nickname;
    _actualname = actualname;
    _avatar = avatar;
    _studyTime = studyTime;
    _effort = effort;
    _accuracy = accuracy;
    _score = score;
    _totalSize = totalSize;
    _timeInfos = timeInfos;
    _className = className;
}

  Records.fromJson(dynamic json) {
    _userId = json['userId'];
    _nickname = json['nickname'];
    _actualname = json['actualname'];
    _avatar = json['avatar'];
    _studyTime = json['studyTime'];
    _effort = json['effort'];
    _accuracy = json['accuracy'];
    _score = json['score'];
    _totalSize = json['totalSize'];
    _timeInfos = json['timeInfos'];
    _className = json['className'];
  }
  num? _userId;
  String? _nickname;
  String? _actualname;
  String? _avatar;
  num? _studyTime;
  num? _effort;
  dynamic _accuracy;
  dynamic _score;
  num? _totalSize;
  dynamic _timeInfos;
  dynamic _className;
Records copyWith({  num? userId,
  String? nickname,
  String? actualname,
  String? avatar,
  num? studyTime,
  num? effort,
  dynamic accuracy,
  dynamic score,
  num? totalSize,
  dynamic timeInfos,
  dynamic className,
}) => Records(  userId: userId ?? _userId,
  nickname: nickname ?? _nickname,
  actualname: actualname ?? _actualname,
  avatar: avatar ?? _avatar,
  studyTime: studyTime ?? _studyTime,
  effort: effort ?? _effort,
  accuracy: accuracy ?? _accuracy,
  score: score ?? _score,
  totalSize: totalSize ?? _totalSize,
  timeInfos: timeInfos ?? _timeInfos,
  className: className ?? _className,
);
  num? get userId => _userId;
  String? get nickname => _nickname;
  String? get actualname => _actualname;
  String? get avatar => _avatar;
  num? get studyTime => _studyTime;
  num? get effort => _effort;
  dynamic get accuracy => _accuracy;
  dynamic get score => _score;
  num? get totalSize => _totalSize;
  dynamic get timeInfos => _timeInfos;
  dynamic get className => _className;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['nickname'] = _nickname;
    map['actualname'] = _actualname;
    map['avatar'] = _avatar;
    map['studyTime'] = _studyTime;
    map['effort'] = _effort;
    map['accuracy'] = _accuracy;
    map['score'] = _score;
    map['totalSize'] = _totalSize;
    map['timeInfos'] = _timeInfos;
    map['className'] = _className;
    return map;
  }

}