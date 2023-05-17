/// identity : 1
/// oldPassword : "123456"
/// password : "111111"
/// nickname : "ww"
/// phone : "13866667777"
/// code : "203567"
/// affiliatedGrade : [1648226541879005185]
///
// 该类有手动代码(toJson) 请勿暴力 json转dart
class UpdateUserinfoRequest {
  UpdateUserinfoRequest({
      num? identity, 
      String? oldPassword, 
      String? password, 
      String? nickname, 
      String? phone, 
      String? code, 
      String? url,
      List<num>? affiliatedGrade,}){
    _identity = identity;
    _oldPassword = oldPassword;
    _password = password;
    _nickname = nickname;
    _phone = phone;
    _code = code;
    _url = url;
    _affiliatedGrade = affiliatedGrade;
}

  UpdateUserinfoRequest.fromJson(dynamic json) {
    _identity = json['identity'];
    _oldPassword = json['oldPassword'];
    _password = json['password'];
    _nickname = json['nickname'];
    _phone = json['phone'];
    _code = json['code'];
    _url = json['url'];
    _affiliatedGrade = json['affiliatedGrade'] != null ? json['affiliatedGrade'].cast<num>() : [];
  }
  num? _identity;
  String? _oldPassword;
  String? _password;
  String? _nickname;
  String? _phone;
  String? _code;
  String? _url;
  List<num>? _affiliatedGrade;
UpdateUserinfoRequest copyWith({  num? identity,
  String? oldPassword,
  String? password,
  String? nickname,
  String? phone,
  String? code,
  String? url,
  List<num>? affiliatedGrade,
}) => UpdateUserinfoRequest(  identity: identity ?? _identity,
  oldPassword: oldPassword ?? _oldPassword,
  password: password ?? _password,
  nickname: nickname ?? _nickname,
  phone: phone ?? _phone,
  code: code ?? _code,
  url: url ?? _url,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
);
  num? get identity => _identity;
  String? get oldPassword => _oldPassword;
  String? get password => _password;
  String? get nickname => _nickname;
  String? get phone => _phone;
  String? get code => _code;
  String? get url => _url;
  List<num>? get affiliatedGrade => _affiliatedGrade;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if((_identity??0)>0){
      map['identity'] = _identity;
    }
    if((_oldPassword??"").isNotEmpty){
      map['oldPassword'] = _oldPassword;
      map['password'] = _password;
    }
    if((_nickname??"").isNotEmpty){
      map['nickname'] = _nickname;
    }
    if((_phone??"").isNotEmpty){
      map['phone'] = _phone;
    }
    if((_code??"").isNotEmpty){
      map['code'] = _code;
    }
    if((_url??"").isNotEmpty){
      map['url'] = _url;
    }
    if((_affiliatedGrade??[]).isNotEmpty){
      map['affiliatedGrade'] = _affiliatedGrade;
    }
    return map;
  }

}