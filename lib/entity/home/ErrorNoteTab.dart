/// code : 0
/// message : ""
/// obj : {}

class ErrorNoteTab {
  ErrorNoteTab({
    num? code,
    String? message,
    dynamic obj,}){
    _code = code;
    _message = message;
    _obj = obj;
  }

  ErrorNoteTab.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'];
  }
  num? _code;
  String? _message;
  dynamic _obj;
  ErrorNoteTab copyWith({  num? code,
    String? message,
    dynamic obj,
  }) => ErrorNoteTab(  code: code ?? _code,
    message: message ?? _message,
    obj: obj ?? _obj,
  );
  num? get code => _code;
  String? get message => _message;
  dynamic get obj => _obj;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['obj'] = _obj;
    return map;
  }

}