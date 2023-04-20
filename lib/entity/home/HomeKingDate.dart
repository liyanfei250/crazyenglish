/// code : 0
/// message : "系统正常"
/// obj : [{"id":1646439861824098306,"name":"听力","value":1},{"id":1646439861824098307,"name":"阅读","value":2},{"id":1646439861824098308,"name":"写作","value":3},{"id":1646439861824098309,"name":"口语","value":4},{"id":1646439861824098310,"name":"词汇","value":5},{"id":1646439861824098311,"name":" 短语","value":6},{"id":1646439861824098312,"name":"语法","value":7},{"id":1646439861824098313,"name":"句子","value":8},{"id":1646439861824098314,"name":"其它","value":9}]
/// p : null

class HomeKingDate {
  HomeKingDate({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  HomeKingDate.fromJson(dynamic json) {
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
HomeKingDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => HomeKingDate(  code: code ?? _code,
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

/// id : 1646439861824098306
/// name : "听力"
/// value : 1

class Obj {
  Obj({
      num? id, 
      String? name, 
      num? value,}){
    _id = id;
    _name = name;
    _value = value;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'];
  }
  num? _id;
  String? _name;
  num? _value;
Obj copyWith({  num? id,
  String? name,
  num? value,
}) => Obj(  id: id ?? _id,
  name: name ?? _name,
  value: value ?? _value,
);
  num? get id => _id;
  String? get name => _name;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value;
    return map;
  }

}