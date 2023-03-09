/// code : 1
/// data : [{"uuid":"1af949a0-b89b-11ed-a625-db6b4cef49c7","title":"本题共有5个小题，每小题你将听到一组对话。请你从每小题所给的A、B、C三幅图片中，选出与你所听到的信息相关联的一项，并将其字母标号填入题前括号内。","content":null,"options":[{"answer":1,"name":"","list":[{"text":"A、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/07ac08b0-b89b-11ed-a625-db6b4cef49c7tiancaia1.jpg"},{"text":"B、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/0bfa5430-b89b-11ed-a625-db6b4cef49c7tiancaia2.jpg"}]},{"answer":0,"name":"","list":[{"text":"A、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/1022a120-b89b-11ed-a625-db6b4cef49c7tiancaib1.jpg"},{"text":"B、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/16a6b860-b89b-11ed-a625-db6b4cef49c7tiancaib2.jpg"}]}],"answer":"","type":1,"typeChildren":1,"audio":"https://test-1315843937.cos.ap-beijing.myqcloud.com/70e6d9d0-b838-11ed-ab49-1363b805246btiancai90543416759913213894402778867738048744382.mp3"}]
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

  @override
  String toString() {
    return 'WeekDetailResponse{_code: $_code, _data: $_data, _msg: $_msg}';
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

/// uuid : "1af949a0-b89b-11ed-a625-db6b4cef49c7"
/// title : "本题共有5个小题，每小题你将听到一组对话。请你从每小题所给的A、B、C三幅图片中，选出与你所听到的信息相关联的一项，并将其字母标号填入题前括号内。"
/// content : null
/// options : [{"answer":1,"name":"","list":[{"text":"A、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/07ac08b0-b89b-11ed-a625-db6b4cef49c7tiancaia1.jpg"},{"text":"B、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/0bfa5430-b89b-11ed-a625-db6b4cef49c7tiancaia2.jpg"}]},{"answer":0,"name":"","list":[{"text":"A、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/1022a120-b89b-11ed-a625-db6b4cef49c7tiancaib1.jpg"},{"text":"B、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/16a6b860-b89b-11ed-a625-db6b4cef49c7tiancaib2.jpg"}]}]
/// answer : ""
/// type : 1
/// typeChildren : 1
/// audio : "https://test-1315843937.cos.ap-beijing.myqcloud.com/70e6d9d0-b838-11ed-ab49-1363b805246btiancai90543416759913213894402778867738048744382.mp3"

class Data {
  Data({
      String? uuid, 
      String? title, 
      num? student_answer,
      dynamic content,
      List<Options>? options,
      String? answer, 
      num? type, //type=2
      num? typeChildren, //typeChildren=7
      String? audio,}){
    _uuid = uuid;
    _title = title;
    _content = content;
    _options = options;
    // _answer = answer;
    _student_answer = student_answer;
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
    // _answer = json['answer'];
    _student_answer = json['student_answer'];
    _type = json['type'];
    _typeChildren = json['typeChildren'];
    _audio = json['audio'];
  }
  String? _uuid;
  String? _title;
  dynamic _content;
  List<Options>? _options;
  // String? _answer;
  num? _student_answer;
  num? _type;
  num? _typeChildren;
  String? _audio;
Data copyWith({  String? uuid,
  String? title,
  dynamic content,
  List<Options>? options,
  String? answer,
  num? student_answer,
  num? type,
  num? typeChildren,
  String? audio,
}) => Data(  uuid: uuid ?? _uuid,
  title: title ?? _title,
  content: content ?? _content,
  options: options ?? _options,
  // answer: answer ?? _answer,
  student_answer: student_answer ?? _student_answer,
  type: type ?? _type,
  typeChildren: typeChildren ?? _typeChildren,
  audio: audio ?? _audio,
);
  String? get uuid => _uuid;
  String? get title => _title;
  dynamic get content => _content;
  List<Options>? get options => _options;
  // String? get answer => _answer;
  num? get student_answer => _student_answer;
  num? get type => _type;
  num? get typeChildren => _typeChildren;
  String? get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['title'] = _title;
    map['content'] = _content;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    // map['answer'] = _answer;
    map['student_answer'] = _student_answer;
    map['type'] = _type;
    map['typeChildren'] = _typeChildren;
    map['audio'] = _audio;
    return map;
  }

}

/// answer : 1
/// name : ""
/// list : [{"text":"A、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/07ac08b0-b89b-11ed-a625-db6b4cef49c7tiancaia1.jpg"},{"text":"B、","image":"","img":"https://test-1315843937.cos.ap-beijing.myqcloud.com/0bfa5430-b89b-11ed-a625-db6b4cef49c7tiancaia2.jpg"}]

class Options {
  Options({
      String? answer,
      String? student_answer,
      String? name, 
      String? value,
      List<TiList>? list,}){
    _answer = answer;
    _name = name;
    _list = list;
    _value = value;
}

  Options.fromJson(dynamic json) {
    _answer = json['answer'].toString();
    _student_answer = json['student_answer'].toString();
    _name = json['name'];
    _value = json['value'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(TiList.fromJson(v));
      });
    }
  }
  String? _answer;
  String? _student_answer;
  String? _name;
  String? _value;
  List<TiList>? _list;
Options copyWith({
  String? answer,
  String? student_answer,
  String? name,
  String? value,
  List<TiList>? list,
}) => Options(
  answer: answer ?? _answer,
  student_answer: student_answer ?? _student_answer,
  name: name ?? _name,
  value: value ?? _value,
  list: list ?? _list,
);
  String? get answer => _answer;
  String? get name => _name;
  String? get value => _value;
  List<TiList>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = _answer;
    map['student_answer'] = _student_answer;
    map['name'] = _name;
    map['value'] = _value;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// text : "A、"
/// image : ""
/// img : "https://test-1315843937.cos.ap-beijing.myqcloud.com/07ac08b0-b89b-11ed-a625-db6b4cef49c7tiancaia1.jpg"

class TiList {
  TiList({
      String? text, 
      String? image, 
      String? img,}){
    _text = text;
    _image = image;
    _img = img;
}

  TiList.fromJson(dynamic json) {
    _text = json['text'];
    _image = json['image'];
    _img = json['img'];
  }
  String? _text;
  String? _image;
  String? _img;
  TiList copyWith({  String? text,
  String? image,
  String? img,
}) => TiList(  text: text ?? _text,
  image: image ?? _image,
  img: img ?? _img,
);
  String? get text => _text;
  String? get image => _image;
  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['image'] = _image;
    map['img'] = _img;
    return map;
  }

}