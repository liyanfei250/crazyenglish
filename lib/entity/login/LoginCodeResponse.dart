import '../base_resp.dart';

/// code : 1
/// data : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtc2ciOiJcIntcXFwidXVpZFxcXCI6XFxcImQ4NWM2NjgwLWI2NzAtMTFlZC05MDA1LTc1YTUwYzc4NzNkNVxcXCJ9XCIiLCJpYXQiOjE2Nzc2NjEzNjcsImV4cCI6MTY3Nzc0Nzc2N30.5q-Q-FCZ8f4EdA5LTFmdN6hwD4jM8OzHJue_pYSIECo"
/// msg : ""

class LoginCodeResponse extends BaseResp{
  LoginCodeResponse({
      num? code, 
      String? data, 
      String? msg,}):super(code,msg){
    _data = data;
}

  LoginCodeResponse.fromJson(dynamic json):super.fromJson(json) {
    _data = json['obj'];
  }
  String? _data;
LoginCodeResponse copyWith({  num? code,
  String? data,
  String? msg,
}) => LoginCodeResponse(  code: code ?? code,
  data: data ?? _data,
  msg: msg ?? msg,
);
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['obj'] = _data;
    map['message'] = message;
    return map;
  }

}