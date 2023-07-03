/// code : 0
/// msg : "String"
/// data : [{"label":"String","value":"String","description":"String","img":"String","isMust":true}]

class DatagroupDetailResponse {
  int? _code;
  String? _msg;
  List<Data>? _data;

  int? get code => _code;
  String? get msg => _msg;
  List<Data>? get data => _data;

  DatagroupDetailResponse({
      int? code, 
      String? msg, 
      List<Data>? data}){
    _code = code;
    _msg = msg;
    _data = data;
}

  DatagroupDetailResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['obj'] != null) {
      _data = [];
      json['obj'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _msg;
    if (_data != null) {
      map['obj'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// label : "String"
/// value : "String"
/// description : "String"
/// img : "String"
/// isMust : true

class Data {
  String? _label;
  String? _value;
  String? _description;
  String? _img;
  bool? _isMust;

  String? get label => _label;
  String? get value => _value;
  String? get description => _description;
  String? get img => _img;
  bool? get isMust => _isMust;

  Data({
      String? label, 
      String? value, 
      String? description, 
      String? img, 
      bool? isMust}){
    _label = label;
    _value = value;
    _description = description;
    _img = img;
    _isMust = isMust;
}

  Data.fromJson(dynamic json) {
    _label = json['label'];
    _value = json['value'];
    _description = json['description'];
    _img = json['img'];
    _isMust = json['isMust'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['label'] = _label;
    map['value'] = _value;
    map['description'] = _description;
    map['img'] = _img;
    map['isMust'] = _isMust;
    return map;
  }

}