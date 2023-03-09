/// code : 1
/// data : {"count":1,"rows":[{"date":"2023.03.09","list":[{"createdAt":"2023-03-09T07:46:13.000Z","uuid":"777e5d10-be4e-11ed-850e-43b63cbd7be7","weekly_name":"测试全部题型用","directory_name":"看图选择","exercises_success":3,"exercises_total":19},{"createdAt":"2023-03-09T07:46:02.000Z","uuid":"707ead30-be4e-11ed-850e-43b63cbd7be7","weekly_name":"测试全部题型用","directory_name":"看图选择","exercises_success":3,"exercises_total":19}]}],"exercises_total":38}
/// msg : ""

class PracticeListResponse {
  PracticeListResponse({
      num? code, 
      Data? data, 
      String? msg,}){
    _code = code;
    _data = data;
    _msg = msg;
}

  PracticeListResponse.fromJson(dynamic json) {
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  num? _code;
  Data? _data;
  String? _msg;
PracticeListResponse copyWith({  num? code,
  Data? data,
  String? msg,
}) => PracticeListResponse(  code: code ?? _code,
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
/// rows : [{"date":"2023.03.09","list":[{"createdAt":"2023-03-09T07:46:13.000Z","uuid":"777e5d10-be4e-11ed-850e-43b63cbd7be7","weekly_name":"测试全部题型用","directory_name":"看图选择","exercises_success":3,"exercises_total":19},{"createdAt":"2023-03-09T07:46:02.000Z","uuid":"707ead30-be4e-11ed-850e-43b63cbd7be7","weekly_name":"测试全部题型用","directory_name":"看图选择","exercises_success":3,"exercises_total":19}]}]
/// exercises_total : 38

class Data {
  Data({
      num? count, 
      List<Rows>? rows, 
      num? exercisesTotal,}){
    _count = count;
    _rows = rows;
    _exercisesTotal = exercisesTotal;
}

  Data.fromJson(dynamic json) {
    _count = json['count'];
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
    _exercisesTotal = json['exercises_total'];
  }
  num? _count;
  List<Rows>? _rows;
  num? _exercisesTotal;
Data copyWith({  num? count,
  List<Rows>? rows,
  num? exercisesTotal,
}) => Data(  count: count ?? _count,
  rows: rows ?? _rows,
  exercisesTotal: exercisesTotal ?? _exercisesTotal,
);
  num? get count => _count;
  List<Rows>? get rows => _rows;
  num? get exercisesTotal => _exercisesTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    map['exercises_total'] = _exercisesTotal;
    return map;
  }

}

/// date : "2023.03.09"
/// list : [{"createdAt":"2023-03-09T07:46:13.000Z","uuid":"777e5d10-be4e-11ed-850e-43b63cbd7be7","weekly_name":"测试全部题型用","directory_name":"看图选择","exercises_success":3,"exercises_total":19},{"createdAt":"2023-03-09T07:46:02.000Z","uuid":"707ead30-be4e-11ed-850e-43b63cbd7be7","weekly_name":"测试全部题型用","directory_name":"看图选择","exercises_success":3,"exercises_total":19}]

class Rows {
  Rows({
      String? date, 
      List<ListBean>? list,}){
    _date = date;
    _list = list;
}

  Rows.fromJson(dynamic json) {
    _date = json['date'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(ListBean.fromJson(v));
      });
    }
  }
  String? _date;
  List<ListBean>? _list;
Rows copyWith({  String? date,
  List<ListBean>? list,
}) => Rows(  date: date ?? _date,
  list: list ?? _list,
);
  String? get date => _date;
  List<ListBean>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// createdAt : "2023-03-09T07:46:13.000Z"
/// uuid : "777e5d10-be4e-11ed-850e-43b63cbd7be7"
/// weekly_name : "测试全部题型用"
/// directory_name : "看图选择"
/// exercises_success : 3
/// exercises_total : 19

class ListBean {
  ListBean({
      String? createdAt, 
      String? uuid, 
      String? weeklyName, 
      String? directoryName, 
      num? exercisesSuccess, 
      num? exercisesTotal,}){
    _createdAt = createdAt;
    _uuid = uuid;
    _weeklyName = weeklyName;
    _directoryName = directoryName;
    _exercisesSuccess = exercisesSuccess;
    _exercisesTotal = exercisesTotal;
}

  ListBean.fromJson(dynamic json) {
    _createdAt = json['createdAt'];
    _uuid = json['uuid'];
    _weeklyName = json['weekly_name'];
    _directoryName = json['directory_name'];
    _exercisesSuccess = json['exercises_success'];
    _exercisesTotal = json['exercises_total'];
  }
  String? _createdAt;
  String? _uuid;
  String? _weeklyName;
  String? _directoryName;
  num? _exercisesSuccess;
  num? _exercisesTotal;
  ListBean copyWith({  String? createdAt,
  String? uuid,
  String? weeklyName,
  String? directoryName,
  num? exercisesSuccess,
  num? exercisesTotal,
}) => ListBean(  createdAt: createdAt ?? _createdAt,
  uuid: uuid ?? _uuid,
  weeklyName: weeklyName ?? _weeklyName,
  directoryName: directoryName ?? _directoryName,
  exercisesSuccess: exercisesSuccess ?? _exercisesSuccess,
  exercisesTotal: exercisesTotal ?? _exercisesTotal,
);
  String? get createdAt => _createdAt;
  String? get uuid => _uuid;
  String? get weeklyName => _weeklyName;
  String? get directoryName => _directoryName;
  num? get exercisesSuccess => _exercisesSuccess;
  num? get exercisesTotal => _exercisesTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = _createdAt;
    map['uuid'] = _uuid;
    map['weekly_name'] = _weeklyName;
    map['directory_name'] = _directoryName;
    map['exercises_success'] = _exercisesSuccess;
    map['exercises_total'] = _exercisesTotal;
    return map;
  }

}