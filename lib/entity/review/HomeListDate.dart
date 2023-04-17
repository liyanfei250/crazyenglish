
import '../base_resp.dart';

class HomeListDate extends BaseResp{
  HomeListDate({num? code, String? data, String? msg}):super(code,msg) {
    _data = data;
  }

  HomeListDate.fromJson(dynamic json):super.fromJson(json) {
    _data = json['obj'];
  }

  String? _data;

  HomeListDate copyWith({num? code, String? data, String? msg}) =>
      HomeListDate(
        code: code ?? code,
        data: data ?? _data,
        msg: msg ?? message,
      );

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['obj'] = _data;
    map['msg'] = message;
    return map;
  }
}
