/// code : 1
/// data : [{"uuid":"97a59ba0-b82f-11ed-a635-7735a2808abc","name":"第一部分听力（共两节， 满分 30 分 ）","sort":214,"parentId":"97a4d850-b82f-11ed-a635-7735a2808abc","childList":[{"uuid":"97a59ba1-b82f-11ed-a635-7735a2808abc","name":"第一节 （共5小题；每小题1.5分，满分7.5分）","sort":215,"parentId":"97a59ba0-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a5c2b0-b82f-11ed-a635-7735a2808abc","name":"第二节 （共15小题；每小题1.5分，满分22.5分）","sort":216,"parentId":"97a59ba0-b82f-11ed-a635-7735a2808abc","childList":[]}]},{"uuid":"97a5c2b1-b82f-11ed-a635-7735a2808abc","name":"第二部分阅读理解（共两节，满分40分）","sort":217,"parentId":"97a4d850-b82f-11ed-a635-7735a2808abc","childList":[{"uuid":"97a5c2b2-b82f-11ed-a635-7735a2808abc","name":"第一节A篇 （共3小题；每小题2分，满分6分）","sort":218,"parentId":"97a5c2b1-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a5c2b3-b82f-11ed-a635-7735a2808abc","name":"第一节B篇 （共4小题；每小题2分，满分8分）","sort":219,"parentId":"97a5c2b1-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a5c2b4-b82f-11ed-a635-7735a2808abc","name":"第一节C篇 （共4小题；每小题2分，满分8分）","sort":220,"parentId":"97a5c2b1-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a5c2b5-b82f-11ed-a635-7735a2808abc","name":"第一节D篇 （共4小题；每小题2分，满分8分）","sort":221,"parentId":"97a5c2b1-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a5e9c0-b82f-11ed-a635-7735a2808abc","name":"第二节 （共5小题；每小题2分，满分10分）","sort":222,"parentId":"97a5c2b1-b82f-11ed-a635-7735a2808abc","childList":[]}]},{"uuid":"97a5e9c1-b82f-11ed-a635-7735a2808abc","name":"第三部分语言知识运用（共两节，满分45 分）","sort":223,"parentId":"97a4d850-b82f-11ed-a635-7735a2808abc","childList":[{"uuid":"97a5e9c2-b82f-11ed-a635-7735a2808abc","name":"第一节 （共20小题；每小题1.5分，满分30分）","sort":224,"parentId":"97a5e9c1-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a5e9c3-b82f-11ed-a635-7735a2808abc","name":"第二节 （共10小题；每小题1.5分，满分15分）","sort":225,"parentId":"97a5e9c1-b82f-11ed-a635-7735a2808abc","childList":[]}]},{"uuid":"97a5e9c4-b82f-11ed-a635-7735a2808abc","name":"第四部分写作（共两节，满分35分）","sort":226,"parentId":"97a4d850-b82f-11ed-a635-7735a2808abc","childList":[{"uuid":"97a5e9c5-b82f-11ed-a635-7735a2808abc","name":"第一节 短文改错 （共10小题；每小题1分，满分10分）","sort":227,"parentId":"97a5e9c4-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a610d0-b82f-11ed-a635-7735a2808abc","name":"第二节 书面表达 （满分25分）","sort":228,"parentId":"97a5e9c4-b82f-11ed-a635-7735a2808abc","childList":[]}]}]
/// msg : ""

class WeekDirectoryResponse {
  WeekDirectoryResponse({
      num? code, 
      List<Data>? data, 
      String? msg,}){
    _code = code;
    _data = data;
    _msg = msg;
}

  WeekDirectoryResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  num? _code;
  List<Data>? _data;
  String? _msg;
WeekDirectoryResponse copyWith({  num? code,
  List<Data>? data,
  String? msg,
}) => WeekDirectoryResponse(  code: code ?? _code,
  data: data ?? _data,
  msg: msg ?? _msg,
);
  num? get code => _code;
  List<Data>? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

/// uuid : "97a59ba0-b82f-11ed-a635-7735a2808abc"
/// name : "第一部分听力（共两节， 满分 30 分 ）"
/// sort : 214
/// parentId : "97a4d850-b82f-11ed-a635-7735a2808abc"
/// childList : [{"uuid":"97a59ba1-b82f-11ed-a635-7735a2808abc","name":"第一节 （共5小题；每小题1.5分，满分7.5分）","sort":215,"parentId":"97a59ba0-b82f-11ed-a635-7735a2808abc","childList":[]},{"uuid":"97a5c2b0-b82f-11ed-a635-7735a2808abc","name":"第二节 （共15小题；每小题1.5分，满分22.5分）","sort":216,"parentId":"97a59ba0-b82f-11ed-a635-7735a2808abc","childList":[]}]

class Data {
  Data({
      String? uuid, 
      String? name, 
      num? sort, 
      String? parentId, 
      List<Data>? childList,}){
    _uuid = uuid;
    _name = name;
    _sort = sort;
    _parentId = parentId;
    _childList = childList;
}

  Data.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _name = json['name'];
    _sort = json['sort'];
    _parentId = json['parentId'];
    if (json['childList'] != null) {
      _childList = [];
      json['childList'].forEach((v) {
        _childList?.add(Data.fromJson(v));
      });
    }
  }
  String? _uuid;
  String? _name;
  num? _sort;
  String? _parentId;
  List<Data>? _childList;
Data copyWith({  String? uuid,
  String? name,
  num? sort,
  String? parentId,
  List<Data>? childList,
}) => Data(  uuid: uuid ?? _uuid,
  name: name ?? _name,
  sort: sort ?? _sort,
  parentId: parentId ?? _parentId,
  childList: childList ?? _childList,
);
  String? get uuid => _uuid;
  String? get name => _name;
  num? get sort => _sort;
  String? get parentId => _parentId;
  List<Data>? get childList => _childList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['name'] = _name;
    map['sort'] = _sort;
    map['parentId'] = _parentId;
    if (_childList != null) {
      map['childList'] = _childList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}