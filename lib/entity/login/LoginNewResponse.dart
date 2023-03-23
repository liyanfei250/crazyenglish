/// code : 1
/// data : {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtc2ciOiJcIntcXFwidXVpZFxcXCI6XFxcIjIxMzIxMzIxNFxcXCJ9XCIiLCJpYXQiOjE2Nzc2NTM3OTYsImV4cCI6MTY3Nzc0MDE5Nn0.mRCB_lsbC6Uvv5Scb4V0Ru5tLlNvk4HWNNy9JmkQ9Vs"}
/// msg : ""

class LoginNewResponse {
  int? _code;
  String? _msg;
  Data? _data;

  int? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  LoginNewResponse({
    int? code,
    String? msg,
    Data? data}){
    _code = code;
    _msg = msg;
    _data = data;
  }

  LoginNewResponse.fromJson(dynamic json) {
    print("response =="+json.toString());
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
  String? _accessToken;

  String? get accessToken => _accessToken;

  Data({
    String? accessToken,
  }) {
    _accessToken = accessToken;
  }

  Data.fromJson(dynamic json) {
    print("response =="+json.toString());
    _accessToken = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['token'] = _accessToken;
    return map;
  }

}