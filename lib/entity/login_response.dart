/// code : 1
/// msg : "系统正常"
/// data : {"expireIn":604799,"accessToken":"192710cd-47b5-4abb-b86e-98b7d2651b99","refreshToken":"a0b05f3e-7f63-45df-b1d9-8bb24165bd2d"}

class LoginResponse {
  int? _code;
  String? _msg;
  Data? _data;

  int? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  LoginResponse({
      int? code, 
      String? msg, 
      Data? data}){
    _code = code;
    _msg = msg;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// expireIn : 604799
/// accessToken : "192710cd-47b5-4abb-b86e-98b7d2651b99"
/// refreshToken : "a0b05f3e-7f63-45df-b1d9-8bb24165bd2d"

class Data {
  int? _expireIn;
  String? _accessToken;
  String? _refreshToken;

  int? get expireIn => _expireIn;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  Data({
      int? expireIn, 
      String? accessToken, 
      String? refreshToken}){
    _expireIn = expireIn;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
}

  Data.fromJson(dynamic json) {
    _expireIn = json['expireIn'];
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['expireIn'] = _expireIn;
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    return map;
  }

}