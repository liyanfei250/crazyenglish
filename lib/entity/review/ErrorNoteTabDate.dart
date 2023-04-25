/// code : 0
/// message : "系统正常"
/// obj : [{"journalId":1647898280209838082,"journalName":"ceshi","createTime":"2023-4-24 11:05:51","recordListVos":[{"journalId":1647898280209838082,"subjectId":1648489081579143169,"questionTypeName":"完形填空","totalCount":5,"errorCount":1}]},{"journalId":1647898280209838082,"journalName":"ceshi","createTime":"2023-4-24 04:16:54","recordListVos":[]}]
/// p : null

class ErrorNoteTabDate {
  ErrorNoteTabDate({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  ErrorNoteTabDate.fromJson(dynamic json) {
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
ErrorNoteTabDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => ErrorNoteTabDate(  code: code ?? _code,
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

/// journalId : 1647898280209838082
/// journalName : "ceshi"
/// createTime : "2023-4-24 11:05:51"
/// recordListVos : [{"journalId":1647898280209838082,"subjectId":1648489081579143169,"questionTypeName":"完形填空","totalCount":5,"errorCount":1}]

class Obj {
  Obj({
      num? journalId, 
      String? journalName, 
      String? createTime, 
      List<RecordListVos>? recordListVos,}){
    _journalId = journalId;
    _journalName = journalName;
    _createTime = createTime;
    _recordListVos = recordListVos;
}

  Obj.fromJson(dynamic json) {
    _journalId = json['journalId'];
    _journalName = json['journalName'];
    _createTime = json['createTime'];
    if (json['recordListVos'] != null) {
      _recordListVos = [];
      json['recordListVos'].forEach((v) {
        _recordListVos?.add(RecordListVos.fromJson(v));
      });
    }
  }
  num? _journalId;
  String? _journalName;
  String? _createTime;
  List<RecordListVos>? _recordListVos;
Obj copyWith({  num? journalId,
  String? journalName,
  String? createTime,
  List<RecordListVos>? recordListVos,
}) => Obj(  journalId: journalId ?? _journalId,
  journalName: journalName ?? _journalName,
  createTime: createTime ?? _createTime,
  recordListVos: recordListVos ?? _recordListVos,
);
  num? get journalId => _journalId;
  String? get journalName => _journalName;
  String? get createTime => _createTime;
  List<RecordListVos>? get recordListVos => _recordListVos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['journalId'] = _journalId;
    map['journalName'] = _journalName;
    map['createTime'] = _createTime;
    if (_recordListVos != null) {
      map['recordListVos'] = _recordListVos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// journalId : 1647898280209838082
/// subjectId : 1648489081579143169
/// questionTypeName : "完形填空"
/// totalCount : 5
/// errorCount : 1

class RecordListVos {
  RecordListVos({
      num? journalId, 
      num? subjectId, 
      String? questionTypeName, 
      num? totalCount, 
      num? errorCount,}){
    _journalId = journalId;
    _subjectId = subjectId;
    _questionTypeName = questionTypeName;
    _totalCount = totalCount;
    _errorCount = errorCount;
}

  RecordListVos.fromJson(dynamic json) {
    _journalId = json['journalId'];
    _subjectId = json['subjectId'];
    _questionTypeName = json['questionTypeName'];
    _totalCount = json['totalCount'];
    _errorCount = json['errorCount'];
  }
  num? _journalId;
  num? _subjectId;
  String? _questionTypeName;
  num? _totalCount;
  num? _errorCount;
RecordListVos copyWith({  num? journalId,
  num? subjectId,
  String? questionTypeName,
  num? totalCount,
  num? errorCount,
}) => RecordListVos(  journalId: journalId ?? _journalId,
  subjectId: subjectId ?? _subjectId,
  questionTypeName: questionTypeName ?? _questionTypeName,
  totalCount: totalCount ?? _totalCount,
  errorCount: errorCount ?? _errorCount,
);
  num? get journalId => _journalId;
  num? get subjectId => _subjectId;
  String? get questionTypeName => _questionTypeName;
  num? get totalCount => _totalCount;
  num? get errorCount => _errorCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['journalId'] = _journalId;
    map['subjectId'] = _subjectId;
    map['questionTypeName'] = _questionTypeName;
    map['totalCount'] = _totalCount;
    map['errorCount'] = _errorCount;
    return map;
  }

}