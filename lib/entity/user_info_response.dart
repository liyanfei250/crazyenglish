/// code : 0
/// message : "系统正常"
/// obj : {"id":1651539603655626753,"username":"13800011188","password":"d41d8cd98f00b204e9800998ecf8427e","nickname":"ghh","actualname":"郝五一","sex":2,"sexName":"女","phone":"13800011188","identity":1,"url":"http://cdn-files-test.crazyenglishweekly.com/crazyenglish/app/1651539603655626753/headimg_1651539603655626753_imgimage_cropper_1684403155252.jpg","affiliatedSchool":"qqqqqqqqq","affiliatedGrade":"1648226541879005185","affiliatedGradeName":"七年级","affiliatedClass":null,"teachingExperience":"2011-09-01","teachingExperienceName":"11年9月"}
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

/// id : 1651539603655626753
/// username : "13800011188"
/// password : "d41d8cd98f00b204e9800998ecf8427e"
/// nickname : "ghh"
/// actualname : "郝五一"
/// sex : 2
/// sexName : "女"
/// phone : "13800011188"
/// identity : 1老师2学生
/// url : "http://cdn-files-test.crazyenglishweekly.com/crazyenglish/app/1651539603655626753/headimg_1651539603655626753_imgimage_cropper_1684403155252.jpg"
/// affiliatedSchool : "qqqqqqqqq"
/// affiliatedGrade : "1648226541879005185"
/// affiliatedGradeName : "七年级"
/// affiliatedClass : null
/// teachingExperience : "2011-09-01"
/// teachingExperienceName : "11年9月"

class Obj {
  Obj({
      num? id, 
      String? username, 
      String? password, 
      String? nickname, 
      String? actualname,
      String? classId,
      num? sex,
      String? sexName, 
      String? phone, 
      num? identity, 
      String? url, 
      String? affiliatedSchool, 
      String? affiliatedGrade, 
      String? affiliatedGradeName, 
      dynamic affiliatedClass, 
      String? teachingExperience, 
      String? teachingExperienceName,}){
    _id = id;
    _username = username;
    _password = password;
    _nickname = nickname;
    _actualname = actualname;
    _classId = classId;
    _sex = sex;
    _sexName = sexName;
    _phone = phone;
    _identity = identity;
    _url = url;
    _affiliatedSchool = affiliatedSchool;
    _affiliatedGrade = affiliatedGrade;
    _affiliatedGradeName = affiliatedGradeName;
    _affiliatedClass = affiliatedClass;
    _teachingExperience = teachingExperience;
    _teachingExperienceName = teachingExperienceName;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _password = json['password'];
    _nickname = json['nickname'];
    _actualname = json['actualname'];
    _classId = json['classId'];
    _sex = json['sex'];
    _sexName = json['sexName'];
    _phone = json['phone'];
    _identity = json['identity'];
    _url = json['url'];
    _affiliatedSchool = json['affiliatedSchool'];
    _affiliatedGrade = json['affiliatedGrade'];
    _affiliatedGradeName = json['affiliatedGradeName'];
    _affiliatedClass = json['affiliatedClass'];
    _teachingExperience = json['teachingExperience'];
    _teachingExperienceName = json['teachingExperienceName'];
  }
  num? _id;
  String? _username;
  String? _password;
  String? _nickname;
  String? _actualname;
  String? _classId;
  num? _sex;
  String? _sexName;
  String? _phone;
  num? _identity;
  String? _url;
  String? _affiliatedSchool;
  String? _affiliatedGrade;
  String? _affiliatedGradeName;
  dynamic _affiliatedClass;
  String? _teachingExperience;
  String? _teachingExperienceName;
Obj copyWith({  num? id,
  String? username,
  String? password,
  String? nickname,
  String? actualname,
  String? classId,
  num? sex,
  String? sexName,
  String? phone,
  num? identity,
  String? url,
  String? affiliatedSchool,
  String? affiliatedGrade,
  String? affiliatedGradeName,
  dynamic affiliatedClass,
  String? teachingExperience,
  String? teachingExperienceName,
}) => Obj(  id: id ?? _id,
  username: username ?? _username,
  password: password ?? _password,
  nickname: nickname ?? _nickname,
  actualname: actualname ?? _actualname,
  classId: classId ?? _classId,
  sex: sex ?? _sex,
  sexName: sexName ?? _sexName,
  phone: phone ?? _phone,
  identity: identity ?? _identity,
  url: url ?? _url,
  affiliatedSchool: affiliatedSchool ?? _affiliatedSchool,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
  affiliatedGradeName: affiliatedGradeName ?? _affiliatedGradeName,
  affiliatedClass: affiliatedClass ?? _affiliatedClass,
  teachingExperience: teachingExperience ?? _teachingExperience,
  teachingExperienceName: teachingExperienceName ?? _teachingExperienceName,
);
  num? get id => _id;
  String? get username => _username;
  String? get password => _password;
  String? get nickname => _nickname;
  String? get actualname => _actualname;
  String? get classId => _classId;
  num? get sex => _sex;
  String? get sexName => _sexName;
  String? get phone => _phone;
  num? get identity => _identity;
  String? get url => _url;
  String? get affiliatedSchool => _affiliatedSchool;
  String? get affiliatedGrade => _affiliatedGrade;
  String? get affiliatedGradeName => _affiliatedGradeName;
  dynamic get affiliatedClass => _affiliatedClass;
  String? get teachingExperience => _teachingExperience;
  String? get teachingExperienceName => _teachingExperienceName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['password'] = _password;
    map['nickname'] = _nickname;
    map['actualname'] = _actualname;
    map['classId'] = _classId;
    map['sex'] = _sex;
    map['sexName'] = _sexName;
    map['phone'] = _phone;
    map['identity'] = _identity;
    map['url'] = _url;
    map['affiliatedSchool'] = _affiliatedSchool;
    map['affiliatedGrade'] = _affiliatedGrade;
    map['affiliatedGradeName'] = _affiliatedGradeName;
    map['affiliatedClass'] = _affiliatedClass;
    map['teachingExperience'] = _teachingExperience;
    map['teachingExperienceName'] = _teachingExperienceName;
    return map;
  }

}