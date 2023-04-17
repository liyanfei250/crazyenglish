
class HomeListDate {
  HomeListDate({num? code, String? data, String? msg}) {
    _code = code;
    _data = data;
    _msg = msg;
  }

  HomeListDate.fromJson(dynamic json) {
    _code = json['code'];
    _data = json['data'];
    _msg = json['msg'];
  }

  num? _code;
  String? _data;
  String? _msg;

  HomeListDate copyWith({num? code, String? data, String? msg}) =>
      HomeListDate(
        code: code ?? _code,
        data: data ?? _data,
        msg: msg ?? _msg,
      );

  num? get code => _code;

  String? get data => _data;

  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['data'] = _data;
    map['msg'] = _msg;
    return map;
  }
}
