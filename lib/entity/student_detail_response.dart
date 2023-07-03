/// code : 0
/// message : "系统正常"
/// obj : {"userId":1651531759961624578,"nickname":"太阳","actualname":"张三","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","studyTime":100,"effort":96.000000,"accuracy":80.000000,"score":70.000000,"totalSize":20,"timeInfos":null,"className":"精英班","gradeId":1648226681310253058,"gradeName":"八年级"}
/// p : null
/// success : true

class StudentDetailResponse {
  StudentDetailResponse({
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

  StudentDetailResponse.fromJson(dynamic json) {
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
StudentDetailResponse copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
  bool? success,
}) => StudentDetailResponse(  code: code ?? _code,
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

/// userId : 1651531759961624578
/// nickname : "太阳"
/// actualname : "张三"
/// avatar : "https://questions-test.jfwedu.com.cn/img%2Fuser.png"
/// studyTime : 100
/// effort : 96.000000
/// accuracy : 80.000000
/// score : 70.000000
/// totalSize : 20
/// timeInfos : null
/// className : "精英班"
/// gradeId : 1648226681310253058
/// gradeName : "八年级"

class Obj {
  Obj({
      num? userId, 
      String? nickname, 
      String? actualname, 
      String? avatar, 
      num? studyTime, 
      num? effort, 
      num? accuracy, 
      num? score, 
      num? totalSize, 
      dynamic timeInfos, 
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

  Obj.fromJson(dynamic json) {
    _userId = json['userId'];
    _nickname = json['nickname'];
    _actualname = json['actualname'];
    _avatar = json['avatar'];
    _studyTime = json['studyTime'];
    _effort = json['effort'];
    _accuracy = json['accuracy'];
    _score = json['score'];
    _totalSize = json['totalSize'];
    _timeInfos = json['timeInfos'];
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
  dynamic _timeInfos;
  String? _className;
  num? _gradeId;
  String? _gradeName;
Obj copyWith({  num? userId,
  String? nickname,
  String? actualname,
  String? avatar,
  num? studyTime,
  num? effort,
  num? accuracy,
  num? score,
  num? totalSize,
  dynamic timeInfos,
  String? className,
  num? gradeId,
  String? gradeName,
}) => Obj(  userId: userId ?? _userId,
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
  dynamic get timeInfos => _timeInfos;
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
    map['timeInfos'] = _timeInfos;
    map['className'] = _className;
    map['gradeId'] = _gradeId;
    map['gradeName'] = _gradeName;
    return map;
  }

}