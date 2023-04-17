import '../base_resp.dart';

class ReviewHomeDetail extends BaseResp{
  ReviewHomeDetail({num? code, String? data, String? msg}):super(code,msg) {
    _data = data;
  }

  ReviewHomeDetail.fromJson(dynamic json):super.fromJson(json) {
    _data = json['data'];
  }

  String? _data;

  ReviewHomeDetail copyWith({num? code, String? data, String? msg}) =>
      ReviewHomeDetail(
        code: code ?? code,
        data: data ?? _data,
        msg: msg ?? msg,
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