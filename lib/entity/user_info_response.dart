/// code : 0
/// message : "系统正常"
/// obj : {"id":1,"infoId":null,"sourceType":null,"username":"admin","actualname":"里里","sex":1,"sexName":"男","phone":"13803541111","nickname":"尤克里里","password":"e10adc3949ba59abbe56e057f20f883e","url":null}
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

/// id : 1
/// infoId : null
/// sourceType : null
/// username : "admin"
/// actualname : "里里"
/// sex : 1
/// sexName : "男"
/// phone : "13803541111"
/// nickname : "尤克里里"
/// password : "e10adc3949ba59abbe56e057f20f883e"
/// url : null

class Obj {
  Obj({
      num? id, 
      dynamic infoId, 
      dynamic sourceType, 
      String? username, 
      String? actualname, 
      num? sex, 
      String? sexName, 
      String? phone, 
      String? nickname, 
      String? password, 
      dynamic url,}){
    _id = id;
    _infoId = infoId;
    _sourceType = sourceType;
    _username = username;
    _actualname = actualname;
    _sex = sex;
    _sexName = sexName;
    _phone = phone;
    _nickname = nickname;
    _password = password;
    _url = url;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _infoId = json['infoId'];
    _sourceType = json['sourceType'];
    _username = json['username'];
    _actualname = json['actualname'];
    _sex = json['sex'];
    _sexName = json['sexName'];
    _phone = json['phone'];
    _nickname = json['nickname'];
    _password = json['password'];
    _url = json['url'];
  }
  num? _id;
  dynamic _infoId;
  dynamic _sourceType;
  String? _username;
  String? _actualname;
  num? _sex;
  String? _sexName;
  String? _phone;
  String? _nickname;
  String? _password;
  dynamic _url;
Obj copyWith({  num? id,
  dynamic infoId,
  dynamic sourceType,
  String? username,
  String? actualname,
  num? sex,
  String? sexName,
  String? phone,
  String? nickname,
  String? password,
  dynamic url,
}) => Obj(  id: id ?? _id,
  infoId: infoId ?? _infoId,
  sourceType: sourceType ?? _sourceType,
  username: username ?? _username,
  actualname: actualname ?? _actualname,
  sex: sex ?? _sex,
  sexName: sexName ?? _sexName,
  phone: phone ?? _phone,
  nickname: nickname ?? _nickname,
  password: password ?? _password,
  url: url ?? _url,
);
  num? get id => _id;
  dynamic get infoId => _infoId;
  dynamic get sourceType => _sourceType;
  String? get username => _username;
  String? get actualname => _actualname;
  num? get sex => _sex;
  String? get sexName => _sexName;
  String? get phone => _phone;
  String? get nickname => _nickname;
  String? get password => _password;
  dynamic get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['infoId'] = _infoId;
    map['sourceType'] = _sourceType;
    map['username'] = _username;
    map['actualname'] = _actualname;
    map['sex'] = _sex;
    map['sexName'] = _sexName;
    map['phone'] = _phone;
    map['nickname'] = _nickname;
    map['password'] = _password;
    map['url'] = _url;
    return map;
  }

}