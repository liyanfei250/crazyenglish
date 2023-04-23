/// code : 0
/// message : "系统正常"
/// obj : [{"id":1648128208754835458,"pid":0,"name":"测试01-01","type":null,"isNode":true,"status":null,"children":[{"id":1648128423083769857,"pid":1648128208754835458,"name":"测试06","type":null,"isNode":false,"status":null,"children":[]},{"id":1648129878981246978,"pid":1648128208754835458,"name":"测试06","type":null,"isNode":false,"status":null,"children":[]},{"id":1648138028814798850,"pid":1648128208754835458,"name":"测试01-03","type":null,"isNode":false,"status":null,"children":[]}]},{"id":1648157808163745794,"pid":0,"name":"测试01-03","type":null,"isNode":false,"status":null,"children":[]},{"id":1648157810093125634,"pid":0,"name":"测试01-03","type":null,"isNode":true,"status":null,"children":[{"id":1648160805710041089,"pid":1648157810093125634,"name":"测试01-02-03","type":null,"isNode":false,"status":null,"children":[]},{"id":1648160805898784769,"pid":1648157810093125634,"name":"测试01-04","type":null,"isNode":false,"status":null,"children":[]}]},{"id":1648158333970034689,"pid":0,"name":"测试01-03","type":null,"isNode":false,"status":null,"children":[]},{"id":1648158335752613890,"pid":0,"name":"测试01-03","type":null,"isNode":true,"status":null,"children":[{"id":1648159425655091202,"pid":1648158335752613890,"name":"测试3","type":null,"isNode":false,"status":null,"children":[]},{"id":1648159430713421825,"pid":1648158335752613890,"name":"测试04","type":null,"isNode":false,"status":null,"children":[]}]}]
/// p : null

class WeekDirectoryResponse {
  WeekDirectoryResponse({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  WeekDirectoryResponse.fromJson(dynamic json) {
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
WeekDirectoryResponse copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => WeekDirectoryResponse(  code: code ?? _code,
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

/// id : 1648128208754835458
/// pid : 0
/// name : "测试01-01"
/// type : null
/// isNode : true
/// status : null
/// children : [{"id":1648128423083769857,"pid":1648128208754835458,"name":"测试06","type":null,"isNode":false,"status":null,"children":[]},{"id":1648129878981246978,"pid":1648128208754835458,"name":"测试06","type":null,"isNode":false,"status":null,"children":[]},{"id":1648138028814798850,"pid":1648128208754835458,"name":"测试01-03","type":null,"isNode":false,"status":null,"children":[]}]

class Obj {
  Obj({
      num? id, 
      num? pid, 
      String? name, 
      dynamic type, 
      bool? isNode, 
      dynamic status, 
      List<Children>? children,}){
    _id = id;
    _pid = pid;
    _name = name;
    _type = type;
    _isNode = isNode;
    _status = status;
    _children = children;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _pid = json['pid'];
    _name = json['name'];
    _type = json['type'];
    _isNode = json['isNode'];
    _status = json['status'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(Children.fromJson(v));
      });
    }
  }
  num? _id;
  num? _pid;
  String? _name;
  dynamic _type;
  bool? _isNode;
  dynamic _status;
  List<Children>? _children;
Obj copyWith({  num? id,
  num? pid,
  String? name,
  dynamic type,
  bool? isNode,
  dynamic status,
  List<Children>? children,
}) => Obj(  id: id ?? _id,
  pid: pid ?? _pid,
  name: name ?? _name,
  type: type ?? _type,
  isNode: isNode ?? _isNode,
  status: status ?? _status,
  children: children ?? _children,
);
  num? get id => _id;
  num? get pid => _pid;
  String? get name => _name;
  dynamic get type => _type;
  bool? get isNode => _isNode;
  dynamic get status => _status;
  List<Children>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pid'] = _pid;
    map['name'] = _name;
    map['type'] = _type;
    map['isNode'] = _isNode;
    map['status'] = _status;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1648128423083769857
/// pid : 1648128208754835458
/// name : "测试06"
/// type : null
/// isNode : false
/// status : null
/// children : []

class Children {
  Children({
      num? id, 
      num? pid, 
      String? name, 
      dynamic type, 
      bool? isNode, 
      dynamic status, 
      List<dynamic>? children,}){
    _id = id;
    _pid = pid;
    _name = name;
    _type = type;
    _isNode = isNode;
    _status = status;
    _children = children;
}

  Children.fromJson(dynamic json) {
    _id = json['id'];
    _pid = json['pid'];
    _name = json['name'];
    _type = json['type'];
    _isNode = json['isNode'];
    _status = json['status'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        // _children?.add(Dynamic.fromJson(v));
      });
    }
  }
  num? _id;
  num? _pid;
  String? _name;
  dynamic _type;
  bool? _isNode;
  dynamic _status;
  List<dynamic>? _children;
Children copyWith({  num? id,
  num? pid,
  String? name,
  dynamic type,
  bool? isNode,
  dynamic status,
  List<dynamic>? children,
}) => Children(  id: id ?? _id,
  pid: pid ?? _pid,
  name: name ?? _name,
  type: type ?? _type,
  isNode: isNode ?? _isNode,
  status: status ?? _status,
  children: children ?? _children,
);
  num? get id => _id;
  num? get pid => _pid;
  String? get name => _name;
  dynamic get type => _type;
  bool? get isNode => _isNode;
  dynamic get status => _status;
  List<dynamic>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pid'] = _pid;
    map['name'] = _name;
    map['type'] = _type;
    map['isNode'] = _isNode;
    map['status'] = _status;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}