/// code : 1
/// msg : "系统正常"
/// data : [{"id":25,"periodicalId":12,"parentId":0,"name":"第四篇","sort":12,"createTime":"2022-12-31T11:48:22.000+00:00","childList":[{"id":27,"periodicalId":12,"parentId":25,"name":"第一章节","sort":1,"createTime":"2022-12-31T12:03:31.000+00:00","childList":[{"id":34,"periodicalId":12,"parentId":27,"name":"第一节","sort":4,"createTime":"2022-12-31T14:41:35.000+00:00","childList":[]},{"id":35,"periodicalId":12,"parentId":27,"name":"第二节","sort":1,"createTime":"2022-12-31T14:42:41.000+00:00","childList":[]},{"id":39,"periodicalId":12,"parentId":27,"name":"第三节","sort":2,"createTime":"2022-12-31T16:18:10.000+00:00","childList":[]}]}]}]

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

/// id : 25
/// periodicalId : 12
/// parentId : 0
/// name : "第四篇"
/// sort : 12
/// createTime : "2022-12-31T11:48:22.000+00:00"
/// childList : [{"id":27,"periodicalId":12,"parentId":25,"name":"第一章节","sort":1,"createTime":"2022-12-31T12:03:31.000+00:00","childList":[{"id":34,"periodicalId":12,"parentId":27,"name":"第一节","sort":4,"createTime":"2022-12-31T14:41:35.000+00:00","childList":[]},{"id":35,"periodicalId":12,"parentId":27,"name":"第二节","sort":1,"createTime":"2022-12-31T14:42:41.000+00:00","childList":[]},{"id":39,"periodicalId":12,"parentId":27,"name":"第三节","sort":2,"createTime":"2022-12-31T16:18:10.000+00:00","childList":[]}]}]

class Data {
  int? _id;
  int? _periodicalId;
  int? _parentId;
  String? _name;
  int? _sort;
  String? _createTime;
  List<Data>? _childList;

  int? get id => _id;
  int? get periodicalId => _periodicalId;
  int? get parentId => _parentId;
  String? get name => _name;
  int? get sort => _sort;
  String? get createTime => _createTime;
  List<Data>? get childList => _childList;

  Data({
      int? id, 
      int? periodicalId, 
      int? parentId, 
      String? name, 
      int? sort, 
      String? createTime, 
      List<Data>? childList}){
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
    if (json['childList'] != null) {
      _childList = [];
      json['childList'].forEach((v) {
        _childList?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['periodicalId'] = _periodicalId;
    map['parentId'] = _parentId;
    map['name'] = _name;
    map['sort'] = _sort;
    map['createTime'] = _createTime;
    if (_childList != null) {
      map['childList'] = _childList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

///