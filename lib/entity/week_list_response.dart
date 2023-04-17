import 'base_resp.dart';

/// code : 1
/// data : {"count":1,"rows":[{"uuid":"97a4d850-b82f-11ed-a635-7735a2808abc","name":"英语周报新目标第二十三坎","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/c86f6370-b824-11ed-a987-e7929c6b8af4tiancaiTORID%E6%B5%81%E7%A8%8B%E5%9B%BE%20%281%29.png","weekTime":"2023-03-15T16:00:00.000Z","see":0}]}
/// msg : ""

class WeekListResponse extends BaseResp{
  WeekListResponse({
      num? code, 
      Data? data, 
      String? msg,}):super(code,msg){
    _code = code;
    _data = data;
    _msg = msg;
}

  WeekListResponse.fromJson(dynamic json):super.fromJson(json)  {
    _code = json['code'];
    _data = json['obj'] != null ? Data.fromJson(json['obj']) : null;
    _msg = json['msg'];
  }

  @override
  WeekListResponse fromJson(dynamic) {
    return WeekListResponse.fromJson(dynamic);
  }

  num? _code;
  Data? _data;
  String? _msg;
WeekListResponse copyWith({  num? code,
  Data? data,
  String? msg,
}) => WeekListResponse(  code: code ?? _code,
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
      map['obj'] = _data?.toJson();
    }
    map['message'] = _msg;
    return map;
  }

}

/// count : 1
/// rows : [{"uuid":"97a4d850-b82f-11ed-a635-7735a2808abc","name":"英语周报新目标第二十三坎","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/c86f6370-b824-11ed-a987-e7929c6b8af4tiancaiTORID%E6%B5%81%E7%A8%8B%E5%9B%BE%20%281%29.png","weekTime":"2023-03-15T16:00:00.000Z","see":0}]

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

/// uuid : "97a4d850-b82f-11ed-a635-7735a2808abc"
/// name : "英语周报新目标第二十三坎"
/// img : "https://test-1315843937.cos.ap-beijing.myqcloud.com/c86f6370-b824-11ed-a987-e7929c6b8af4tiancaiTORID%E6%B5%81%E7%A8%8B%E5%9B%BE%20%281%29.png"
/// weekTime : "2023-03-15T16:00:00.000Z"
/// see : 0

class Rows {
  Rows({
      String? uuid, 
      String? name, 
      String? img, 
      String? weekTime, 
      num? see,}){
    _uuid = uuid;
    _name = name;
    _img = img;
    _weekTime = weekTime;
    _see = see;
}

  Rows.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _name = json['name'];
    _img = json['img'];
    _weekTime = json['weekTime'];
    _see = json['see'];
  }
  String? _uuid;
  String? _name;
  String? _img;
  String? _weekTime;
  num? _see;
Rows copyWith({  String? uuid,
  String? name,
  String? img,
  String? weekTime,
  num? see,
}) => Rows(  uuid: uuid ?? _uuid,
  name: name ?? _name,
  img: img ?? _img,
  weekTime: weekTime ?? _weekTime,
  see: see ?? _see,
);
  String? get uuid => _uuid;
  String? get name => _name;
  String? get img => _img;
  String? get weekTime => _weekTime;
  num? get see => _see;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['name'] = _name;
    map['img'] = _img;
    map['weekTime'] = _weekTime;
    map['see'] = _see;
    return map;
  }

}