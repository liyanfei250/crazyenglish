import '../base_resp.dart';

class  HomeMyTasksDate extends BaseResp{
  HomeMyTasksDate({num? code, String? data, String? msg}):super(code,msg) {
    _data = data;
  }

  HomeMyTasksDate.fromJson(dynamic json):super.fromJson(json) {
    _data = json['data'];
  }

  String? _data;

  HomeMyTasksDate copyWith({num? code, String? data, String? msg}) =>
      HomeMyTasksDate(
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