/// code : 0
/// message : "系统正常"
/// obj : [{"subjectId":1648489081579143169,"subtopicId":1648489081851772929,"journalName":"ceshi","collectedTime":"2023-04-25 14:13:02.0","questionTypeName":"完形填空","content":"How far do you have to go to get a cup of clean water? Maybe it is just a few 36 away. But for Jimmy Akana from Uganda, a country in Africa, getting water meant walking three miles to the nearest well (井). The water was not 37 . People might get sick after drinking it. When Ryan Hrelijac, a Canadian boy, 38 the need for clean water in Africa, he decided to do something about it. He was only six years old at that time, but he didn't let that stop him. Ryan asked his mom and dad for 39 . They said that he could do housework to earn (赚) money. After four months, Ryan had 70 dollars. He 40 that would be enough to build a well. Ryan's mom drove him to anorganization (组织) that builds wells for poor people all around the world. 41 , people at the organization told Ryan he needed to spend 2,000 dollarsbuilding a well. Ryan had to do more to raise money. Finally, Ryan raised enough money and he helped to build a well for Angolo Primary School in Uganda. Years later, Ryan set up a foundation ( 基 金 会) called Ryan's Well Foundation to help 42 the world's water problem. Now Ryan's foundation is a team of people working hard to provide (提供) safe 43 for people in poor countries."},{"subjectId":1648490005294907394,"subtopicId":1648490005429125122,"journalName":"ceshi","collectedTime":"2023-04-25 16:51:31.0","questionTypeName":"单项选择题","content":"21. Our English teacher asked us to do our homework _______ ourselves."}]
/// p : null

class SearchCollectListDate {
  SearchCollectListDate({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  SearchCollectListDate.fromJson(dynamic json) {
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
SearchCollectListDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => SearchCollectListDate(  code: code ?? _code,
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

/// subjectId : 1648489081579143169
/// subtopicId : 1648489081851772929
/// journalName : "ceshi"
/// collectedTime : "2023-04-25 14:13:02.0"
/// questionTypeName : "完形填空"
/// content : "How far do you have to go to get a cup of clean water? Maybe it is just a few 36 away. But for Jimmy Akana from Uganda, a country in Africa, getting water meant walking three miles to the nearest well (井). The water was not 37 . People might get sick after drinking it. When Ryan Hrelijac, a Canadian boy, 38 the need for clean water in Africa, he decided to do something about it. He was only six years old at that time, but he didn't let that stop him. Ryan asked his mom and dad for 39 . They said that he could do housework to earn (赚) money. After four months, Ryan had 70 dollars. He 40 that would be enough to build a well. Ryan's mom drove him to anorganization (组织) that builds wells for poor people all around the world. 41 , people at the organization told Ryan he needed to spend 2,000 dollarsbuilding a well. Ryan had to do more to raise money. Finally, Ryan raised enough money and he helped to build a well for Angolo Primary School in Uganda. Years later, Ryan set up a foundation ( 基 金 会) called Ryan's Well Foundation to help 42 the world's water problem. Now Ryan's foundation is a team of people working hard to provide (提供) safe 43 for people in poor countries."

class Obj {
  Obj({
      num? subjectId, 
      num? subtopicId, 
      String? journalName, 
      String? collectedTime, 
      String? questionTypeName, 
      String? content,}){
    _subjectId = subjectId;
    _subtopicId = subtopicId;
    _journalName = journalName;
    _collectedTime = collectedTime;
    _questionTypeName = questionTypeName;
    _content = content;
}

  Obj.fromJson(dynamic json) {
    _subjectId = json['subjectId'];
    _subtopicId = json['subtopicId'];
    _journalName = json['journalName'];
    _collectedTime = json['collectedTime'];
    _questionTypeName = json['questionTypeName'];
    _content = json['content'];
  }
  num? _subjectId;
  num? _subtopicId;
  String? _journalName;
  String? _collectedTime;
  String? _questionTypeName;
  String? _content;
Obj copyWith({  num? subjectId,
  num? subtopicId,
  String? journalName,
  String? collectedTime,
  String? questionTypeName,
  String? content,
}) => Obj(  subjectId: subjectId ?? _subjectId,
  subtopicId: subtopicId ?? _subtopicId,
  journalName: journalName ?? _journalName,
  collectedTime: collectedTime ?? _collectedTime,
  questionTypeName: questionTypeName ?? _questionTypeName,
  content: content ?? _content,
);
  num? get subjectId => _subjectId;
  num? get subtopicId => _subtopicId;
  String? get journalName => _journalName;
  String? get collectedTime => _collectedTime;
  String? get questionTypeName => _questionTypeName;
  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subjectId'] = _subjectId;
    map['subtopicId'] = _subtopicId;
    map['journalName'] = _journalName;
    map['collectedTime'] = _collectedTime;
    map['questionTypeName'] = _questionTypeName;
    map['content'] = _content;
    return map;
  }

}