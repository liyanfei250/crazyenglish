/// code : 0
/// msg : "String"
/// data : {"history":[{"id":0,"name":"String","img":"String","createTime":"DateTime"}],"total":0,"size":0,"current":0}

class HomeworkHistoryResponse {
  HomeworkHistoryResponse({
      num? code, 
      String? msg, 
      Data? data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  HomeworkHistoryResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['obj'] != null ? Data.fromJson(json['obj']) : null;
  }
  num? _code;
  String? _msg;
  Data? _data;
HomeworkHistoryResponse copyWith({  num? code,
  String? msg,
  Data? data,
}) => HomeworkHistoryResponse(  code: code ?? _code,
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

/// history : [{"id":0,"name":"String","img":"String","createTime":"DateTime"}]
/// total : 0
/// size : 0
/// current : 0

class Data {
  Data({
      List<History>? history, 
      num? total, 
      num? size, 
      num? current,}){
    _history = history;
    _total = total;
    _size = size;
    _current = current;
}

  Data.fromJson(dynamic json) {
    if (json['history'] != null) {
      _history = [];
      json['history'].forEach((v) {
        _history?.add(History.fromJson(v));
      });
    }
    _total = json['total'];
    _size = json['size'];
    _current = json['current'];
  }
  List<History>? _history;
  num? _total;
  num? _size;
  num? _current;
Data copyWith({  List<History>? history,
  num? total,
  num? size,
  num? current,
}) => Data(  history: history ?? _history,
  total: total ?? _total,
  size: size ?? _size,
  current: current ?? _current,
);
  List<History>? get history => _history;
  num? get total => _total;
  num? get size => _size;
  num? get current => _current;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_history != null) {
      map['history'] = _history?.map((v) => v.toJson()).toList();
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

class History {
  History({
      num? id, 
      String? name, 
      String? img, 
      String? createTime,}){
    _id = id;
    _name = name;
    _img = img;
    _createTime = createTime;
}

  History.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _img = json['img'];
    _createTime = json['createTime'];
  }
  num? _id;
  String? _name;
  String? _img;
  String? _createTime;
History copyWith({  num? id,
  String? name,
  String? img,
  String? createTime,
}) => History(  id: id ?? _id,
  name: name ?? _name,
  img: img ?? _img,
  createTime: createTime ?? _createTime,
);
  num? get id => _id;
  String? get name => _name;
  String? get img => _img;
  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['img'] = _img;
    map['createTime'] = _createTime;
    return map;
  }

}