/// code : 1
/// id : "123"
/// name : "测试"

class ExamPaperResponse {
  ExamPaperResponse({
      num? code, 
      String? id, 
      String? name,}){
    _code = code;
    _id = id;
    _name = name;
}

  ExamPaperResponse.fromJson(dynamic json) {
    _code = json['code'];
    _id = json['id'];
    _name = json['name'];
  }
  num? _code;
  String? _id;
  String? _name;
ExamPaperResponse copyWith({  num? code,
  String? id,
  String? name,
}) => ExamPaperResponse(  code: code ?? _code,
  id: id ?? _id,
  name: name ?? _name,
);
  num? get code => _code;
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}