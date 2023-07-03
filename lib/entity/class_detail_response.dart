/// code : 0
/// message : "系统正常"
/// obj : {"id":1655395694170124290,"name":"精英班","image":"https://www.baidu.com/img/flexible/logo/pc/result.png","studentSize":2,"status":1,"isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-08T10:14:24","updateUser":1651539603655626753,"updateTime":"2023-05-08T10:14:24","studentIds":null,"teacherInfo":{"id":1651539603655626753,"username":null,"password":null,"phone":"13800011188","nickname":"皮卡丘","actualname":"郝五一","sex":2,"sexName":null,"affiliatedSchool":"qqqqqqqqq","affiliatedGrade":null,"affiliatedGradeName":null,"affiliatedClass":null,"identity":1,"identityName":null,"isMembership":false,"membership":"否","teachingExperience":"2011-09-01","url":null,"createTime":null},"isJoin":false}
/// p : null
/// success : true

class ClassDetailResponse {
  ClassDetailResponse({
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

  ClassDetailResponse.fromJson(dynamic json) {
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
ClassDetailResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => ClassDetailResponse(  code: code ?? _code,
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

/// id : 1655395694170124290
/// name : "精英班"
/// image : "https://www.baidu.com/img/flexible/logo/pc/result.png"
/// studentSize : 2
/// status : 1
/// isDelete : false
/// createUser : 1651539603655626753
/// createTime : "2023-05-08T10:14:24"
/// updateUser : 1651539603655626753
/// updateTime : "2023-05-08T10:14:24"
/// studentIds : null
/// teacherInfo : {"id":1651539603655626753,"username":null,"password":null,"phone":"13800011188","nickname":"皮卡丘","actualname":"郝五一","sex":2,"sexName":null,"affiliatedSchool":"qqqqqqqqq","affiliatedGrade":null,"affiliatedGradeName":null,"affiliatedClass":null,"identity":1,"identityName":null,"isMembership":false,"membership":"否","teachingExperience":"2011-09-01","url":null,"createTime":null}
/// isJoin : false

class Obj {
  Obj({
      num? id, 
      String? name, 
      String? image, 
      num? studentSize, 
      num? status, 
      bool? isDelete, 
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime, 
      dynamic studentIds, 
      TeacherInfo? teacherInfo, 
      bool? isJoin,}){
    _id = id;
    _name = name;
    _image = image;
    _studentSize = studentSize;
    _status = status;
    _isDelete = isDelete;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
    _studentIds = studentIds;
    _teacherInfo = teacherInfo;
    _isJoin = isJoin;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _studentSize = json['studentSize'];
    _status = json['status'];
    _isDelete = json['isDelete'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
    _studentIds = json['studentIds'];
    _teacherInfo = json['teacherInfo'] != null ? TeacherInfo.fromJson(json['teacherInfo']) : null;
    _isJoin = json['isJoin'];
  }
  num? _id;
  String? _name;
  String? _image;
  num? _studentSize;
  num? _status;
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
  dynamic _studentIds;
  TeacherInfo? _teacherInfo;
  bool? _isJoin;
Obj copyWith({  num? id,
  String? name,
  String? image,
  num? studentSize,
  num? status,
  bool? isDelete,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
  dynamic studentIds,
  TeacherInfo? teacherInfo,
  bool? isJoin,
}) => Obj(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  studentSize: studentSize ?? _studentSize,
  status: status ?? _status,
  isDelete: isDelete ?? _isDelete,
  createUser: createUser ?? _createUser,
  createTime: createTime ?? _createTime,
  updateUser: updateUser ?? _updateUser,
  updateTime: updateTime ?? _updateTime,
  studentIds: studentIds ?? _studentIds,
  teacherInfo: teacherInfo ?? _teacherInfo,
  isJoin: isJoin ?? _isJoin,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  num? get studentSize => _studentSize;
  num? get status => _status;
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;
  dynamic get studentIds => _studentIds;
  TeacherInfo? get teacherInfo => _teacherInfo;
  bool? get isJoin => _isJoin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['studentSize'] = _studentSize;
    map['status'] = _status;
    map['isDelete'] = _isDelete;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    map['studentIds'] = _studentIds;
    if (_teacherInfo != null) {
      map['teacherInfo'] = _teacherInfo?.toJson();
    }
    map['isJoin'] = _isJoin;
    return map;
  }

}

/// id : 1651539603655626753
/// username : null
/// password : null
/// phone : "13800011188"
/// nickname : "皮卡丘"
/// actualname : "郝五一"
/// sex : 2
/// sexName : null
/// affiliatedSchool : "qqqqqqqqq"
/// affiliatedGrade : null
/// affiliatedGradeName : null
/// affiliatedClass : null
/// identity : 1
/// identityName : null
/// isMembership : false
/// membership : "否"
/// teachingExperience : "2011-09-01"
/// url : null
/// createTime : null

class TeacherInfo {
  TeacherInfo({
      num? id, 
      dynamic username, 
      dynamic password, 
      String? phone, 
      String? nickname, 
      String? actualname, 
      num? sex, 
      dynamic sexName, 
      String? affiliatedSchool, 
      dynamic affiliatedGrade, 
      dynamic affiliatedGradeName, 
      dynamic affiliatedClass, 
      num? identity, 
      dynamic identityName, 
      bool? isMembership, 
      String? membership, 
      String? teachingExperience, 
      dynamic url, 
      dynamic createTime,}){
    _id = id;
    _username = username;
    _password = password;
    _phone = phone;
    _nickname = nickname;
    _actualname = actualname;
    _sex = sex;
    _sexName = sexName;
    _affiliatedSchool = affiliatedSchool;
    _affiliatedGrade = affiliatedGrade;
    _affiliatedGradeName = affiliatedGradeName;
    _affiliatedClass = affiliatedClass;
    _identity = identity;
    _identityName = identityName;
    _isMembership = isMembership;
    _membership = membership;
    _teachingExperience = teachingExperience;
    _url = url;
    _createTime = createTime;
}

  TeacherInfo.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _password = json['password'];
    _phone = json['phone'];
    _nickname = json['nickname'];
    _actualname = json['actualname'];
    _sex = json['sex'];
    _sexName = json['sexName'];
    _affiliatedSchool = json['affiliatedSchool'];
    _affiliatedGrade = json['affiliatedGrade'];
    _affiliatedGradeName = json['affiliatedGradeName'];
    _affiliatedClass = json['affiliatedClass'];
    _identity = json['identity'];
    _identityName = json['identityName'];
    _isMembership = json['isMembership'];
    _membership = json['membership'];
    _teachingExperience = json['teachingExperience'];
    _url = json['url'];
    _createTime = json['createTime'];
  }
  num? _id;
  dynamic _username;
  dynamic _password;
  String? _phone;
  String? _nickname;
  String? _actualname;
  num? _sex ;
  dynamic _sexName;
  String? _affiliatedSchool;
  dynamic _affiliatedGrade;
  dynamic _affiliatedGradeName;
  dynamic _affiliatedClass;
  num? _identity;
  dynamic _identityName;
  bool? _isMembership;
  String? _membership;
  String? _teachingExperience;
  dynamic _url;
  dynamic _createTime;
TeacherInfo copyWith({  num? id,
  dynamic username,
  dynamic password,
  String? phone,
  String? nickname,
  String? actualname,
  num? sex,
  dynamic sexName,
  String? affiliatedSchool,
  dynamic affiliatedGrade,
  dynamic affiliatedGradeName,
  dynamic affiliatedClass,
  num? identity,
  dynamic identityName,
  bool? isMembership,
  String? membership,
  String? teachingExperience,
  dynamic url,
  dynamic createTime,
}) => TeacherInfo(  id: id ?? _id,
  username: username ?? _username,
  password: password ?? _password,
  phone: phone ?? _phone,
  nickname: nickname ?? _nickname,
  actualname: actualname ?? _actualname,
  sex: sex ?? _sex,
  sexName: sexName ?? _sexName,
  affiliatedSchool: affiliatedSchool ?? _affiliatedSchool,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
  affiliatedGradeName: affiliatedGradeName ?? _affiliatedGradeName,
  affiliatedClass: affiliatedClass ?? _affiliatedClass,
  identity: identity ?? _identity,
  identityName: identityName ?? _identityName,
  isMembership: isMembership ?? _isMembership,
  membership: membership ?? _membership,
  teachingExperience: teachingExperience ?? _teachingExperience,
  url: url ?? _url,
  createTime: createTime ?? _createTime,
);
  num? get id => _id;
  dynamic get username => _username;
  dynamic get password => _password;
  String? get phone => _phone;
  String? get nickname => _nickname;
  String? get actualname => _actualname;
  num? get sex => _sex;
  dynamic get sexName => _sexName;
  String? get affiliatedSchool => _affiliatedSchool;
  dynamic get affiliatedGrade => _affiliatedGrade;
  dynamic get affiliatedGradeName => _affiliatedGradeName;
  dynamic get affiliatedClass => _affiliatedClass;
  num? get identity => _identity;
  dynamic get identityName => _identityName;
  bool? get isMembership => _isMembership;
  String? get membership => _membership;
  String? get teachingExperience => _teachingExperience;
  dynamic get url => _url;
  dynamic get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['password'] = _password;
    map['phone'] = _phone;
    map['nickname'] = _nickname;
    map['actualname'] = _actualname;
    map['sex'] = _sex;
    map['sexName'] = _sexName;
    map['affiliatedSchool'] = _affiliatedSchool;
    map['affiliatedGrade'] = _affiliatedGrade;
    map['affiliatedGradeName'] = _affiliatedGradeName;
    map['affiliatedClass'] = _affiliatedClass;
    map['identity'] = _identity;
    map['identityName'] = _identityName;
    map['isMembership'] = _isMembership;
    map['membership'] = _membership;
    map['teachingExperience'] = _teachingExperience;
    map['url'] = _url;
    map['createTime'] = _createTime;
    return map;
  }

}