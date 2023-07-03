/// code : 0
/// message : "系统正常"
/// obj : {"id":1647898280209838082,"name":"ceshi","affiliatedGrade":1648226541879005185,"schoolYear":1,"periodsNum":1,"coverImg":null,"status":false,"isDelete":false,"createTime":"2023-04-17T17:42:18","updateTime":null,"createUser":1,"updateUser":null,"subjectVoList":[{"id":1648490005294907394,"journalId":1647898280209838082,"journalCatalogueId":1648160805898784769,"catalogueName":"测试01-04","stem":"请你从每小题所给的 A、B、C 三个选项中，选出一个能填入空白处的最佳选项，并将其字母标号填入题前的括号内。","content":"","difficultyDegree":1648218370301071362,"classify":1646439861824098314,"classifyValue":9,"classifyType":"classify_type","isSubjectivity":true,"questionType":1648211645430861827,"questionTypeStr":"single_choice","questionTypeName":"单项选择题","isDelete":false,"createTime":"2023-04-19T08:53:38","updateTime":null,"createUser":1,"updateUser":null,"questionCount":2,"subtopicVoList":[{"id":1648490005429125122,"subjectId":1648490005294907394,"problem":"21. Our English teacher asked us to do our homework _______ ourselves.","answer":"A","sort":1,"optionsList":[{"id":1648490005554954241,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"A","content":"at"},{"id":1648490005554954242,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"B","content":"by"},{"id":1648490005554954243,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"c","content":"in"}]},{"id":1648490005684977665,"subjectId":1648490005294907394,"problem":"22.Mr. and Mrs. Green's daughter doesn't take after _______ at all.","answer":"A","sort":2,"optionsList":[{"id":1648490005810806786,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"A","content":"her"},{"id":1648490005810806787,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"B","content":"them"},{"id":1648490005810806788,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"c","content":"themselves"}]}],"optionsList":null}]}
/// p : null

