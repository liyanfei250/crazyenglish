/// code : 0
/// message : "系统正常"
/// obj : [{"id":1646434234670354434,"dictionaryId":null,"name":"数字英语","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/weekly.png","sort":1,"type":"weekly_type","isDelete":false,"createTime":"2023-04-25 17:33:10","updateTime":null,"createUser":1,"updateUser":null},{"id":1646434234670354436,"dictionaryId":1646439861824098306,"name":"综合听力","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/hearing.png","sort":2,"type":"lable_type","isDelete":false,"createTime":"2023-04-25 17:34:17","updateTime":null,"createUser":1,"updateUser":null},{"id":1646434234670354437,"dictionaryId":1646439861824098307,"name":"阅读理解","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/reading.png","sort":3,"type":"lable_type","isDelete":false,"createTime":"2023-04-25 17:34:21","updateTime":null,"createUser":1,"updateUser":null},{"id":1646434234670354438,"dictionaryId":1646439861824098308,"name":"写作训练","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/writing.png","sort":4,"type":"lable_type","isDelete":false,"createTime":"2023-04-25 17:34:27","updateTime":null,"createUser":1,"updateUser":null},{"id":1646434234670354435,"dictionaryId":null,"name":"商城","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/shopping.png","sort":6,"type":"shopping_type","isDelete":false,"createTime":"2023-04-25 17:33:24","updateTime":null,"createUser":1,"updateUser":null}]
/// p : null

class HomeKingNewDate {
  HomeKingNewDate({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  HomeKingNewDate.fromJson(dynamic json) {
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
HomeKingNewDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => HomeKingNewDate(  code: code ?? _code,
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

/// id : 1646434234670354434
/// dictionaryId : null
/// name : "数字英语"
/// icon : "http://cdn-files-test.crazyenglishweekly.com/diamond/weekly.png"
/// sort : 1
/// type : "weekly_type"
/// isDelete : false
/// createTime : "2023-04-25 17:33:10"
/// updateTime : null
/// createUser : 1
/// updateUser : null

class Obj {
  Obj({
      num? id,
      num? dictionaryId,
      String? name, 
      String? icon, 
      num? sort, 
      String? type, 
      bool? isDelete, 
      String? createTime, 
      dynamic updateTime, 
      num? createUser, 
      dynamic updateUser,}){
    _id = id;
    _dictionaryId = dictionaryId;
    _name = name;
    _icon = icon;
    _sort = sort;
    _type = type;
    _isDelete = isDelete;
    _createTime = createTime;
    _updateTime = updateTime;
    _createUser = createUser;
    _updateUser = updateUser;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _dictionaryId = json['dictionaryId'];
    _name = json['name'];
    _icon = json['icon'];
    _sort = json['sort'];
    _type = json['type'];
    _isDelete = json['isDelete'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _createUser = json['createUser'];
    _updateUser = json['updateUser'];
  }
  num? _id;
  num? _dictionaryId;
  String? _name;
  String? _icon;
  num? _sort;
  String? _type;
  bool? _isDelete;
  String? _createTime;
  dynamic _updateTime;
  num? _createUser;
  dynamic _updateUser;
Obj copyWith({  num? id,
  dynamic dictionaryId,
  String? name,
  String? icon,
  num? sort,
  String? type,
  bool? isDelete,
  String? createTime,
  dynamic updateTime,
  num? createUser,
  dynamic updateUser,
}) => Obj(  id: id ?? _id,
  dictionaryId: dictionaryId ?? _dictionaryId,
  name: name ?? _name,
  icon: icon ?? _icon,
  sort: sort ?? _sort,
  type: type ?? _type,
  isDelete: isDelete ?? _isDelete,
  createTime: createTime ?? _createTime,
  updateTime: updateTime ?? _updateTime,
  createUser: createUser ?? _createUser,
  updateUser: updateUser ?? _updateUser,
);
  num? get id => _id;
  num? get dictionaryId => _dictionaryId;
  String? get name => _name;
  String? get icon => _icon;
  num? get sort => _sort;
  String? get type => _type;
  bool? get isDelete => _isDelete;
  String? get createTime => _createTime;
  dynamic get updateTime => _updateTime;
  num? get createUser => _createUser;
  dynamic get updateUser => _updateUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['dictionaryId'] = _dictionaryId;
    map['name'] = _name;
    map['icon'] = _icon;
    map['sort'] = _sort;
    map['type'] = _type;
    map['isDelete'] = _isDelete;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['createUser'] = _createUser;
    map['updateUser'] = _updateUser;
    return map;
  }

}