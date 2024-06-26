/// code : 0
/// message : "系统正常"
/// obj : {"cumulativeExercise":16,"todayExercise":9,"cumulativeError":10,"crrect":0,"collected":1,"exerciseRecord":6,"historyJob":0}
/// p : null

class ReviewHomeDetail {
  ReviewHomeDetail({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  ReviewHomeDetail.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
ReviewHomeDetail copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => ReviewHomeDetail(  code: code ?? _code,
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

/// cumulativeExercise : 16
/// todayExercise : 9
/// cumulativeError : 10
/// crrect : 0
/// collected : 1
/// exerciseRecord : 6
/// historyJob : 0

class Obj {
  Obj({
      num? cumulativeExercise, 
      num? todayExercise, 
      num? cumulativeError, 
      num? crrect, 
      num? collected, 
      num? exerciseRecord, 
      num? historyJob,}){
    _cumulativeExercise = cumulativeExercise;
    _todayExercise = todayExercise;
    _cumulativeError = cumulativeError;
    _crrect = crrect;
    _collected = collected;
    _exerciseRecord = exerciseRecord;
    _historyJob = historyJob;
}

  Obj.fromJson(dynamic json) {
    _cumulativeExercise = json['cumulativeExercise'];
    _todayExercise = json['todayExercise'];
    _cumulativeError = json['cumulativeError'];
    _crrect = json['crrect'];
    _collected = json['collected'];
    _exerciseRecord = json['exerciseRecord'];
    _historyJob = json['historyJob'];
  }
  num? _cumulativeExercise;
  num? _todayExercise;
  num? _cumulativeError;
  num? _crrect;
  num? _collected;
  num? _exerciseRecord;
  num? _historyJob;
Obj copyWith({  num? cumulativeExercise,
  num? todayExercise,
  num? cumulativeError,
  num? crrect,
  num? collected,
  num? exerciseRecord,
  num? historyJob,
}) => Obj(  cumulativeExercise: cumulativeExercise ?? _cumulativeExercise,
  todayExercise: todayExercise ?? _todayExercise,
  cumulativeError: cumulativeError ?? _cumulativeError,
  crrect: crrect ?? _crrect,
  collected: collected ?? _collected,
  exerciseRecord: exerciseRecord ?? _exerciseRecord,
  historyJob: historyJob ?? _historyJob,
);
  num? get cumulativeExercise => _cumulativeExercise;
  num? get todayExercise => _todayExercise;
  num? get cumulativeError => _cumulativeError;
  num? get crrect => _crrect;
  num? get collected => _collected;
  num? get exerciseRecord => _exerciseRecord;
  num? get historyJob => _historyJob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cumulativeExercise'] = _cumulativeExercise;
    map['todayExercise'] = _todayExercise;
    map['cumulativeError'] = _cumulativeError;
    map['crrect'] = _crrect;
    map['collected'] = _collected;
    map['exerciseRecord'] = _exerciseRecord;
    map['historyJob'] = _historyJob;
    return map;
  }

}