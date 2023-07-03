/// code : 0
/// msg : "String"
/// data : {"questions":[{"id":0,"name":"String","img":"String","createTime":"DateTime"}],"total":0,"size":0,"current":0}

class QuestionListResponse {
  QuestionListResponse({
    num? code,
    String? msg,
    Data? data,}){
    _code = code;
    _msg = msg;
    _data = data;
  }

  QuestionListResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['obj'] != null ? Data.fromJson(json['obj']) : null;
  }
  num? _code;
  String? _msg;
  Data? _data;
  QuestionListResponse copyWith({  num? code,
    String? msg,
    Data? data,
  }) => QuestionListResponse(  code: code ?? _code,
    msg: msg ?? _msg,
    data: data ?? _data,
  );
  num? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _msg;
    if (_data != null) {
      map['obj'] = _data?.toJson();
    }
    return map;
  }

}

/// questions : [{"id":0,"name":"String","img":"String","createTime":"DateTime"}]
/// total : 0
/// size : 0
/// current : 0

class Data {
  Data({
    List<Questions>? questions,
    num? total,
    num? size,
    num? current,}){
    _questions = questions;
    _total = total;
    _size = size;
    _current = current;
  }

  Data.fromJson(dynamic json) {
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions?.add(Questions.fromJson(v));
      });
    }
    _total = json['total'];
    _size = json['size'];
    _current = json['current'];
  }
  List<Questions>? _questions;
  num? _total;
  num? _size;
  num? _current;
  Data copyWith({  List<Questions>? questions,
    num? total,
    num? size,
    num? current,
  }) => Data(  questions: questions ?? _questions,
    total: total ?? _total,
    size: size ?? _size,
    current: current ?? _current,
  );
  List<Questions>? get questions => _questions;
  num? get total => _total;
  num? get size => _size;
  num? get current => _current;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_questions != null) {
      map['questions'] = _questions?.map((v) => v.toJson()).toList();
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
/// createTime : "DateTime"

class Questions {
  Questions({
    num? id,
    num? groupId,
    String? name,
    String? groupName,
    String? img,
    String? createTime,}){
    _id = id;
    _groupId = groupId;
    _name = name;
    _groupName = groupName;
    _img = img;
    _createTime = createTime;
  }

  Questions.fromJson(dynamic json) {
    _id = json['id'];
    _groupId = json['groupId'];
    _name = json['name'];
    _groupName = json['groupName'];
    _img = json['img'];
    _createTime = json['createTime'];
  }
  num? _id;
  num? _groupId;
  String? _name;
  String? _groupName;
  String? _img;
  String? _createTime;
  Questions copyWith({  num? id,
    String? name,
    num? groupId,
    String? groupName,
    String? img,
    String? createTime,
  }) => Questions(
    id: id ?? _id,
    name: name ?? _name,
    groupId: groupId ?? _groupId,
    groupName: groupName ?? _groupName,
    img: img ?? _img,
    createTime: createTime ?? _createTime,
  );
  num? get id => _id;
  String? get name => _name;
  num? get groupId => _groupId;
  String? get groupName => _groupName;
  String? get img => _img;
  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['groupId'] = _groupId;
    map['groupName'] = _groupName;
    map['img'] = _img;
    map['createTime'] = _createTime;
    return map;
  }

}