/// code : 0
/// message : "success"
/// sid : "tts000eb834@dx18113f02d1d6f2c902"
/// data : {"audio":""}

/// 作者： lixp
/// 创建时间： 2022/6/1 14:04
/// 类介绍：讯飞返回数据类
class XfRes {
  XfRes({
      int? code, 
      String? message, 
      String? sid, 
      Data? data,}){
    _code = code;
    _message = message;
    _sid = sid;
    _data = data;
}

  XfRes.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _sid = json['sid'];
    _data = json['obj'] != null ? Data.fromJson(json['obj']) : null;
  }
  int? _code;
  String? _message;
  String? _sid;
  Data? _data;

  int? get code => _code;
  String? get message => _message;
  String? get sid => _sid;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['sid'] = _sid;
    if (_data != null) {
      map['obj'] = _data?.toJson();
    }
    return map;
  }

}

/// audio : ""

class Data {
  Data({
      String? audio,}){
    _audio = audio;
}

  Data.fromJson(dynamic json) {
    _audio = json['audio'];
  }
  String? _audio;

  String? get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['audio'] = _audio;
    return map;
  }

}