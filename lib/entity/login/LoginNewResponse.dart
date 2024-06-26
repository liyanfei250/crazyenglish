import '../base_resp.dart';

/// code : 1
/// data : {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtc2ciOiJcIntcXFwidXVpZFxcXCI6XFxcIjIxMzIxMzIxNFxcXCJ9XCIiLCJpYXQiOjE2Nzc2NTM3OTYsImV4cCI6MTY3Nzc0MDE5Nn0.mRCB_lsbC6Uvv5Scb4V0Ru5tLlNvk4HWNNy9JmkQ9Vs"}
/// msg : ""

class LoginNewResponse extends BaseResp{
  Data? _obj;

  Data? get data => _obj;

  LoginNewResponse({
    int? code,
    String? msg,
    Data? data}):super(code,msg){
    _obj = data;
  }

  LoginNewResponse.fromJson(dynamic json):super.fromJson(json) {
    print("response =="+json.toString());
    _obj = json['obj'] != null ? Data.fromJson(json['obj']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (_obj != null) {
      map['obj'] = _obj?.toJson();
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
    _accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    return map;
  }

}