/// code : 769
/// message : "success"
/// obj : {"journals":{"pages":710,"records":[{"id":"23","name":"ivonne.effertz","affiliatedGrade":610,"schoolYear":112,"periodsNum":651,"coverImg":"hf1zb7","status":true,"isDelete":true,"journalView":627,"createTime":"2023-05-17 13:50:34","updateTime":"2023-05-17 13:50:34","createUser":179,"updateUser":314}],"total":688,"size":12,"current":942,"orders":[{"column":"g3vsfn","asc":true}],"optimizeCountSql":true,"searchCount":true,"hitCount":true,"countId":"23","maxLimit":520},"students":{"pages":98,"records":[{"userId":668,"nickname":"otilia.nikolaus","actualname":"ivonne.effertz","avatar":"leurw1","studyTime":1684302634375,"effort":988,"accuracy":896,"score":896,"totalSize":10,"timeInfos":[{"classify":915,"time":1684302634375,"classifyName":"ivonne.effertz","icon":"nlec9z"}],"className":"ivonne.effertz","gradeId":848,"gradeName":"ivonne.effertz"}],"total":59,"size":47,"current":111,"orders":[{"column":"fiu7rv","asc":true}],"optimizeCountSql":true,"searchCount":true,"hitCount":true,"countId":"23","maxLimit":655}}
/// p : {}

