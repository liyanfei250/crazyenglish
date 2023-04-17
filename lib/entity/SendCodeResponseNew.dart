import 'base_resp.dart';

/// code : 200
/// data : "ok"

class SendCodeResponseNew extends BaseResp{
  SendCodeResponseNew({num? code, String? data, String? msg}):super(code,msg) {
    _data = data;
  }

  SendCodeResponseNew.fromJson(dynamic json):super.fromJson(json) {
    _data = json['obj'];
  }

  String? _data;

  SendCodeResponseNew copyWith({num? code, String? data, String? msg}) =>
      SendCodeResponseNew(
        code: code ?? code,
        data: data ?? _data,
        msg: msg ?? message,
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
