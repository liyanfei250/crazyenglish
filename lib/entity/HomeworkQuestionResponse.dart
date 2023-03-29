/// code : 0
/// msg : "String"
/// data : {"question":[{"id":0,"name":"String","img":"String"}],"total":0,"size":0,"current":0}

class HomeworkQuestionResponse {
  HomeworkQuestionResponse({
      num? code,
      String? msg,
      Data? data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  HomeworkQuestionResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _msg;
  Data? _data;
HomeworkQuestionResponse copyWith({  num? code,
  String? msg,
  Data? data,
}) => HomeworkQuestionResponse(  code: code ?? _code,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// question : [{"id":0,"name":"String","img":"String"}]
/// total : 0
/// size : 0
/// current : 0

class Data {
  Data({
      List<Question>? question,
      num? total,
      num? size,
      num? current,}){
    _question = question;
    _total = total;
    _size = size;
    _current = current;
}

  Data.fromJson(dynamic json) {
    if (json['question'] != null) {
      _question = [];
      json['question'].forEach((v) {
        _question?.add(Question.fromJson(v));
      });
    }
    _total = json['total'];
    _size = json['size'];
    _current = json['current'];
  }
  List<Question>? _question;
  num? _total;
  num? _size;
  num? _current;
Data copyWith({  List<Question>? question,
  num? total,
  num? size,
  num? current,
}) => Data(  question: question ?? _question,
  total: total ?? _total,
  size: size ?? _size,
  current: current ?? _current,
);
  List<Question>? get question => _question;
  num? get total => _total;
  num? get size => _size;
  num? get current => _current;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_question != null) {
      map['question'] = _question?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    map['size'] = _size;
    map['current'] = _current;
    return map;
  }

}

/// id : 0
/// name : "String"
/// img : "String"

class Question {
  Question({
      num? id,
      String? name,
      String? img,}){
    _id = id;
    _name = name;
    _img = img;
}

  Question.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _img = json['img'];
  }
  num? _id;
  String? _name;
  String? _img;
Question copyWith({  num? id,
  String? name,
  String? img,
}) => Question(  id: id ?? _id,
  name: name ?? _name,
  img: img ?? _img,
);
  num? get id => _id;
  String? get name => _name;
  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['img'] = _img;
    return map;
  }

}