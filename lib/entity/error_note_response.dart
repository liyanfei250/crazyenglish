/// code : 1
/// data : {"count":1,"rows":[{"uuid":"c36ee3b0-bd6e-11ed-ae3c-85d1093b78b2","name":"测试全部题型用","nameTitle":"测试期数","lastTime":"2023-03-08T05:55:20.000Z","directory":[{"uuid":"c378a7b0-bd6e-11ed-ae3c-85d1093b78b2","name":"对话理解","correction":0,"exercises_total":1,"exercises_success":0},{"uuid":"cf445a60-bd75-11ed-b4f2-f13a1127ad8d","name":"看图选择","correction":0,"exercises_total":1,"exercises_success":0}]}]}
/// msg : ""

class ErrorNoteResponse {
  ErrorNoteResponse({
      num? code, 
      Data? data, 
      String? msg,}){
    _code = code;
    _data = data;
    _msg = msg;
}

  ErrorNoteResponse.fromJson(dynamic json) {
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  num? _code;
  Data? _data;
  String? _msg;
ErrorNoteResponse copyWith({  num? code,
  Data? data,
  String? msg,
}) => ErrorNoteResponse(  code: code ?? _code,
  data: data ?? _data,
  msg: msg ?? _msg,
);
  num? get code => _code;
  Data? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['msg'] = _msg;
    return map;
  }

}

/// count : 1
/// rows : [{"uuid":"c36ee3b0-bd6e-11ed-ae3c-85d1093b78b2","name":"测试全部题型用","nameTitle":"测试期数","lastTime":"2023-03-08T05:55:20.000Z","directory":[{"uuid":"c378a7b0-bd6e-11ed-ae3c-85d1093b78b2","name":"对话理解","correction":0,"exercises_total":1,"exercises_success":0},{"uuid":"cf445a60-bd75-11ed-b4f2-f13a1127ad8d","name":"看图选择","correction":0,"exercises_total":1,"exercises_success":0}]}]

class Data {
  Data({
      num? count, 
      List<Rows>? rows,}){
    _count = count;
    _rows = rows;
}

  Data.fromJson(dynamic json) {
    _count = json['count'];
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
  }
  num? _count;
  List<Rows>? _rows;
Data copyWith({  num? count,
  List<Rows>? rows,
}) => Data(  count: count ?? _count,
  rows: rows ?? _rows,
);
  num? get count => _count;
  List<Rows>? get rows => _rows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// uuid : "c36ee3b0-bd6e-11ed-ae3c-85d1093b78b2"
/// name : "测试全部题型用"
/// nameTitle : "测试期数"
/// lastTime : "2023-03-08T05:55:20.000Z"
/// directory : [{"uuid":"c378a7b0-bd6e-11ed-ae3c-85d1093b78b2","name":"对话理解","correction":0,"exercises_total":1,"exercises_success":0},{"uuid":"cf445a60-bd75-11ed-b4f2-f13a1127ad8d","name":"看图选择","correction":0,"exercises_total":1,"exercises_success":0}]

class Rows {
  Rows({
      String? uuid, 
      String? name, 
      String? nameTitle, 
      String? lastTime, 
      List<Directory>? directory,}){
    _uuid = uuid;
    _name = name;
    _nameTitle = nameTitle;
    _lastTime = lastTime;
    _directory = directory;
}

  Rows.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _name = json['name'];
    _nameTitle = json['nameTitle'];
    _lastTime = json['lastTime'];
    if (json['directory'] != null) {
      _directory = [];
      json['directory'].forEach((v) {
        _directory?.add(Directory.fromJson(v));
      });
    }
  }
  String? _uuid;
  String? _name;
  String? _nameTitle;
  String? _lastTime;
  List<Directory>? _directory;
Rows copyWith({  String? uuid,
  String? name,
  String? nameTitle,
  String? lastTime,
  List<Directory>? directory,
}) => Rows(  uuid: uuid ?? _uuid,
  name: name ?? _name,
  nameTitle: nameTitle ?? _nameTitle,
  lastTime: lastTime ?? _lastTime,
  directory: directory ?? _directory,
);
  String? get uuid => _uuid;
  String? get name => _name;
  String? get nameTitle => _nameTitle;
  String? get lastTime => _lastTime;
  List<Directory>? get directory => _directory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['name'] = _name;
    map['nameTitle'] = _nameTitle;
    map['lastTime'] = _lastTime;
    if (_directory != null) {
      map['directory'] = _directory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// uuid : "c378a7b0-bd6e-11ed-ae3c-85d1093b78b2"
/// name : "对话理解"
/// correction : 0
/// exercises_total : 1
/// exercises_success : 0

class Directory {
  Directory({
      String? uuid, 
      String? name, 
      num? correction, 
      num? exercisesTotal, 
      num? exercisesSuccess,}){
    _uuid = uuid;
    _name = name;
    _correction = correction;
    _exercisesTotal = exercisesTotal;
    _exercisesSuccess = exercisesSuccess;
}

  Directory.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _name = json['name'];
    _correction = json['correction'];
    _exercisesTotal = json['exercises_total'];
    _exercisesSuccess = json['exercises_success'];
  }
  String? _uuid;
  String? _name;
  num? _correction;
  num? _exercisesTotal;
  num? _exercisesSuccess;
Directory copyWith({  String? uuid,
  String? name,
  num? correction,
  num? exercisesTotal,
  num? exercisesSuccess,
}) => Directory(  uuid: uuid ?? _uuid,
  name: name ?? _name,
  correction: correction ?? _correction,
  exercisesTotal: exercisesTotal ?? _exercisesTotal,
  exercisesSuccess: exercisesSuccess ?? _exercisesSuccess,
);
  String? get uuid => _uuid;
  String? get name => _name;
  num? get correction => _correction;
  num? get exercisesTotal => _exercisesTotal;
  num? get exercisesSuccess => _exercisesSuccess;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['name'] = _name;
    map['correction'] = _correction;
    map['exercises_total'] = _exercisesTotal;
    map['exercises_success'] = _exercisesSuccess;
    return map;
  }

}