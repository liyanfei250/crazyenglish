/// vipPeriodOfValidity : 0
/// appMsg : "登录成功"
/// nickname : "186***5491"
/// mobile : "18680345491"
/// binding : false
/// industry : ""
/// id : 260
/// portrait : ""

class LoginResponse {
  int? _vipPeriodOfValidity;
  String? _appMsg;
  String? _nickname;
  String? _mobile;
  bool? _binding;
  String? _industry;
  int? _id;
  String? _portrait;

  int? get vipPeriodOfValidity => _vipPeriodOfValidity;
  String? get appMsg => _appMsg;
  String? get nickname => _nickname;
  String? get mobile => _mobile;
  bool? get binding => _binding;
  String? get industry => _industry;
  int? get id => _id;
  String? get portrait => _portrait;

  LoginResponse({
      int? vipPeriodOfValidity, 
      String? appMsg, 
      String? nickname, 
      String? mobile, 
      bool? binding, 
      String? industry, 
      int? id, 
      String? portrait}){
    _vipPeriodOfValidity = vipPeriodOfValidity;
    _appMsg = appMsg;
    _nickname = nickname;
    _mobile = mobile;
    _binding = binding;
    _industry = industry;
    _id = id;
    _portrait = portrait;
}

  LoginResponse.fromJson(dynamic json) {
    _vipPeriodOfValidity = json['vipPeriodOfValidity'];
    _appMsg = json['appMsg'];
    _nickname = json['nickname'];
    _mobile = json['mobile'];
    _binding = json['binding'];
    _industry = json['industry'];
    _id = json['id'];
    _portrait = json['portrait'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['vipPeriodOfValidity'] = _vipPeriodOfValidity;
    map['appMsg'] = _appMsg;
    map['nickname'] = _nickname;
    map['mobile'] = _mobile;
    map['binding'] = _binding;
    map['industry'] = _industry;
    map['id'] = _id;
    map['portrait'] = _portrait;
    return map;
  }

}