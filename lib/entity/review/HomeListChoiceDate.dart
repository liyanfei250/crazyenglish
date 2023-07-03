
import '../base_resp.dart';

class HomeListChoiceDate extends BaseResp{
  HomeListChoiceDate({num? code, String? data, String? msg}):super(code,msg) {
    _data = data;
  }

  HomeListChoiceDate.fromJson(dynamic json):super.fromJson(json) {
    _data = json['data'];
  }

  String? _data;

  HomeListChoiceDate copyWith({num? code, String? data, String? msg}) =>
      HomeListChoiceDate(
        code: code ?? code,
        data: data ?? _data,
        msg: msg ?? message,
      );

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['data'] = _data;
    map['msg'] = message;
    return map;
  }
}
