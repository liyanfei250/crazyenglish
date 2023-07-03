/// code : 0
/// message : "系统正常"
/// obj : [{"journalId":1647898280209838082,"journalName":"ceshi","createTime":"2023-4-24 11:05:51","recordListVos":[{"journalId":1647898280209838082,"subjectId":1648489081579143169,"questionType":1648210320286650369,"questionTypeName":"完形填空","totalCount":5,"errorCount":1,"correctionNotebooks":[{"id":1650335211706810370,"userId":1,"subtopicId":1648489081851772929,"subjectId":1648489081579143169,"isCorrect":false,"isCover":false,"isRight":false,"answer":"A","correctAnswer":null,"time":0,"createTime":"2023-04-24 11:05:51","correctTime":null}]}]},{"journalId":1647898280209838082,"journalName":"ceshi","createTime":"2023-4-26 10:45:26","recordListVos":[{"journalId":1647898280209838082,"subjectId":1648489081579143169,"questionType":1648210320286650369,"questionTypeName":"完形填空","totalCount":5,"errorCount":1,"correctionNotebooks":[{"id":1651054848555782148,"userId":1,"subtopicId":1648489083361722369,"subjectId":1648489081579143169,"isCorrect":false,"isCover":false,"isRight":false,"answer":"A,C","correctAnswer":null,"time":0,"createTime":"2023-04-26 10:45:26","correctTime":null}]}]}]
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
/// recordListVos : [{"journalId":1647898280209838082,"subjectId":1648489081579143169,"questionType":1648210320286650369,"questionTypeName":"完形填空","totalCount":5,"errorCount":1,"correctionNotebooks":[{"id":1650335211706810370,"userId":1,"subtopicId":1648489081851772929,"subjectId":1648489081579143169,"isCorrect":false,"isCover":false,"isRight":false,"answer":"A","correctAnswer":null,"time":0,"createTime":"2023-04-24 11:05:51","correctTime":null}]}]

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
/// questionType : 1648210320286650369
/// questionTypeName : "完形填空"
/// totalCount : 5
/// errorCount : 1
/// correctionNotebooks : [{"id":1650335211706810370,"userId":1,"subtopicId":1648489081851772929,"subjectId":1648489081579143169,"isCorrect":false,"isCover":false,"isRight":false,"answer":"A","correctAnswer":null,"time":0,"createTime":"2023-04-24 11:05:51","correctTime":null}]

class RecordListVos {
  RecordListVos({
      num? journalId, 
      num? subjectId, 
      num? questionType, 
      String? questionTypeName, 
      String? catalogueName, //替代
      num? totalCount,
      num? errorCount, 
      num? correctCount,
      List<CorrectionNotebooks>? correctionNotebooks,}){
    _journalId = journalId;
    _subjectId = subjectId;
    _questionType = questionType;
    _questionTypeName = questionTypeName;
    _catalogueName = catalogueName;
    _totalCount = totalCount;
    _errorCount = errorCount;
    _correctCount = correctCount;
    _correctionNotebooks = correctionNotebooks;
}

