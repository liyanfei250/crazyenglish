/// code : 0
/// message : "系统正常"
/// obj : [{"classify":1646439861824098306,"time":0,"classifyName":"累计听力","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/accumulateHearing.png"},{"classify":1646439861824098307,"time":0,"classifyName":"累计阅读","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/accumulateReading.png"},{"classify":1646439861824098309,"time":0,"classifyName":"累计口语","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/accumulateSentence.png"},{"classify":1646439861824098308,"time":0,"classifyName":"累计写作","icon":"http://cdn-files-test.crazyenglishweekly.com/diamond/accumulateWriting.png"}]
/// p : null
/// success : true

class StudentTimeStatistics {
  StudentTimeStatistics({
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

  StudentTimeStatistics.fromJson(dynamic json) {
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
StudentTimeStatistics copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
  bool? success,
}) => StudentTimeStatistics(  code: code ?? _code,
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

/// classify : 1646439861824098306
/// time : 0
/// classifyName : "累计听力"
/// icon : "http://cdn-files-test.crazyenglishweekly.com/diamond/accumulateHearing.png"

class Obj {
  Obj({
      num? classify, 
      num? time, 
      String? classifyName, 
      String? icon,}){
    _classify = classify;
    _time = time;
    _classifyName = classifyName;
    _icon = icon;
}

  Obj.fromJson(dynamic json) {
    _classify = json['classify'];
    _time = json['time'];
    _classifyName = json['classifyName'];
    _icon = json['icon'];
  }
  num? _classify;
  num? _time;
  String? _classifyName;
  String? _icon;
Obj copyWith({  num? classify,
  num? time,
  String? classifyName,
  String? icon,
}) => Obj(  classify: classify ?? _classify,
  time: time ?? _time,
  classifyName: classifyName ?? _classifyName,
  icon: icon ?? _icon,
);
  num? get classify => _classify;
  num? get time => _time;
  String? get classifyName => _classifyName;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classify'] = _classify;
    map['time'] = _time;
    map['classifyName'] = _classifyName;
    map['icon'] = _icon;
    return map;
  }

}