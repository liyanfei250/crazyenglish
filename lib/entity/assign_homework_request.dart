/// name : "英语测试2"
/// teacherId : "1651539603655626753"
/// deadline : "2023-05-15 15:37:19"
/// classInfos : [{"schoolClassId":"1655395694170124290","studentUserIds":[1651531759961624578,1651533076075499521]}]
/// paperType : 1
/// isCreatePaper : true
/// journalCatalogueIds : [1648128423083769857,1648138028814798850,1648159430713421825,1654759659150610434]
/// journalId : null
/// paperId : "382"
/// historyOperationId : "991"

class AssignHomeworkRequest {
  AssignHomeworkRequest({
      String? name, 
      String? teacherId, 
      String? deadline, 
      List<ClassInfos>? classInfos, 
      num? paperType, 
      bool? isCreatePaper, 
      List<num>? journalCatalogueIds, 
      String? journalId,
      String? historyOperationClassId,
      String? paperId,
      String? historyOperationId,}){
    _name = name;
    _teacherId = teacherId;
    _deadline = deadline;
    _classInfos = classInfos;
    _paperType = paperType;
    _isCreatePaper = isCreatePaper;
    _journalCatalogueIds = journalCatalogueIds;
    _journalId = journalId;
    _paperId = paperId;
    _historyOperationId = historyOperationId;
    _historyOperationClassId = historyOperationClassId;
}

  AssignHomeworkRequest.fromJson(dynamic json) {
    _name = json['name'];
    _teacherId = json['teacherId'];
    _deadline = json['deadline'];
    if (json['classInfos'] != null) {
      _classInfos = [];
      json['classInfos'].forEach((v) {
        _classInfos?.add(ClassInfos.fromJson(v));
      });
    }
    _paperType = json['paperType'];
    _isCreatePaper = json['isCreatePaper'];
    _journalCatalogueIds = json['journalCatalogueIds'] != null ? json['journalCatalogueIds'].cast<num>() : [];
    _journalId = json['journalId'];
    _paperId = json['paperId'];
    _historyOperationId = json['historyOperationId'];
    _historyOperationClassId = json['historyOperationClassId'];
  }
  String? _name;
  String? _teacherId;
  String? _deadline;
  List<ClassInfos>? _classInfos;
  num? _paperType;
  bool? _isCreatePaper;
  List<num>? _journalCatalogueIds;
  String? _journalId;
  String? _paperId;
  String? _historyOperationId;
  String? _historyOperationClassId;
AssignHomeworkRequest copyWith({  String? name,
  String? teacherId,
  String? deadline,
  List<ClassInfos>? classInfos,
  num? paperType,
  bool? isCreatePaper,
  List<num>? journalCatalogueIds,
  String? journalId,
  String? paperId,
  String? historyOperationId,
  String? historyOperationClassId,
}) => AssignHomeworkRequest(  name: name ?? _name,
  teacherId: teacherId ?? _teacherId,
  deadline: deadline ?? _deadline,
  classInfos: classInfos ?? _classInfos,
  paperType: paperType ?? _paperType,
  isCreatePaper: isCreatePaper ?? _isCreatePaper,
  journalCatalogueIds: journalCatalogueIds ?? _journalCatalogueIds,
  journalId: journalId ?? _journalId,
  paperId: paperId ?? _paperId,
  historyOperationId: historyOperationId ?? _historyOperationId,
  historyOperationClassId: historyOperationClassId ?? _historyOperationClassId,
);
  String? get name => _name;
  String? get teacherId => _teacherId;
  String? get deadline => _deadline;
  List<ClassInfos>? get classInfos => _classInfos;
  num? get paperType => _paperType;
  bool? get isCreatePaper => _isCreatePaper;
  List<num>? get journalCatalogueIds => _journalCatalogueIds;
  String? get journalId => _journalId;
  String? get paperId => _paperId;
  String? get historyOperationId => _historyOperationId;
  String? get historyOperationClassId => _historyOperationClassId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['teacherId'] = _teacherId;
    map['deadline'] = _deadline;
    if (_classInfos != null) {
      map['classInfos'] = _classInfos?.map((v) => v.toJson()).toList();
    }
    map['paperType'] = _paperType;
    map['isCreatePaper'] = _isCreatePaper;
    map['journalCatalogueIds'] = _journalCatalogueIds;
    map['journalId'] = _journalId;
    map['paperId'] = _paperId;
    map['historyOperationId'] = _historyOperationId;
    map['historyOperationClassId'] = _historyOperationClassId;
    return map;
  }

}

/// schoolClassId : "1655395694170124290"
/// studentUserIds : [1651531759961624578,1651533076075499521]

class ClassInfos {
  ClassInfos({
      String? schoolClassId, 
      List<num>? studentUserIds,}){
    _schoolClassId = schoolClassId;
    _studentUserIds = studentUserIds;
}

  ClassInfos.fromJson(dynamic json) {
    _schoolClassId = json['schoolClassId'];
    _studentUserIds = json['studentUserIds'] != null ? json['studentUserIds'].cast<num>() : [];
  }
  String? _schoolClassId;
  List<num>? _studentUserIds;
ClassInfos copyWith({  String? schoolClassId,
  List<num>? studentUserIds,
}) => ClassInfos(  schoolClassId: schoolClassId ?? _schoolClassId,
  studentUserIds: studentUserIds ?? _studentUserIds,
);
  String? get schoolClassId => _schoolClassId;
  List<num>? get studentUserIds => _studentUserIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['schoolClassId'] = _schoolClassId;
    map['studentUserIds'] = _studentUserIds;
    return map;
  }

}