  RecordListVos.fromJson(dynamic json) {
    _journalId = json['journalId'];
    _subjectId = json['subjectId'];
    _questionType = json['questionType'];
    _questionTypeName = json['questionTypeName'];
    _catalogueName = json['catalogueName'];
    _totalCount = json['totalCount'];
    _errorCount = json['errorCount'];
    _correctCount = json['correctCount'];
    if (json['correctionNotebooks'] != null) {
      _correctionNotebooks = [];
      json['correctionNotebooks'].forEach((v) {
        _correctionNotebooks?.add(CorrectionNotebooks.fromJson(v));
      });
    }
  }
  num? _journalId;
  num? _subjectId;
  num? _questionType;
  String? _questionTypeName;
  String? _catalogueName;
  num? _totalCount;
  num? _errorCount;
  num? _correctCount;
  List<CorrectionNotebooks>? _correctionNotebooks;
RecordListVos copyWith({  num? journalId,
  num? subjectId,
  num? questionType,
  String? questionTypeName,
  String? catalogueName,
  num? totalCount,
  num? errorCount,
  num? correctCount,
  List<CorrectionNotebooks>? correctionNotebooks,
}) => RecordListVos(  journalId: journalId ?? _journalId,
  subjectId: subjectId ?? _subjectId,
  questionType: questionType ?? _questionType,
  questionTypeName: questionTypeName ?? _questionTypeName,
  catalogueName: catalogueName ?? _catalogueName,
  totalCount: totalCount ?? _totalCount,
  errorCount: errorCount ?? _errorCount,
  correctCount: correctCount ?? _correctCount,
  correctionNotebooks: correctionNotebooks ?? _correctionNotebooks,
);
  num? get journalId => _journalId;
  num? get subjectId => _subjectId;
  num? get questionType => _questionType;
  String? get questionTypeName => _questionTypeName;
  String? get catalogueName => _catalogueName;
  num? get totalCount => _totalCount;
  num? get errorCount => _errorCount;
  num? get correctCount => _correctCount;
  List<CorrectionNotebooks>? get correctionNotebooks => _correctionNotebooks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['journalId'] = _journalId;
    map['subjectId'] = _subjectId;
    map['questionType'] = _questionType;
    map['questionTypeName'] = _questionTypeName;
    map['catalogueName'] = _catalogueName;
    map['totalCount'] = _totalCount;
    map['errorCount'] = _errorCount;
    map['correctCount'] = _correctCount;
    if (_correctionNotebooks != null) {
      map['correctionNotebooks'] = _correctionNotebooks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1650335211706810370
/// userId : 1
/// subtopicId : 1648489081851772929
/// subjectId : 1648489081579143169
/// isCorrect : false
/// isCover : false
/// isRight : false
/// answer : "A"
/// correctAnswer : null
/// time : 0
/// createTime : "2023-04-24 11:05:51"
/// correctTime : null

class CorrectionNotebooks {
  CorrectionNotebooks({
      num? id, 
      num? userId, 
      num? subtopicId, 
      num? subjectId, 
      bool? isCorrect, 
      bool? isCover, 
      bool? isRight, 
      String? answer, 
      dynamic correctAnswer, 
      num? time, 
      String? createTime, 
      dynamic correctTime,}){
    _id = id;
    _userId = userId;
    _subtopicId = subtopicId;
    _subjectId = subjectId;
    _isCorrect = isCorrect;
    _isCover = isCover;
    _isRight = isRight;
    _answer = answer;
    _correctAnswer = correctAnswer;
    _time = time;
    _createTime = createTime;
    _correctTime = correctTime;
}

  CorrectionNotebooks.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _subtopicId = json['subtopicId'];
    _subjectId = json['subjectId'];
    _isCorrect = json['isCorrect'];
    _isCover = json['isCover'];
    _isRight = json['isRight'];
    _answer = json['answer'];
    _correctAnswer = json['correctAnswer'];
    _time = json['time'];
    _createTime = json['createTime'];
    _correctTime = json['correctTime'];
  }
  num? _id;
  num? _userId;
  num? _subtopicId;
  num? _subjectId;
  bool? _isCorrect;
  bool? _isCover;
  bool? _isRight;
  String? _answer;
  dynamic _correctAnswer;
  num? _time;
  String? _createTime;
  dynamic _correctTime;
CorrectionNotebooks copyWith({  num? id,
  num? userId,
  num? subtopicId,
  num? subjectId,
  bool? isCorrect,
  bool? isCover,
  bool? isRight,
  String? answer,
  dynamic correctAnswer,
  num? time,
  String? createTime,
  dynamic correctTime,
}) => CorrectionNotebooks(  id: id ?? _id,
  userId: userId ?? _userId,
  subtopicId: subtopicId ?? _subtopicId,
  subjectId: subjectId ?? _subjectId,
  isCorrect: isCorrect ?? _isCorrect,
  isCover: isCover ?? _isCover,
  isRight: isRight ?? _isRight,
  answer: answer ?? _answer,
  correctAnswer: correctAnswer ?? _correctAnswer,
  time: time ?? _time,
  createTime: createTime ?? _createTime,
  correctTime: correctTime ?? _correctTime,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get subtopicId => _subtopicId;
  num? get subjectId => _subjectId;
  bool? get isCorrect => _isCorrect;
  bool? get isCover => _isCover;
  bool? get isRight => _isRight;
  String? get answer => _answer;
  dynamic get correctAnswer => _correctAnswer;
  num? get time => _time;
  String? get createTime => _createTime;
  dynamic get correctTime => _correctTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['subtopicId'] = _subtopicId;
    map['subjectId'] = _subjectId;
    map['isCorrect'] = _isCorrect;
    map['isCover'] = _isCover;
    map['isRight'] = _isRight;
    map['answer'] = _answer;
    map['correctAnswer'] = _correctAnswer;
    map['time'] = _time;
    map['createTime'] = _createTime;
    map['correctTime'] = _correctTime;
    return map;
  }

}