/// accessToken : "String"
/// expireIn : 0
/// refreshToken : "String"

class LoginResponse {
  String? _accessToken;
  int? _expireIn;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  int? get expireIn => _expireIn;
  String? get refreshToken => _refreshToken;

  LoginResponse({
      String? accessToken, 
      int? expireIn, 
      String? refreshToken}){
    _accessToken = accessToken;
    _expireIn = expireIn;
    _refreshToken = refreshToken;
}

  LoginResponse.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _expireIn = json['expireIn'];
    _refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['expireIn'] = _expireIn;
    map['refreshToken'] = _refreshToken;
    return map;
  }

}