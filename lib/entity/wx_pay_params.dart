
class WxPayParams {
  String? _package;
  String? _appid;
  String? _sign;
  String? _partnerid;
  String? _prepayid;
  String? _noncestr;
  String? _timestamp;
  String? _redirectUrl;

  String? get package => _package;
  String? get appid => _appid;
  String? get sign => _sign;
  String? get partnerid => _partnerid;
  String? get prepayid => _prepayid;
  String? get noncestr => _noncestr;
  String? get timestamp => _timestamp;
  String? get redirectUrl => _redirectUrl;

  WxPayParams({
      String? package, 
      String? appid, 
      String? sign, 
      String? partnerid, 
      String? prepayid, 
      String? noncestr, 
      String? timestamp,
      String? redirectUrl}){
    _package = package;
    _appid = appid;
    _sign = sign;
    _partnerid = partnerid;
    _prepayid = prepayid;
    _noncestr = noncestr;
    _timestamp = timestamp;
    _redirectUrl = redirectUrl;
}

  WxPayParams.fromJson(dynamic json) {
    _package = json['package'];
    _appid = json['appid'];
    _sign = json['sign'];
    _partnerid = json['partnerid'];
    _prepayid = json['prepayid'];
    _noncestr = json['noncestr'];
    _timestamp = json['timestamp'];
    _redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['package'] = _package;
    map['appid'] = _appid;
    map['sign'] = _sign;
    map['partnerid'] = _partnerid;
    map['prepayid'] = _prepayid;
    map['noncestr'] = _noncestr;
    map['timestamp'] = _timestamp;
    map['redirectUrl'] = _redirectUrl;
    return map;
  }

}