class HomeSearchListDate {
  HomeSearchListDate({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  HomeSearchListDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
HomeSearchListDate copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => HomeSearchListDate(  code: code ?? _code,
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

/// journals : {"pages":710,"records":[{"id":"23","name":"ivonne.effertz","affiliatedGrade":610,"schoolYear":112,"periodsNum":651,"coverImg":"hf1zb7","status":true,"isDelete":true,"journalView":627,"createTime":"2023-05-17 13:50:34","updateTime":"2023-05-17 13:50:34","createUser":179,"updateUser":314}],"total":688,"size":12,"current":942,"orders":[{"column":"g3vsfn","asc":true}],"optimizeCountSql":true,"searchCount":true,"hitCount":true,"countId":"23","maxLimit":520}
/// students : {"pages":98,"records":[{"userId":668,"nickname":"otilia.nikolaus","actualname":"ivonne.effertz","avatar":"leurw1","studyTime":1684302634375,"effort":988,"accuracy":896,"score":896,"totalSize":10,"timeInfos":[{"classify":915,"time":1684302634375,"classifyName":"ivonne.effertz","icon":"nlec9z"}],"className":"ivonne.effertz","gradeId":848,"gradeName":"ivonne.effertz"}],"total":59,"size":47,"current":111,"orders":[{"column":"fiu7rv","asc":true}],"optimizeCountSql":true,"searchCount":true,"hitCount":true,"countId":"23","maxLimit":655}

class Obj {
  Obj({
      Journals? journals, 
      Students? students,}){
    _journals = journals;
    _students = students;
}

  Obj.fromJson(dynamic json) {
    _journals = json['journals'] != null ? Journals.fromJson(json['journals']) : null;
    _students = json['students'] != null ? Students.fromJson(json['students']) : null;
  }
  Journals? _journals;
  Students? _students;
Obj copyWith({  Journals? journals,
  Students? students,
}) => Obj(  journals: journals ?? _journals,
  students: students ?? _students,
);
  Journals? get journals => _journals;
  Students? get students => _students;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_journals != null) {
      map['journals'] = _journals?.toJson();
    }
    if (_students != null) {
      map['students'] = _students?.toJson();
    }
    return map;
  }

}

/// pages : 98
/// records : [{"userId":668,"nickname":"otilia.nikolaus","actualname":"ivonne.effertz","avatar":"leurw1","studyTime":1684302634375,"effort":988,"accuracy":896,"score":896,"totalSize":10,"timeInfos":[{"classify":915,"time":1684302634375,"classifyName":"ivonne.effertz","icon":"nlec9z"}],"className":"ivonne.effertz","gradeId":848,"gradeName":"ivonne.effertz"}]
/// total : 59
/// size : 47
/// current : 111
/// orders : [{"column":"fiu7rv","asc":true}]
/// optimizeCountSql : true
/// searchCount : true
/// hitCount : true
/// countId : "23"
/// maxLimit : 655

class Students {
  Students({
      num? pages, 
      List<RecordsS>? records,
      num? total, 
      num? size, 
      num? current, 
      List<OrdersJ>? orders,
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

  Students.fromJson(dynamic json) {
    _pages = json['pages'];
    if (json['records'] != null) {
      _records = [];
      json['records'].forEach((v) {
        _records?.add(RecordsS.fromJson(v));
      });
    }
    _total = json['total'];
    _size = json['size'];
    _current = json['current'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(OrdersJ.fromJson(v));
      });
    }
    _optimizeCountSql = json['optimizeCountSql'];
    _searchCount = json['searchCount'];
    _hitCount = json['hitCount'];
    _countId = json['countId'];
    _maxLimit = json['maxLimit'];
  }
  num? _pages;
  List<RecordsS>? _records;
  num? _total;
  num? _size;
  num? _current;
  List<OrdersJ>? _orders;
  bool? _optimizeCountSql;
  bool? _searchCount;
  bool? _hitCount;
  String? _countId;
  num? _maxLimit;
Students copyWith({  num? pages,
  List<RecordsS>? records,
  num? total,
  num? size,
  num? current,
  List<OrdersJ>? orders,
  bool? optimizeCountSql,
  bool? searchCount,
  bool? hitCount,
  String? countId,
  num? maxLimit,
}) => Students(  pages: pages ?? _pages,
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
  List<RecordsS>? get records => _records;
  num? get total => _total;
  num? get size => _size;
  num? get current => _current;
  List<OrdersJ>? get orders => _orders;
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

/// column : "fiu7rv"
/// asc : true

class OrdersJ {
  OrdersJ({
      String? column, 
      bool? asc,}){
    _column = column;
    _asc = asc;
}

  OrdersJ.fromJson(dynamic json) {
    _column = json['column'];
    _asc = json['asc'];
  }
  String? _column;
  bool? _asc;
  OrdersJ copyWith({  String? column,
  bool? asc,
}) => OrdersJ(  column: column ?? _column,
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

/// userId : 668
/// nickname : "otilia.nikolaus"
/// actualname : "ivonne.effertz"
/// avatar : "leurw1"
/// studyTime : 1684302634375
/// effort : 988
/// accuracy : 896
/// score : 896
/// totalSize : 10
/// timeInfos : [{"classify":915,"time":1684302634375,"classifyName":"ivonne.effertz","icon":"nlec9z"}]
/// className : "ivonne.effertz"
/// gradeId : 848
/// gradeName : "ivonne.effertz"

class RecordsS {
  RecordsS({
      num? userId, 
      String? nickname, 
      String? actualname, 
      String? avatar, 
      num? studyTime, 
      num? effort, 
      num? accuracy, 
      num? score, 
      num? totalSize, 
      List<TimeInfos>? timeInfos, 
      String? className, 
      num? gradeId, 
      String? gradeName,}){
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
    _gradeId = gradeId;
    _gradeName = gradeName;
}

  RecordsS.fromJson(dynamic json) {
    _userId = json['userId'];
    _nickname = json['nickname'];
    _actualname = json['actualname'];
    _avatar = json['avatar'];
    _studyTime = json['studyTime'];
    _effort = json['effort'];
    _accuracy = json['accuracy'];
    _score = json['score'];
    _totalSize = json['totalSize'];
    if (json['timeInfos'] != null) {
      _timeInfos = [];
      json['timeInfos'].forEach((v) {
        _timeInfos?.add(TimeInfos.fromJson(v));
      });
    }
    _className = json['className'];
    _gradeId = json['gradeId'];
    _gradeName = json['gradeName'];
  }
  num? _userId;
  String? _nickname;
  String? _actualname;
  String? _avatar;
  num? _studyTime;
  num? _effort;
  num? _accuracy;
  num? _score;
  num? _totalSize;
  List<TimeInfos>? _timeInfos;
  String? _className;
  num? _gradeId;
  String? _gradeName;
  RecordsS copyWith({  num? userId,
  String? nickname,
  String? actualname,
  String? avatar,
  num? studyTime,
  num? effort,
  num? accuracy,
  num? score,
  num? totalSize,
  List<TimeInfos>? timeInfos,
  String? className,
  num? gradeId,
  String? gradeName,
}) => RecordsS(  userId: userId ?? _userId,
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
  gradeId: gradeId ?? _gradeId,
  gradeName: gradeName ?? _gradeName,
);
  num? get userId => _userId;
  String? get nickname => _nickname;
  String? get actualname => _actualname;
  String? get avatar => _avatar;
  num? get studyTime => _studyTime;
  num? get effort => _effort;
  num? get accuracy => _accuracy;
  num? get score => _score;
  num? get totalSize => _totalSize;
  List<TimeInfos>? get timeInfos => _timeInfos;
  String? get className => _className;
  num? get gradeId => _gradeId;
  String? get gradeName => _gradeName;

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
    if (_timeInfos != null) {
      map['timeInfos'] = _timeInfos?.map((v) => v.toJson()).toList();
    }
    map['className'] = _className;
    map['gradeId'] = _gradeId;
    map['gradeName'] = _gradeName;
    return map;
  }

}

/// classify : 915
/// time : 1684302634375
/// classifyName : "ivonne.effertz"
/// icon : "nlec9z"

class TimeInfos {
  TimeInfos({
      num? classify, 
      num? time, 
      String? classifyName, 
      String? icon,}){
    _classify = classify;
    _time = time;
    _classifyName = classifyName;
    _icon = icon;
}

  TimeInfos.fromJson(dynamic json) {
    _classify = json['classify'];
    _time = json['time'];
    _classifyName = json['classifyName'];
    _icon = json['icon'];
  }
  num? _classify;
  num? _time;
  String? _classifyName;
  String? _icon;
TimeInfos copyWith({  num? classify,
  num? time,
  String? classifyName,
  String? icon,
}) => TimeInfos(  classify: classify ?? _classify,
  time: time ?? _time,
  classifyName: classifyName ?? _classifyName,
  icon: icon ?? _icon,
);
  num? get classify => _classify;
  num? get time => _time;
  String? get classifyName => _classifyName;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classify'] = _classify;
    map['time'] = _time;
    map['classifyName'] = _classifyName;
    map['icon'] = _icon;
    return map;
  }

}

/// pages : 710
/// records : [{"id":"23","name":"ivonne.effertz","affiliatedGrade":610,"schoolYear":112,"periodsNum":651,"coverImg":"hf1zb7","status":true,"isDelete":true,"journalView":627,"createTime":"2023-05-17 13:50:34","updateTime":"2023-05-17 13:50:34","createUser":179,"updateUser":314}]
/// total : 688
/// size : 12
/// current : 942
/// orders : [{"column":"g3vsfn","asc":true}]
/// optimizeCountSql : true
/// searchCount : true
/// hitCount : true
/// countId : "23"
/// maxLimit : 520

class Journals {
  Journals({
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

  Journals.fromJson(dynamic json) {
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
Journals copyWith({  num? pages,
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
}) => Journals(  pages: pages ?? _pages,
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

/// column : "g3vsfn"
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

/// id : "23"
/// name : "ivonne.effertz"
/// affiliatedGrade : 610
/// schoolYear : 112
/// periodsNum : 651
/// coverImg : "hf1zb7"
/// status : true
/// isDelete : true
/// journalView : 627
/// createTime : "2023-05-17 13:50:34"
/// updateTime : "2023-05-17 13:50:34"
/// createUser : 179
/// updateUser : 314

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
      num? updateUser,}){
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
  num? _updateUser;
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
  num? updateUser,
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
  num? get updateUser => _updateUser;

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