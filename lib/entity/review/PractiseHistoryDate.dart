/// code : 0
/// message : "系统正常"
/// obj : [{"exerciseId":1648489081851772929,"questionTypeName":"完形填空","time":"09:14:11","exerciseCount":7,"correctCount":4,"accuracy":"57.14"}]
/// p : null

class PractiseHistoryDate {
  PractiseHistoryDate({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  PractiseHistoryDate.fromJson(dynamic json) {
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
PractiseHistoryDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => PractiseHistoryDate(  code: code ?? _code,
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

/// exerciseId : 1648489081851772929
/// questionTypeName : "完形填空"
/// time : "09:14:11"
/// exerciseCount : 7
/// correctCount : 4
/// accuracy : "57.14"

class Obj {
  Obj({
      num? exerciseId, 
      String? questionTypeName, 
      String? time, 
      num? exerciseCount, 
      num? correctCount, 
      String? accuracy,}){
    _exerciseId = exerciseId;
    _questionTypeName = questionTypeName;
    _time = time;
    _exerciseCount = exerciseCount;
    _correctCount = correctCount;
    _accuracy = accuracy;
}

  Obj.fromJson(dynamic json) {
    _exerciseId = json['exerciseId'];
    _questionTypeName = json['questionTypeName'];
    _time = json['time'];
    _exerciseCount = json['exerciseCount'];
    _correctCount = json['correctCount'];
    _accuracy = json['accuracy'];
  }
  num? _exerciseId;
  String? _questionTypeName;
  String? _time;
  num? _exerciseCount;
  num? _correctCount;
  String? _accuracy;
Obj copyWith({  num? exerciseId,
  String? questionTypeName,
  String? time,
  num? exerciseCount,
  num? correctCount,
  String? accuracy,
}) => Obj(  exerciseId: exerciseId ?? _exerciseId,
  questionTypeName: questionTypeName ?? _questionTypeName,
  time: time ?? _time,
  exerciseCount: exerciseCount ?? _exerciseCount,
  correctCount: correctCount ?? _correctCount,
  accuracy: accuracy ?? _accuracy,
);
  num? get exerciseId => _exerciseId;
  String? get questionTypeName => _questionTypeName;
  String? get time => _time;
  num? get exerciseCount => _exerciseCount;
  num? get correctCount => _correctCount;
  String? get accuracy => _accuracy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exerciseId'] = _exerciseId;
    map['questionTypeName'] = _questionTypeName;
    map['time'] = _time;
    map['exerciseCount'] = _exerciseCount;
    map['correctCount'] = _correctCount;
    map['accuracy'] = _accuracy;
    return map;
  }

}