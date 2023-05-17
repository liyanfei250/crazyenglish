/// code : 0
/// message : "系统正常"
/// obj : {"id":1651531759961624578,"username":"zhangsan","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"太阳","actualname":"张三","phone":"13800001111","identity":2,"url":null,"affiliatedSchool":"sssssssss","affiliatedGrade":"1648226541879005185,1648226681310253058","affiliatedGradeName":null}
/// p : null

class UserInfoResponse {
  UserInfoResponse({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  UserInfoResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
UserInfoResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => UserInfoResponse(  code: code ?? _code,
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

/// id : 1651531759961624578
/// username : "zhangsan"
/// password : "e10adc3949ba59abbe56e057f20f883e"
/// nickname : "太阳"
/// actualname : "张三"
/// phone : "13800001111"
/// identity : 2
/// url : null
/// affiliatedSchool : "sssssssss"
/// affiliatedGrade : "1648226541879005185,1648226681310253058"
/// affiliatedGradeName : null

class Obj {
  Obj({
      num? id, 
      String? username, 
      String? password, 
      String? nickname, 
      String? actualname, 
      String? phone, 
      num? identity,
      String? url,
      String? classId,
      String? affiliatedSchool, 
      String? affiliatedGrade, 
      String? affiliatedGradeName,}){
    _id = id;
    _username = username;
    _password = password;
    _nickname = nickname;
    _actualname = actualname;
    _phone = phone;
    _identity = identity;
    _classId = classId;
    _url = url;
    _affiliatedSchool = affiliatedSchool;
    _affiliatedGrade = affiliatedGrade;
    _affiliatedGradeName = affiliatedGradeName;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _password = json['password'];
    _nickname = json['nickname'];
    _actualname = json['actualname'];
    _phone = json['phone'];
    _identity = json['identity'];
    _classId = json['classId'];
    _url = json['url'];
    _affiliatedSchool = json['affiliatedSchool'];
    _affiliatedGrade = json['affiliatedGrade'];
    _affiliatedGradeName = json['affiliatedGradeName'];
  }
  num? _id;
  String? _username;
  String? _password;
  String? _nickname;
  String? _actualname;
  String? _phone;
  num? _identity;
  String? _classId;
  String? _url;
  String? _affiliatedSchool;
  String? _affiliatedGrade;
  String? _affiliatedGradeName;
Obj copyWith({  num? id,
  String? username,
  String? password,
  String? nickname,
  String? actualname,
  String? phone,
  num? identity,
  String? classId,
  String? url,
  String? affiliatedSchool,
  String? affiliatedGrade,
  String? affiliatedGradeName,
}) => Obj(  id: id ?? _id,
  username: username ?? _username,
  password: password ?? _password,
  nickname: nickname ?? _nickname,
  actualname: actualname ?? _actualname,
  phone: phone ?? _phone,
  identity: identity ?? _identity,
  classId: classId ?? _classId,
  url: url ?? _url,
  affiliatedSchool: affiliatedSchool ?? _affiliatedSchool,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
  affiliatedGradeName: affiliatedGradeName ?? _affiliatedGradeName,
);
  num? get id => _id;
  String? get username => _username;
  String? get password => _password;
  String? get nickname => _nickname;
  String? get actualname => _actualname;
  String? get phone => _phone;
  num? get identity => _identity;
  String? get classId => _classId;
  String? get url => _url;
  String? get affiliatedSchool => _affiliatedSchool;
  String? get affiliatedGrade => _affiliatedGrade;
  String? get affiliatedGradeName => _affiliatedGradeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['password'] = _password;
    map['nickname'] = _nickname;
    map['actualname'] = _actualname;
    map['phone'] = _phone;
    map['identity'] = _identity;
    map['classId'] = _classId;
    map['url'] = _url;
    map['affiliatedSchool'] = _affiliatedSchool;
    map['affiliatedGrade'] = _affiliatedGrade;
    map['affiliatedGradeName'] = _affiliatedGradeName;
    return map;
  }

}