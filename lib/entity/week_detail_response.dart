/// code : 1
/// data : [{"uuid":"616daf40-b8d0-11ed-b79f-3f87e7108ef2","title":"创建选择-阅读理解（对话）","content":"<p>创建选择-阅读理解（对话）<br/></p>","options":[{"name":"创建选择-阅读理解（对话）标题","value":"答案"},{"name":"创建选择-阅读理解（对话）22222","value":"创建选择-阅读理解（对话）11111"}],"answer":null,"type":2,"typeChildren":6,"audio":null},{"uuid":"50bd95e0-b969-11ed-bccd-f1a9d3141091","title":null,"content":"<p>canyou help me bring some things <u>&emsp;&emsp;A&emsp;&emsp;</u><br/></p>","options":[{"name":"A","value":""}],"answer":null,"type":2,"typeChildren":7,"audio":null}]
/// msg : ""

class WeekDetailResponse {
  WeekDetailResponse({
      num? code, 
      List<Data>? data, 
      String? msg,}){
    _code = code;
    _data = data;
    _msg = msg;
}

  WeekDetailResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  num? _code;
  List<Data>? _data;
  String? _msg;
WeekDetailResponse copyWith({  num? code,
  List<Data>? data,
  String? msg,
}) => WeekDetailResponse(  code: code ?? _code,
  data: data ?? _data,
  msg: msg ?? _msg,
);
  num? get code => _code;
  List<Data>? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

/// uuid : "616daf40-b8d0-11ed-b79f-3f87e7108ef2"
/// title : "创建选择-阅读理解（对话）"
/// content : "<p>创建选择-阅读理解（对话）<br/></p>"
/// options : [{"name":"创建选择-阅读理解（对话）标题","value":"答案"},{"name":"创建选择-阅读理解（对话）22222","value":"创建选择-阅读理解（对话）11111"}]
/// answer : null
/// type : 2
/// typeChildren : 6
/// audio : null

class Data {
  Data({
      String? uuid, 
      String? title, 
      String? content, 
      List<Options>? options, 
      dynamic answer, 
      num? type, 
      num? typeChildren, 
      dynamic audio,}){
    _uuid = uuid;
    _title = title;
    _content = content;
    _options = options;
    _answer = answer;
    _type = type;
    _typeChildren = typeChildren;
    _audio = audio;
}

  Data.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _title = json['title'];
    _content = json['content'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
    _answer = json['answer'];
    _type = json['type'];
    _typeChildren = json['typeChildren'];
    _audio = json['audio'];
  }
  String? _uuid;
  String? _title;
  String? _content;
  List<Options>? _options;
  dynamic _answer;
  num? _type;
  num? _typeChildren;
  dynamic _audio;
Data copyWith({  String? uuid,
  String? title,
  String? content,
  List<Options>? options,
  dynamic answer,
  num? type,
  num? typeChildren,
  dynamic audio,
}) => Data(  uuid: uuid ?? _uuid,
  title: title ?? _title,
  content: content ?? _content,
  options: options ?? _options,
  answer: answer ?? _answer,
  type: type ?? _type,
  typeChildren: typeChildren ?? _typeChildren,
  audio: audio ?? _audio,
);
  String? get uuid => _uuid;
  String? get title => _title;
  String? get content => _content;
  List<Options>? get options => _options;
  dynamic get answer => _answer;
  num? get type => _type;
  num? get typeChildren => _typeChildren;
  dynamic get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['title'] = _title;
    map['content'] = _content;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    map['answer'] = _answer;
    map['type'] = _type;
    map['typeChildren'] = _typeChildren;
    map['audio'] = _audio;
    return map;
  }

}

/// name : "创建选择-阅读理解（对话）标题"
/// value : "答案"

class Options {
  Options({
      String? name, 
      String? value,}){
    _name = name;
    _value = value;
}

  Options.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'];
  }
  String? _name;
  String? _value;
Options copyWith({  String? name,
  String? value,
}) => Options(  name: name ?? _name,
  value: value ?? _value,
);
  String? get name => _name;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    return map;
  }

}