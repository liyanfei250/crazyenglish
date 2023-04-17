/// code : 0
/// msg : "String"
/// data : [{"id":0,"title":"String","type":0,"sort":0,"isTake":true,"name":"String","content":"String","createTime":"DateTime","questionBankAppListVos":[{"id":0,"title":"String","difficulty":0,"type":0,"gradeLevel":0,"listenType":0,"sort":0,"requireId":0,"bankAnswerAppListVos":[{"id":0,"logoAnswer":"String","questionBankId":0,"content":"String","isAnswer":true}]}]}]

class WeekTestDetailResponse {
  int? _code;
  String? _msg;
  List<Data>? _data;

  int? get code => _code;
  String? get msg => _msg;
  List<Data>? get data => _data;

  WeekTestDetailResponse({
      int? code, 
      String? msg, 
      List<Data>? data}){
    _code = code;
    _msg = msg;
    _data = data;
}

  WeekTestDetailResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['obj'] != null) {
      _data = [];
      json['obj'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _msg;
    if (_data != null) {
      map['obj'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// title : "String"
/// type : 0
/// sort : 0
/// isTake : true
/// name : "String"
/// content : "String"
/// createTime : "DateTime"
/// questionBankAppListVos : [{"id":0,"title":"String","difficulty":0,"type":0,"gradeLevel":0,"listenType":0,"sort":0,"requireId":0,"bankAnswerAppListVos":[{"id":0,"logoAnswer":"String","questionBankId":0,"content":"String","isAnswer":true}]}]

class Data {
  int? _id;
  String? _title;
  int? _type;
  int? _questionType;
  int? _sort;
  bool? _isTake;
  String? _name;
  String? _content;
  String? _readContent;
  String? _createTime;
  List<QuestionBankAppListVos>? _questionBankAppListVos;

  int? get id => _id;
  String? get title => _title;
  int? get type => _type;
  int? get questionType => _questionType;
  int? get sort => _sort;
  bool? get isTake => _isTake;
  String? get name => _name;
  String? get content => _content;
  String? get readContent => _readContent;
  String? get createTime => _createTime;
  List<QuestionBankAppListVos>? get questionBankAppListVos => _questionBankAppListVos;

  Data({
      int? id, 
      String? title, 
      int? type, 
      int? questionType,
      int? sort,
      bool? isTake, 
      String? name, 
      String? content, 
      String? readContent,
      String? createTime,
      List<QuestionBankAppListVos>? questionBankAppListVos}){
    _id = id;
    _title = title;
    _type = type;
    _questionType = questionType;
    _sort = sort;
    _isTake = isTake;
    _name = name;
    _content = content;
    _readContent = readContent;
    _createTime = createTime;
    _questionBankAppListVos = questionBankAppListVos;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _type = json['type'];
    _questionType = json['questionType'];
    _sort = json['sort'];
    _isTake = json['isTake'];
    _name = json['name'];
    _content = json['content'];
    _readContent = json['readContent'];
    _createTime = json['createTime'];
    if (json['questionBankAppListVos'] != null) {
      _questionBankAppListVos = [];
      json['questionBankAppListVos'].forEach((v) {
        _questionBankAppListVos?.add(QuestionBankAppListVos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['type'] = _type;
    map['questionType'] = _questionType;
    map['sort'] = _sort;
    map['isTake'] = _isTake;
    map['name'] = _name;
    map['content'] = _content;
    map['readContent'] = _readContent;
    map['createTime'] = _createTime;
    if (_questionBankAppListVos != null) {
      map['questionBankAppListVos'] = _questionBankAppListVos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// title : "String"
/// difficulty : 0
/// type : 0
/// gradeLevel : 0
/// listenType : 0
/// sort : 0
/// requireId : 0
/// bankAnswerAppListVos : [{"id":0,"logoAnswer":"String","questionBankId":0,"content":"String","isAnswer":true}]

class QuestionBankAppListVos {
  int? _id;
  String? _title;
  int? _difficulty;
  int? _type;
  int? _gradeLevel;
  int? _listenType;
  int? _sort;
  int? _requireId;
  List<BankAnswerAppListVos>? _bankAnswerAppListVos;

  int? get id => _id;
  String? get title => _title;
  int? get difficulty => _difficulty;
  int? get type => _type;
  int? get gradeLevel => _gradeLevel;
  int? get listenType => _listenType;
  int? get sort => _sort;
  int? get requireId => _requireId;
  List<BankAnswerAppListVos>? get bankAnswerAppListVos => _bankAnswerAppListVos;

  QuestionBankAppListVos({
      int? id, 
      String? title, 
      int? difficulty, 
      int? type, 
      int? gradeLevel, 
      int? listenType, 
      int? sort, 
      int? requireId, 
      List<BankAnswerAppListVos>? bankAnswerAppListVos}){
    _id = id;
    _title = title;
    _difficulty = difficulty;
    _type = type;
    _gradeLevel = gradeLevel;
    _listenType = listenType;
    _sort = sort;
    _requireId = requireId;
    _bankAnswerAppListVos = bankAnswerAppListVos;
}

  QuestionBankAppListVos.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _difficulty = json['difficulty'];
    _type = json['type'];
    _gradeLevel = json['gradeLevel'];
    _listenType = json['listenType'];
    _sort = json['sort'];
    _requireId = json['requireId'];
    if (json['bankAnswerAppListVos'] != null) {
      _bankAnswerAppListVos = [];
      json['bankAnswerAppListVos'].forEach((v) {
        _bankAnswerAppListVos?.add(BankAnswerAppListVos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['difficulty'] = _difficulty;
    map['type'] = _type;
    map['gradeLevel'] = _gradeLevel;
    map['listenType'] = _listenType;
    map['sort'] = _sort;
    map['requireId'] = _requireId;
    if (_bankAnswerAppListVos != null) {
      map['bankAnswerAppListVos'] = _bankAnswerAppListVos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// logoAnswer : "String"
/// questionBankId : 0
/// content : "String"
/// isAnswer : true

class BankAnswerAppListVos {
  int? _id;
  String? _logoAnswer;
  int? _questionBankId;
  String? _content;
  bool? _isAnswer;

  int? get id => _id;
  String? get logoAnswer => _logoAnswer;
  int? get questionBankId => _questionBankId;
  String? get content => _content;
  bool? get isAnswer => _isAnswer;

  BankAnswerAppListVos({
      int? id, 
      String? logoAnswer, 
      int? questionBankId, 
      String? content, 
      bool? isAnswer}){
    _id = id;
    _logoAnswer = logoAnswer;
    _questionBankId = questionBankId;
    _content = content;
    _isAnswer = isAnswer;
}

  BankAnswerAppListVos.fromJson(dynamic json) {
    _id = json['id'];
    _logoAnswer = json['logoAnswer'];
    _questionBankId = json['questionBankId'];
    _content = json['content'];
    _isAnswer = json['isAnswer'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['logoAnswer'] = _logoAnswer;
    map['questionBankId'] = _questionBankId;
    map['content'] = _content;
    map['isAnswer'] = _isAnswer;
    return map;
  }

}