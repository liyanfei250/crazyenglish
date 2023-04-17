import 'base_resp.dart';

/// code : 1
/// data : {"uuid":"09aae430-b812-11ed-90c4-ef9a5923117d","username":null,"avatar":null,"nickname":null,"identity":3,"grade":12}
/// msg : ""

class UserInfoResponse extends BaseResp{
  UserInfoResponse({
      num? code,
      Data? data,
      String? msg,}):super(code,msg){
    _data = data;
}

  UserInfoResponse.fromJson(dynamic json):super.fromJson(json) {
    _data = json['obj'] != null ? Data.fromJson(json['obj']) : null;
  }
  Data? _data;
UserInfoResponse copyWith({  num? code,
  Data? data,
  String? msg,
}) => UserInfoResponse(  code: code ?? code,
  data: data ?? _data,
  msg: msg ?? message,
);
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (_data != null) {
      map['obj'] = _data?.toJson();
    }
    map['message'] = message;
    return map;
  }

}

/// uuid : "09aae430-b812-11ed-90c4-ef9a5923117d"
/// username : null
/// avatar : null
/// nickname : null
/// identity : 3
/// grade : 12

class Data {
  Data({
      String? uuid, 
      dynamic username, 
      dynamic avatar, 
      dynamic nickname, 
      num? identity, 
      num? grade,}){
    _uuid = uuid;
    _username = username;
    _avatar = avatar;
    _nickname = nickname;
    _identity = identity;
    _grade = grade;
}

  Data.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _username = json['username'];
    _avatar = json['avatar'];
    _nickname = json['nickname'];
    _identity = json['identity'];
    _grade = json['grade'];
  }
  String? _uuid;
  dynamic _username;
  dynamic _avatar;
  dynamic _nickname;
  num? _identity;
  num? _grade;
Data copyWith({  String? uuid,
  dynamic username,
  dynamic avatar,
  dynamic nickname,
  num? identity,
  num? grade,
}) => Data(  uuid: uuid ?? _uuid,
  username: username ?? _username,
  avatar: avatar ?? _avatar,
  nickname: nickname ?? _nickname,
  identity: identity ?? _identity,
  grade: grade ?? _grade,
);
  String? get uuid => _uuid;
  dynamic get username => _username;
  dynamic get avatar => _avatar;
  dynamic get nickname => _nickname;
  num? get identity => _identity;
  num? get grade => _grade;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['username'] = _username;
    map['avatar'] = _avatar;
    map['nickname'] = _nickname;
    map['identity'] = _identity;
    map['grade'] = _grade;
    return map;
  }

}