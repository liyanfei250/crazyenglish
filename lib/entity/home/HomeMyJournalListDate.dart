/// code : 0
/// message : "系统正常"
/// obj : [{"id":1651555796096487426,"p":null,"name":"测试","affiliatedGrade":1648226541879005185,"schoolYear":1648230558206103554,"periodsNum":1648230619078037506,"coverImg":null,"status":false,"isDelete":true,"journalView":0,"createTime":"2023-04-27 19:56:00","updateTime":"2023-05-04 16:45:49","createUser":1,"updateUser":1},{"id":1650019538526375938,"p":null,"name":"测试2","affiliatedGrade":1648226541879005185,"schoolYear":1649939393790709761,"periodsNum":1648230619078037506,"coverImg":null,"status":false,"isDelete":true,"journalView":0,"createTime":"2023-04-23 14:11:28","updateTime":"2023-05-04 16:46:01","createUser":1,"updateUser":1},{"id":1647898280209838082,"p":null,"name":"ceshi","affiliatedGrade":1648226541879005185,"schoolYear":1,"periodsNum":1,"coverImg":null,"status":false,"isDelete":false,"journalView":0,"createTime":"2023-04-17 17:42:18","updateTime":null,"createUser":1,"updateUser":null},{"id":1654405472558616577,"p":null,"name":"杨晋鑫的测试数据","affiliatedGrade":1648226541879005185,"schoolYear":1648230558206103554,"periodsNum":1654400716477927425,"coverImg":null,"status":false,"isDelete":true,"journalView":0,"createTime":"2023-05-05 16:39:36","updateTime":"2023-05-05 17:00:47","createUser":1,"updateUser":1},{"id":1654357862179246081,"p":null,"name":"写作期刊","affiliatedGrade":1648226541879005185,"schoolYear":1648230558206103554,"periodsNum":1648230619078037506,"coverImg":null,"status":false,"isDelete":false,"journalView":0,"createTime":"2023-05-05 13:30:25","updateTime":null,"createUser":1,"updateUser":null}]
/// p : null

class HomeMyJournalListDate {
  HomeMyJournalListDate({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  HomeMyJournalListDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
HomeMyJournalListDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => HomeMyJournalListDate(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    map['p'] = _p;
    return map;
  }

}

/// id : 1651555796096487426
/// p : null
/// name : "测试"
/// affiliatedGrade : 1648226541879005185
/// schoolYear : 1648230558206103554
/// periodsNum : 1648230619078037506
/// coverImg : null
/// status : false
/// isDelete : true
/// journalView : 0
/// createTime : "2023-04-27 19:56:00"
/// updateTime : "2023-05-04 16:45:49"
/// createUser : 1
/// updateUser : 1

class Obj {
  Obj({
      num? id, 
      dynamic p, 
      String? name, 
      num? affiliatedGrade, 
      num? schoolYear, 
      num? periodsNum, 
      dynamic coverImg, 
      bool? status, 
      bool? isDelete, 
      num? journalView, 
      String? createTime, 
      String? updateTime, 
      num? createUser, 
      num? updateUser,}){
    _id = id;
    _p = p;
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
    _journalView = json['journalView'];
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
  dynamic _coverImg;
  bool? _status;
  bool? _isDelete;
  num? _journalView;
  String? _createTime;
  String? _updateTime;
  num? _createUser;
  num? _updateUser;
Obj copyWith({  num? id,
  dynamic p,
  String? name,
  num? affiliatedGrade,
  num? schoolYear,
  num? periodsNum,
  dynamic coverImg,
  bool? status,
  bool? isDelete,
  num? journalView,
  String? createTime,
  String? updateTime,
  num? createUser,
  num? updateUser,
}) => Obj(  id: id ?? _id,
  p: p ?? _p,
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
  num? get id => _id;
  dynamic get p => _p;
  String? get name => _name;
  num? get affiliatedGrade => _affiliatedGrade;
  num? get schoolYear => _schoolYear;
  num? get periodsNum => _periodsNum;
  dynamic get coverImg => _coverImg;
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
    map['p'] = _p;
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