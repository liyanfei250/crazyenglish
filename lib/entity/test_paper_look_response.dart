/// code : 0
/// message : "系统正常"
/// obj : [{"classifyId":"1646439861824098314","classifyName":"其它","catalogues":[{"journalCatalogueId":"1648138028814798850","catalogueName":"测试01-03","questionCount":1,"finishQuestionCount":0}]}]
/// p : null

class TestPaperLookResponse {
  TestPaperLookResponse({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  TestPaperLookResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
TestPaperLookResponse copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => TestPaperLookResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    map['p'] = _p;
    return map;
  }

}

/// classifyId : "1646439861824098314"
/// classifyName : "其它"
/// catalogues : [{"journalCatalogueId":"1648138028814798850","catalogueName":"测试01-03","questionCount":1,"finishQuestionCount":0}]

class Obj {
  Obj({
      String? classifyId, 
      String? classifyName, 
      List<Catalogues>? catalogues,}){
    _classifyId = classifyId;
    _classifyName = classifyName;
    _catalogues = catalogues;
}

  Obj.fromJson(dynamic json) {
    _classifyId = json['classifyId'];
    _classifyName = json['classifyName'];
    if (json['catalogues'] != null) {
      _catalogues = [];
      json['catalogues'].forEach((v) {
        _catalogues?.add(Catalogues.fromJson(v));
      });
    }
  }
  String? _classifyId;
  String? _classifyName;
  List<Catalogues>? _catalogues;
Obj copyWith({  String? classifyId,
  String? classifyName,
  List<Catalogues>? catalogues,
}) => Obj(  classifyId: classifyId ?? _classifyId,
  classifyName: classifyName ?? _classifyName,
  catalogues: catalogues ?? _catalogues,
);
  String? get classifyId => _classifyId;
  String? get classifyName => _classifyName;
  List<Catalogues>? get catalogues => _catalogues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classifyId'] = _classifyId;
    map['classifyName'] = _classifyName;
    if (_catalogues != null) {
      map['catalogues'] = _catalogues?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// journalCatalogueId : "1648138028814798850"
/// catalogueName : "测试01-03"
/// questionCount : 1
/// finishQuestionCount : 0

class Catalogues {
  Catalogues({
      String? journalCatalogueId, 
      String? catalogueName, 
      num? questionCount, 
      num? finishQuestionCount,}){
    _journalCatalogueId = journalCatalogueId;
    _catalogueName = catalogueName;
    _questionCount = questionCount;
    _finishQuestionCount = finishQuestionCount;
}

  Catalogues.fromJson(dynamic json) {
    _journalCatalogueId = json['journalCatalogueId'];
    _catalogueName = json['catalogueName'];
    _questionCount = json['questionCount'];
    _finishQuestionCount = json['finishQuestionCount'];
  }
  String? _journalCatalogueId;
  String? _catalogueName;
  num? _questionCount;
  num? _finishQuestionCount;
Catalogues copyWith({  String? journalCatalogueId,
  String? catalogueName,
  num? questionCount,
  num? finishQuestionCount,
}) => Catalogues(  journalCatalogueId: journalCatalogueId ?? _journalCatalogueId,
  catalogueName: catalogueName ?? _catalogueName,
  questionCount: questionCount ?? _questionCount,
  finishQuestionCount: finishQuestionCount ?? _finishQuestionCount,
);
  String? get journalCatalogueId => _journalCatalogueId;
  String? get catalogueName => _catalogueName;
  num? get questionCount => _questionCount;
  num? get finishQuestionCount => _finishQuestionCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['journalCatalogueId'] = _journalCatalogueId;
    map['catalogueName'] = _catalogueName;
    map['questionCount'] = _questionCount;
    map['finishQuestionCount'] = _finishQuestionCount;
    return map;
  }

}