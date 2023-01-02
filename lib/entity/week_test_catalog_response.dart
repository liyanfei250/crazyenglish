/// code : 0
/// msg : "String"
/// data : [{"id":0,"periodicalId":0,"parentId":0,"name":"String","sort":0,"createTime":"DateTime","childList":null}]

class WeekTestCatalogResponse {
  int? _code;
  String? _msg;
  List<Data>? _data;

  int? get code => _code;
  String? get msg => _msg;
  List<Data>? get data => _data;

  WeekTestCatalogResponse({
      int? code, 
      String? msg, 
      List<Data>? data}){
    _code = code;
    _msg = msg;
    _data = data;
}

  WeekTestCatalogResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// periodicalId : 0
/// parentId : 0
/// name : "String"
/// sort : 0
/// createTime : "DateTime"
/// childList : null

class Data {
  int? _id;
  int? _periodicalId;
  int? _parentId;
  String? _name;
  int? _sort;
  String? _createTime;
  dynamic? _childList;

  int? get id => _id;
  int? get periodicalId => _periodicalId;
  int? get parentId => _parentId;
  String? get name => _name;
  int? get sort => _sort;
  String? get createTime => _createTime;
  dynamic? get childList => _childList;

  Data({
      int? id, 
      int? periodicalId, 
      int? parentId, 
      String? name, 
      int? sort, 
      String? createTime, 
      dynamic? childList}){
    _id = id;
    _periodicalId = periodicalId;
    _parentId = parentId;
    _name = name;
    _sort = sort;
    _createTime = createTime;
    _childList = childList;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _periodicalId = json['periodicalId'];
    _parentId = json['parentId'];
    _name = json['name'];
    _sort = json['sort'];
    _createTime = json['createTime'];
    _childList = json['childList'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['periodicalId'] = _periodicalId;
    map['parentId'] = _parentId;
    map['name'] = _name;
    map['sort'] = _sort;
    map['createTime'] = _createTime;
    map['childList'] = _childList;
    return map;
  }

}