/// code : 1
/// data : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtc2ciOiJcIntcXFwidXVpZFxcXCI6XFxcImQ4NWM2NjgwLWI2NzAtMTFlZC05MDA1LTc1YTUwYzc4NzNkNVxcXCJ9XCIiLCJpYXQiOjE2Nzc2NjEzNjcsImV4cCI6MTY3Nzc0Nzc2N30.5q-Q-FCZ8f4EdA5LTFmdN6hwD4jM8OzHJue_pYSIECo"
/// msg : ""

class LoginCodeResponse {
  LoginCodeResponse({
      num? code, 
      String? data, 
      String? msg,}){
    _code = code;
    _data = data;
    _msg = msg;
}

  LoginCodeResponse.fromJson(dynamic json) {
    _code = json['code'];
    _data = json['data'];
    _msg = json['msg'];
  }
  num? _code;
  String? _data;
  String? _msg;
LoginCodeResponse copyWith({  num? code,
  String? data,
  String? msg,
}) => LoginCodeResponse(  code: code ?? _code,
  data: data ?? _data,
  msg: msg ?? _msg,
);
  num? get code => _code;
  String? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['data'] = _data;
    map['msg'] = _msg;
    return map;
  }

}