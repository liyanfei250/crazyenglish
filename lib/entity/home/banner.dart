/// code : 0
/// message : "系统正常"
/// obj : [{"id":3,"name":"1","position":2,"positionName":null,"img":"http://cdn-files-test.crazyenglishweekly.com/web/20230521152230.png","externalLinks":null,"appletId":null,"appletPath":null,"beginTime":"2023-05-03","endTime":"2024-05-01","placementTime":null},{"id":4,"name":"2","position":2,"positionName":null,"img":"http://cdn-files-test.crazyenglishweekly.com/web/20230521153439.png","externalLinks":null,"appletId":null,"appletPath":null,"beginTime":"2023-05-03","endTime":"2024-05-01","placementTime":null}]
/// p : null

class Banner {
  Banner({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  Banner.fromJson(dynamic json) {
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
Banner copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => Banner(  code: code ?? _code,
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

/// id : 3
/// name : "1"
/// position : 2
/// positionName : null
/// img : "http://cdn-files-test.crazyenglishweekly.com/web/20230521152230.png"
/// externalLinks : null
/// appletId : null
/// appletPath : null
/// beginTime : "2023-05-03"
/// endTime : "2024-05-01"
/// placementTime : null

class Obj {
  Obj({
      num? id,
      String? name,
      num? position,
      num? type,
      String? positionName,
      String? img,
      String? externalLinks,
      dynamic appletId,
      dynamic appletPath,
      String? beginTime,
      String? endTime,
      dynamic placementTime,}){
    _id = id;
    _name = name;
    _position = position;
    _type = type;
    _positionName = positionName;
    _img = img;
    _externalLinks = externalLinks;
    _appletId = appletId;
    _appletPath = appletPath;
    _beginTime = beginTime;
    _endTime = endTime;
    _placementTime = placementTime;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _position = json['position'];
    _type = json['type'];
    _positionName = json['positionName'];
    _img = json['img'];
    _externalLinks = json['externalLinks'];
    _appletId = json['appletId'];
    _appletPath = json['appletPath'];
    _beginTime = json['beginTime'];
    _endTime = json['endTime'];
    _placementTime = json['placementTime'];
  }
  num? _id;
  String? _name;
  num? _position;
  num? _type;
  String? _positionName;
  String? _img;
  String? _externalLinks;
  dynamic _appletId;
  dynamic _appletPath;
  String? _beginTime;
  String? _endTime;
  dynamic _placementTime;
Obj copyWith({  num? id,
  String? name,
  num? position,
  num? type,
  String? positionName,
  String? img,
  String? externalLinks,
  dynamic appletId,
  dynamic appletPath,
  String? beginTime,
  String? endTime,
  dynamic placementTime,
}) => Obj(  id: id ?? _id,
  name: name ?? _name,
  position: position ?? _position,
  type: type ?? _type,
  positionName: positionName ?? _positionName,
  img: img ?? _img,
  externalLinks: externalLinks ?? _externalLinks,
  appletId: appletId ?? _appletId,
  appletPath: appletPath ?? _appletPath,
  beginTime: beginTime ?? _beginTime,
  endTime: endTime ?? _endTime,
  placementTime: placementTime ?? _placementTime,
);
  num? get id => _id;
  String? get name => _name;
  num? get position => _position;
  num? get type => _type;
  String? get positionName => _positionName;
  String? get img => _img;
  String? get externalLinks => _externalLinks;
  dynamic get appletId => _appletId;
  dynamic get appletPath => _appletPath;
  String? get beginTime => _beginTime;
  String? get endTime => _endTime;
  dynamic get placementTime => _placementTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['position'] = _position;
    map['type'] = _type;
    map['positionName'] = _positionName;
    map['img'] = _img;
    map['externalLinks'] = _externalLinks;
    map['appletId'] = _appletId;
    map['appletPath'] = _appletPath;
    map['beginTime'] = _beginTime;
    map['endTime'] = _endTime;
    map['placementTime'] = _placementTime;
    return map;
  }

}