class SearchCollectListDetail {
  SearchCollectListDetail({
      num? code, 
      String? message, 
      Obj? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  SearchCollectListDetail.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _obj = json['obj'] != null ? Obj.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  num? _code;
  String? _message;
  Obj? _obj;
  dynamic _p;
SearchCollectListDetail copyWith({  num? code,
  String? message,
  Obj? obj,
  dynamic p,
}) => SearchCollectListDetail(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  Obj? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.toJson();
    }
    map['p'] = _p;
    return map;
  }

}

/// id : 1647898280209838082
/// name : "ceshi"
/// affiliatedGrade : 1648226541879005185
/// schoolYear : 1
/// periodsNum : 1
/// coverImg : null
/// status : false
/// isDelete : false
/// createTime : "2023-04-17T17:42:18"
/// updateTime : null
/// createUser : 1
/// updateUser : null
/// subjectVoList : [{"id":1648490005294907394,"journalId":1647898280209838082,"journalCatalogueId":1648160805898784769,"catalogueName":"测试01-04","stem":"请你从每小题所给的 A、B、C 三个选项中，选出一个能填入空白处的最佳选项，并将其字母标号填入题前的括号内。","content":"","difficultyDegree":1648218370301071362,"classify":1646439861824098314,"classifyValue":9,"classifyType":"classify_type","isSubjectivity":true,"questionType":1648211645430861827,"questionTypeStr":"single_choice","questionTypeName":"单项选择题","isDelete":false,"createTime":"2023-04-19T08:53:38","updateTime":null,"createUser":1,"updateUser":null,"questionCount":2,"subtopicVoList":[{"id":1648490005429125122,"subjectId":1648490005294907394,"problem":"21. Our English teacher asked us to do our homework _______ ourselves.","answer":"A","sort":1,"optionsList":[{"id":1648490005554954241,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"A","content":"at"},{"id":1648490005554954242,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"B","content":"by"},{"id":1648490005554954243,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"c","content":"in"}]},{"id":1648490005684977665,"subjectId":1648490005294907394,"problem":"22.Mr. and Mrs. Green's daughter doesn't take after _______ at all.","answer":"A","sort":2,"optionsList":[{"id":1648490005810806786,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"A","content":"her"},{"id":1648490005810806787,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"B","content":"them"},{"id":1648490005810806788,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"c","content":"themselves"}]}],"optionsList":null}]

class Obj {
  Obj({
      num? id, 
      String? name, 
      num? affiliatedGrade, 
      num? schoolYear, 
      num? periodsNum, 
      dynamic coverImg, 
      bool? status, 
      bool? isDelete, 
      String? createTime, 
      dynamic updateTime, 
      num? createUser, 
      dynamic updateUser, 
      List<SubjectVoList>? subjectVoList,}){
    _id = id;
    _name = name;
    _affiliatedGrade = affiliatedGrade;
    _schoolYear = schoolYear;
    _periodsNum = periodsNum;
    _coverImg = coverImg;
    _status = status;
    _isDelete = isDelete;
    _createTime = createTime;
    _updateTime = updateTime;
    _createUser = createUser;
    _updateUser = updateUser;
    _subjectVoList = subjectVoList;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _affiliatedGrade = json['affiliatedGrade'];
    _schoolYear = json['schoolYear'];
    _periodsNum = json['periodsNum'];
    _coverImg = json['coverImg'];
    _status = json['status'];
    _isDelete = json['isDelete'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _createUser = json['createUser'];
    _updateUser = json['updateUser'];
    if (json['subjectVoList'] != null) {
      _subjectVoList = [];
      json['subjectVoList'].forEach((v) {
        _subjectVoList?.add(SubjectVoList.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  num? _affiliatedGrade;
  num? _schoolYear;
  num? _periodsNum;
  dynamic _coverImg;
  bool? _status;
  bool? _isDelete;
  String? _createTime;
  dynamic _updateTime;
  num? _createUser;
  dynamic _updateUser;
  List<SubjectVoList>? _subjectVoList;
Obj copyWith({  num? id,
  String? name,
  num? affiliatedGrade,
  num? schoolYear,
  num? periodsNum,
  dynamic coverImg,
  bool? status,
  bool? isDelete,
  String? createTime,
  dynamic updateTime,
  num? createUser,
  dynamic updateUser,
  List<SubjectVoList>? subjectVoList,
}) => Obj(  id: id ?? _id,
  name: name ?? _name,
  affiliatedGrade: affiliatedGrade ?? _affiliatedGrade,
  schoolYear: schoolYear ?? _schoolYear,
  periodsNum: periodsNum ?? _periodsNum,
  coverImg: coverImg ?? _coverImg,
  status: status ?? _status,
  isDelete: isDelete ?? _isDelete,
  createTime: createTime ?? _createTime,
  updateTime: updateTime ?? _updateTime,
  createUser: createUser ?? _createUser,
  updateUser: updateUser ?? _updateUser,
  subjectVoList: subjectVoList ?? _subjectVoList,
);
  num? get id => _id;
  String? get name => _name;
  num? get affiliatedGrade => _affiliatedGrade;
  num? get schoolYear => _schoolYear;
  num? get periodsNum => _periodsNum;
  dynamic get coverImg => _coverImg;
  bool? get status => _status;
  bool? get isDelete => _isDelete;
  String? get createTime => _createTime;
  dynamic get updateTime => _updateTime;
  num? get createUser => _createUser;
  dynamic get updateUser => _updateUser;
  List<SubjectVoList>? get subjectVoList => _subjectVoList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['affiliatedGrade'] = _affiliatedGrade;
    map['schoolYear'] = _schoolYear;
    map['periodsNum'] = _periodsNum;
    map['coverImg'] = _coverImg;
    map['status'] = _status;
    map['isDelete'] = _isDelete;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['createUser'] = _createUser;
    map['updateUser'] = _updateUser;
    if (_subjectVoList != null) {
      map['subjectVoList'] = _subjectVoList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1648490005294907394
/// journalId : 1647898280209838082
/// journalCatalogueId : 1648160805898784769
/// catalogueName : "测试01-04"
/// stem : "请你从每小题所给的 A、B、C 三个选项中，选出一个能填入空白处的最佳选项，并将其字母标号填入题前的括号内。"
/// content : ""
/// difficultyDegree : 1648218370301071362
/// classify : 1646439861824098314
/// classifyValue : 9
/// classifyType : "classify_type"
/// isSubjectivity : true
/// questionType : 1648211645430861827
/// questionTypeStr : "single_choice"
/// questionTypeName : "单项选择题"
/// isDelete : false
/// createTime : "2023-04-19T08:53:38"
/// updateTime : null
/// createUser : 1
/// updateUser : null
/// questionCount : 2
/// subtopicVoList : [{"id":1648490005429125122,"subjectId":1648490005294907394,"problem":"21. Our English teacher asked us to do our homework _______ ourselves.","answer":"A","sort":1,"optionsList":[{"id":1648490005554954241,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"A","content":"at"},{"id":1648490005554954242,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"B","content":"by"},{"id":1648490005554954243,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"c","content":"in"}]},{"id":1648490005684977665,"subjectId":1648490005294907394,"problem":"22.Mr. and Mrs. Green's daughter doesn't take after _______ at all.","answer":"A","sort":2,"optionsList":[{"id":1648490005810806786,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"A","content":"her"},{"id":1648490005810806787,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"B","content":"them"},{"id":1648490005810806788,"p":null,"subtopicId":1648490005684977665,"subjectId":1648490005294907394,"sequence":"c","content":"themselves"}]}]
/// optionsList : null

class SubjectVoList {
  SubjectVoList({
      num? id, 
      num? journalId, 
      num? journalCatalogueId, 
      String? catalogueName, 
      String? stem, 
      String? content, 
      num? difficultyDegree, 
      num? classify, 
      num? classifyValue, 
      String? classifyType, 
      bool? isSubjectivity, 
      num? questionType, 
      String? questionTypeStr, 
      String? questionTypeName, 
      bool? isDelete, 
      String? createTime, 
      dynamic updateTime, 
      num? createUser, 
      dynamic updateUser, 
      num? questionCount, 
      List<SubtopicVoList>? subtopicVoList, 
      dynamic optionsList,}){
    _id = id;
    _journalId = journalId;
    _journalCatalogueId = journalCatalogueId;
    _catalogueName = catalogueName;
    _stem = stem;
    _content = content;
    _difficultyDegree = difficultyDegree;
    _classify = classify;
    _classifyValue = classifyValue;
    _classifyType = classifyType;
    _isSubjectivity = isSubjectivity;
    _questionType = questionType;
    _questionTypeStr = questionTypeStr;
    _questionTypeName = questionTypeName;
    _isDelete = isDelete;
    _createTime = createTime;
    _updateTime = updateTime;
    _createUser = createUser;
    _updateUser = updateUser;
    _questionCount = questionCount;
    _subtopicVoList = subtopicVoList;
    _optionsList = optionsList;
}

  SubjectVoList.fromJson(dynamic json) {
    _id = json['id'];
    _journalId = json['journalId'];
    _journalCatalogueId = json['journalCatalogueId'];
    _catalogueName = json['catalogueName'];
    _stem = json['stem'];
    _content = json['content'];
    _difficultyDegree = json['difficultyDegree'];
    _classify = json['classify'];
    _classifyValue = json['classifyValue'];
    _classifyType = json['classifyType'];
    _isSubjectivity = json['isSubjectivity'];
    _questionType = json['questionType'];
    _questionTypeStr = json['questionTypeStr'];
    _questionTypeName = json['questionTypeName'];
    _isDelete = json['isDelete'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _createUser = json['createUser'];
    _updateUser = json['updateUser'];
    _questionCount = json['questionCount'];
    if (json['subtopicVoList'] != null) {
      _subtopicVoList = [];
      json['subtopicVoList'].forEach((v) {
        _subtopicVoList?.add(SubtopicVoList.fromJson(v));
      });
    }
    _optionsList = json['optionsList'];
  }
  num? _id;
  num? _journalId;
  num? _journalCatalogueId;
  String? _catalogueName;
  String? _stem;
  String? _content;
  num? _difficultyDegree;
  num? _classify;
  num? _classifyValue;
  String? _classifyType;
  bool? _isSubjectivity;
  num? _questionType;
  String? _questionTypeStr;
  String? _questionTypeName;
  bool? _isDelete;
  String? _createTime;
  dynamic _updateTime;
  num? _createUser;
  dynamic _updateUser;
  num? _questionCount;
  List<SubtopicVoList>? _subtopicVoList;
  dynamic _optionsList;
SubjectVoList copyWith({  num? id,
  num? journalId,
  num? journalCatalogueId,
  String? catalogueName,
  String? stem,
  String? content,
  num? difficultyDegree,
  num? classify,
  num? classifyValue,
  String? classifyType,
  bool? isSubjectivity,
  num? questionType,
  String? questionTypeStr,
  String? questionTypeName,
  bool? isDelete,
  String? createTime,
  dynamic updateTime,
  num? createUser,
  dynamic updateUser,
  num? questionCount,
  List<SubtopicVoList>? subtopicVoList,
  dynamic optionsList,
}) => SubjectVoList(  id: id ?? _id,
  journalId: journalId ?? _journalId,
  journalCatalogueId: journalCatalogueId ?? _journalCatalogueId,
  catalogueName: catalogueName ?? _catalogueName,
  stem: stem ?? _stem,
  content: content ?? _content,
  difficultyDegree: difficultyDegree ?? _difficultyDegree,
  classify: classify ?? _classify,
  classifyValue: classifyValue ?? _classifyValue,
  classifyType: classifyType ?? _classifyType,
  isSubjectivity: isSubjectivity ?? _isSubjectivity,
  questionType: questionType ?? _questionType,
  questionTypeStr: questionTypeStr ?? _questionTypeStr,
  questionTypeName: questionTypeName ?? _questionTypeName,
  isDelete: isDelete ?? _isDelete,
  createTime: createTime ?? _createTime,
  updateTime: updateTime ?? _updateTime,
  createUser: createUser ?? _createUser,
  updateUser: updateUser ?? _updateUser,
  questionCount: questionCount ?? _questionCount,
  subtopicVoList: subtopicVoList ?? _subtopicVoList,
  optionsList: optionsList ?? _optionsList,
);
  num? get id => _id;
  num? get journalId => _journalId;
  num? get journalCatalogueId => _journalCatalogueId;
  String? get catalogueName => _catalogueName;
  String? get stem => _stem;
  String? get content => _content;
  num? get difficultyDegree => _difficultyDegree;
  num? get classify => _classify;
  num? get classifyValue => _classifyValue;
  String? get classifyType => _classifyType;
  bool? get isSubjectivity => _isSubjectivity;
  num? get questionType => _questionType;
  String? get questionTypeStr => _questionTypeStr;
  String? get questionTypeName => _questionTypeName;
  bool? get isDelete => _isDelete;
  String? get createTime => _createTime;
  dynamic get updateTime => _updateTime;
  num? get createUser => _createUser;
  dynamic get updateUser => _updateUser;
  num? get questionCount => _questionCount;
  List<SubtopicVoList>? get subtopicVoList => _subtopicVoList;
  dynamic get optionsList => _optionsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['journalId'] = _journalId;
    map['journalCatalogueId'] = _journalCatalogueId;
    map['catalogueName'] = _catalogueName;
    map['stem'] = _stem;
    map['content'] = _content;
    map['difficultyDegree'] = _difficultyDegree;
    map['classify'] = _classify;
    map['classifyValue'] = _classifyValue;
    map['classifyType'] = _classifyType;
    map['isSubjectivity'] = _isSubjectivity;
    map['questionType'] = _questionType;
    map['questionTypeStr'] = _questionTypeStr;
    map['questionTypeName'] = _questionTypeName;
    map['isDelete'] = _isDelete;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['createUser'] = _createUser;
    map['updateUser'] = _updateUser;
    map['questionCount'] = _questionCount;
    if (_subtopicVoList != null) {
      map['subtopicVoList'] = _subtopicVoList?.map((v) => v.toJson()).toList();
    }
    map['optionsList'] = _optionsList;
    return map;
  }

}

/// id : 1648490005429125122
/// subjectId : 1648490005294907394
/// problem : "21. Our English teacher asked us to do our homework _______ ourselves."
/// answer : "A"
/// sort : 1
/// optionsList : [{"id":1648490005554954241,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"A","content":"at"},{"id":1648490005554954242,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"B","content":"by"},{"id":1648490005554954243,"p":null,"subtopicId":1648490005429125122,"subjectId":1648490005294907394,"sequence":"c","content":"in"}]

class SubtopicVoList {
  SubtopicVoList({
      num? id, 
      num? subjectId, 
      String? problem, 
      String? answer, 
      num? sort, 
      List<OptionsList>? optionsList,}){
    _id = id;
    _subjectId = subjectId;
    _problem = problem;
    _answer = answer;
    _sort = sort;
    _optionsList = optionsList;
}

  SubtopicVoList.fromJson(dynamic json) {
    _id = json['id'];
    _subjectId = json['subjectId'];
    _problem = json['problem'];
    _answer = json['answer'];
    _sort = json['sort'];
    if (json['optionsList'] != null) {
      _optionsList = [];
      json['optionsList'].forEach((v) {
        _optionsList?.add(OptionsList.fromJson(v));
      });
    }
  }
  num? _id;
  num? _subjectId;
  String? _problem;
  String? _answer;
  num? _sort;
  List<OptionsList>? _optionsList;
SubtopicVoList copyWith({  num? id,
  num? subjectId,
  String? problem,
  String? answer,
  num? sort,
  List<OptionsList>? optionsList,
}) => SubtopicVoList(  id: id ?? _id,
  subjectId: subjectId ?? _subjectId,
  problem: problem ?? _problem,
  answer: answer ?? _answer,
  sort: sort ?? _sort,
  optionsList: optionsList ?? _optionsList,
);
  num? get id => _id;
  num? get subjectId => _subjectId;
  String? get problem => _problem;
  String? get answer => _answer;
  num? get sort => _sort;
  List<OptionsList>? get optionsList => _optionsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subjectId'] = _subjectId;
    map['problem'] = _problem;
    map['answer'] = _answer;
    map['sort'] = _sort;
    if (_optionsList != null) {
      map['optionsList'] = _optionsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1648490005554954241
/// p : null
/// subtopicId : 1648490005429125122
/// subjectId : 1648490005294907394
/// sequence : "A"
/// content : "at"

class OptionsList {
  OptionsList({
      num? id, 
      dynamic p, 
      num? subtopicId, 
      num? subjectId, 
      String? sequence, 
      String? content,}){
    _id = id;
    _p = p;
    _subtopicId = subtopicId;
    _subjectId = subjectId;
    _sequence = sequence;
    _content = content;
}

  OptionsList.fromJson(dynamic json) {
    _id = json['id'];
    _p = json['p'];
    _subtopicId = json['subtopicId'];
    _subjectId = json['subjectId'];
    _sequence = json['sequence'];
    _content = json['content'];
  }
  num? _id;
  dynamic _p;
  num? _subtopicId;
  num? _subjectId;
  String? _sequence;
  String? _content;
OptionsList copyWith({  num? id,
  dynamic p,
  num? subtopicId,
  num? subjectId,
  String? sequence,
  String? content,
}) => OptionsList(  id: id ?? _id,
  p: p ?? _p,
  subtopicId: subtopicId ?? _subtopicId,
  subjectId: subjectId ?? _subjectId,
  sequence: sequence ?? _sequence,
  content: content ?? _content,
);
  num? get id => _id;
  dynamic get p => _p;
  num? get subtopicId => _subtopicId;
  num? get subjectId => _subjectId;
  String? get sequence => _sequence;
  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['p'] = _p;
    map['subtopicId'] = _subtopicId;
    map['subjectId'] = _subjectId;
    map['sequence'] = _sequence;
    map['content'] = _content;
    return map;
  }

}