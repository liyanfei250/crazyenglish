/// code : 0
/// message : "系统正常"
/// obj : [{"classId":1655395694170124290,"userId":1651531759961624578,"nickname":"太阳","actualname":"张三","sex":null,"affiliatedSchool":null,"affiliatedGrade":null,"identity":null,"isMembership":null,"avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","className":null},{"classId":1655395694170124290,"userId":1651533076075499521,"nickname":"月亮","actualname":"李四","sex":null,"affiliatedSchool":null,"affiliatedGrade":null,"identity":null,"isMembership":null,"avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","className":null},{"classId":1655395694170124290,"userId":null,"nickname":null,"actualname":null,"sex":null,"affiliatedSchool":null,"affiliatedGrade":null,"identity":null,"isMembership":null,"avatar":null,"className":null}]
/// p : null
/// success : true

class MemberStudentList {
  MemberStudentList({
      num? code, 
      String? message, 
      List<Student>? obj,
      dynamic p, 
      bool? success,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
    _success = success;
}

  MemberStudentList.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      for (var item in json['obj']) {
        _obj?.add(Student.fromJson(item));
      }
    }
    _p = json['p'];
    _success = json['success'];
  }
  num? _code;
  String? _message;
  List<Student>? _obj;
  dynamic _p;
  bool? _success;
MemberStudentList copyWith({  num? code,
  String? message,
  List<Student>? obj,
  dynamic p,
  bool? success,
}) => MemberStudentList(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
  success: success ?? _success,
);
  num? get code => _code;
  String? get message => _message;
  List<Student>? get obj => _obj;
  dynamic get p => _p;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    map['p'] = _p;
    map['success'] = _success;
    return map;
  }

}

/// classId : 1655395694170124290
/// userId : 1651531759961624578
/// nickname : "太阳"
/// actualname : "张三"
/// sex : null
/// affiliatedSchool : null
/// affiliatedGrade : null
/// identity : null
/// isMembership : null
/// avatar : "https://questions-test.jfwedu.com.cn/img%2Fuser.png"
/// className : null

class Student {
  Student({
      num? classId, 
      num? userId = 0,
      String? nickname, 
      String? actualname, 
      dynamic sex, 
      dynamic affiliatedSchool, 
      dynamic affiliatedGrade, 
      dynamic identity, 
      dynamic isMembership, 
      String? avatar, 
      dynamic className,}){
    _classId = classId;
    _userId = userId;
    _nickname = nickname;
    _actualname = actualname;
    _sex = sex;
    _affiliatedSchool = affiliatedSchool;
    _affiliatedGrade = affiliatedGrade;
    _identity = identity;
    _isMembership = isMembership;
    _avatar = avatar;
    _className = className;
}

  Student.fromJson(dynamic json) {
    _classId = json['classId'];
    _userId = json['userId'];
    _nickname = json['nickname'];
    _actualname = json['actualname'];
    _sex = json['sex'];
    _affiliatedSchool = json['affiliatedSchool'];
    _affiliatedGrade = json['affiliatedGrade'];
    _identity = json['identity'];
    _isMembership = json['isMembership'];
    _avatar = json['avatar'];
    _className = json['className'];
  }
  num? _classId;
  num? _userId;
  String? _nickname;
  String? _actualname;
  dynamic _sex;
  dynamic _affiliatedSchool;
  dynamic _affiliatedGrade;
  dynamic _identity;
  dynamic _isMembership;
  String? _avatar;
  dynamic _className;
  Student copyWith({  num? classId,
  num? userId,
  String? nickname,
  String? actualname,
  dynamic sex,
  dynamic affiliatedSchool,
  dynamic affiliatedGrade,
  dynamic identity,
  dynamic isMembership,
  String? avatar,
  dynamic className,
}) => Student(  classId: classId ?? _classId,
  userId: userId ?? _userId,
  nickname: nickname ?? _nickname,
  actualname: actualname ?? _actualname,
  sex: sex ?? _sex,
  affiliatedSchool: affiliatedSchool ?? _affiliatedSchool,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
  identity: identity ?? _identity,
  isMembership: isMembership ?? _isMembership,
  avatar: avatar ?? _avatar,
  className: className ?? _className,
);
  num? get classId => _classId;
  num? get userId => _userId;
  String? get nickname => _nickname;
  String? get actualname => _actualname;
  dynamic get sex => _sex;
  dynamic get affiliatedSchool => _affiliatedSchool;
  dynamic get affiliatedGrade => _affiliatedGrade;
  dynamic get identity => _identity;
  dynamic get isMembership => _isMembership;
  String? get avatar => _avatar;
  dynamic get className => _className;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classId'] = _classId;
    map['userId'] = _userId;
    map['nickname'] = _nickname;
    map['actualname'] = _actualname;
    map['sex'] = _sex;
    map['affiliatedSchool'] = _affiliatedSchool;
    map['affiliatedGrade'] = _affiliatedGrade;
    map['identity'] = _identity;
    map['isMembership'] = _isMembership;
    map['avatar'] = _avatar;
    map['className'] = _className;
    return map;
  }

}