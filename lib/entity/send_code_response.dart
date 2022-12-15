/// code : "OK"
/// message : "OK"

class SendCodeResponse {
  String? _code;
  String? _message;

  String? get code => _code;
  String? get message => _message;

  SendCodeResponse({
      String? code, 
      String? message}){
    _code = code;
    _message = message;
}

  SendCodeResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }

}