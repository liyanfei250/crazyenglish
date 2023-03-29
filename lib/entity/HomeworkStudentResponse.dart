/// code : 0
/// msg : "String"
/// data : {"students":[{"id":0,"name":"String","img":"String","createTime":"DateTime"}],"total":0,"size":0,"current":0}

class HomeworkStudentResponse {
  HomeworkStudentResponse({
      num? code, 
      String? msg, 
      Data? data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  HomeworkStudentResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _msg;
  Data? _data;
HomeworkStudentResponse copyWith({  num? code,
  String? msg,
  Data? data,
}) => HomeworkStudentResponse(  code: code ?? _code,
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

/// students : [{"id":0,"name":"String","img":"String","createTime":"DateTime"}]
/// total : 0
/// size : 0
/// current : 0

class Data {
  Data({
      List<Students>? students, 
      num? total, 
      num? size, 
      num? current,}){
    _students = students;
    _total = total;
    _size = size;
    _current = current;
}

  Data.fromJson(dynamic json) {
    if (json['students'] != null) {
      _students = [];
      json['students'].forEach((v) {
        _students?.add(Students.fromJson(v));
      });
    }
    _total = json['total'];
    _size = json['size'];
    _current = json['current'];
  }
  List<Students>? _students;
  num? _total;
  num? _size;
  num? _current;
Data copyWith({  List<Students>? students,
  num? total,
  num? size,
  num? current,
}) => Data(  students: students ?? _students,
  total: total ?? _total,
  size: size ?? _size,
  current: current ?? _current,
);
  List<Students>? get students => _students;
  num? get total => _total;
  num? get size => _size;
  num? get current => _current;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_students != null) {
      map['students'] = _students?.map((v) => v.toJson()).toList();
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

class Students {
  Students({
      num? id, 
      String? name, 
      String? img, 
      String? createTime,}){
    _id = id;
    _name = name;
    _img = img;
    _createTime = createTime;
}

  Students.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _img = json['img'];
    _createTime = json['createTime'];
  }
  num? _id;
  String? _name;
  String? _img;
  String? _createTime;
Students copyWith({  num? id,
  String? name,
  String? img,
  String? createTime,
}) => Students(  id: id ?? _id,
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