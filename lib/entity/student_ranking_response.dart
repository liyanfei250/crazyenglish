/// code : 0
/// message : "系统正常"
/// obj : [{"userId":1651531759961624578,"nickname":"太阳","actualname":"张三","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","studyTime":null,"effort":96.000000,"accuracy":null,"score":null,"totalSize":null,"timeInfos":null,"className":null},{"userId":1651533076075499521,"nickname":"月亮","actualname":"李四","avatar":"https://questions-test.jfwedu.com.cn/img%2Fuser.png","studyTime":null,"effort":76.000000,"accuracy":null,"score":null,"totalSize":null,"timeInfos":null,"className":null}]
/// p : null
/// success : true

class StudentRankingResponse {
  StudentRankingResponse({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p, 
      bool? success,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
    _success = success;
}

  StudentRankingResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
    _success = json['success'];
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
  bool? _success;
StudentRankingResponse copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
  bool? success,
}) => StudentRankingResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
  success: success ?? _success,
);
  num? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
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

/// userId : 1651531759961624578
/// nickname : "太阳"
/// actualname : "张三"
/// avatar : "https://questions-test.jfwedu.com.cn/img%2Fuser.png"
/// studyTime : null
/// effort : 96.000000
/// accuracy : null
/// score : null
/// totalSize : null
/// timeInfos : null
/// className : null

class Obj {
  Obj({
      num? userId, 
      String? nickname, 
      String? actualname, 
      String? avatar, 
      dynamic studyTime, 
      num? effort, 
      dynamic accuracy, 
      dynamic score, 
      dynamic totalSize, 
      dynamic timeInfos, 
      dynamic className,}){
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
  }
  num? _userId;
  String? _nickname;
  String? _actualname;
  String? _avatar;
  dynamic _studyTime;
  num? _effort;
  dynamic _accuracy;
  dynamic _score;
  dynamic _totalSize;
  dynamic _timeInfos;
  dynamic _className;
Obj copyWith({  num? userId,
  String? nickname,
  String? actualname,
  String? avatar,
  dynamic studyTime,
  num? effort,
  dynamic accuracy,
  dynamic score,
  dynamic totalSize,
  dynamic timeInfos,
  dynamic className,
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
);
  num? get userId => _userId;
  String? get nickname => _nickname;
  String? get actualname => _actualname;
  String? get avatar => _avatar;
  dynamic get studyTime => _studyTime;
  num? get effort => _effort;
  dynamic get accuracy => _accuracy;
  dynamic get score => _score;
  dynamic get totalSize => _totalSize;
  dynamic get timeInfos => _timeInfos;
  dynamic get className => _className;

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
    return map;
  }

}