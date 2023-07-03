/// code : 0
/// message : "系统正常"
/// obj : {"subjectId":null,"subtopicId":null,"journalName":null,"collectedTime":null,"questionTypeName":null,"content":null,"isCollect":true}
/// p : null

class CollectDate {
  CollectDate({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  CollectDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
CollectDate copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => CollectDate(  code: code ?? _code,
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

/// subjectId : null
/// subtopicId : null
/// journalName : null
/// collectedTime : null
/// questionTypeName : null
/// content : null
/// isCollect : true

class Obj {
  Obj({
      dynamic subjectId, 
      dynamic subtopicId, 
      dynamic journalName, 
      dynamic collectedTime, 
      dynamic questionTypeName, 
      dynamic content, 
      bool? isCollect,}){
    _subjectId = subjectId;
    _subtopicId = subtopicId;
    _journalName = journalName;
    _collectedTime = collectedTime;
    _questionTypeName = questionTypeName;
    _content = content;
    _isCollect = isCollect;
}

  Obj.fromJson(dynamic json) {
    _subjectId = json['subjectId'];
    _subtopicId = json['subtopicId'];
    _journalName = json['journalName'];
    _collectedTime = json['collectedTime'];
    _questionTypeName = json['questionTypeName'];
    _content = json['content'];
    _isCollect = json['isCollect'];
  }
  dynamic _subjectId;
  dynamic _subtopicId;
  dynamic _journalName;
  dynamic _collectedTime;
  dynamic _questionTypeName;
  dynamic _content;
  bool? _isCollect;
Obj copyWith({  dynamic subjectId,
  dynamic subtopicId,
  dynamic journalName,
  dynamic collectedTime,
  dynamic questionTypeName,
  dynamic content,
  bool? isCollect,
}) => Obj(  subjectId: subjectId ?? _subjectId,
  subtopicId: subtopicId ?? _subtopicId,
  journalName: journalName ?? _journalName,
  collectedTime: collectedTime ?? _collectedTime,
  questionTypeName: questionTypeName ?? _questionTypeName,
  content: content ?? _content,
  isCollect: isCollect ?? _isCollect,
);
  dynamic get subjectId => _subjectId;
  dynamic get subtopicId => _subtopicId;
  dynamic get journalName => _journalName;
  dynamic get collectedTime => _collectedTime;
  dynamic get questionTypeName => _questionTypeName;
  dynamic get content => _content;
  bool? get isCollect => _isCollect;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subjectId'] = _subjectId;
    map['subtopicId'] = _subtopicId;
    map['journalName'] = _journalName;
    map['collectedTime'] = _collectedTime;
    map['questionTypeName'] = _questionTypeName;
    map['content'] = _content;
    map['isCollect'] = _isCollect;
    return map;
  }

}