import 'base_resp.dart';

/// code : 0
/// message : "系统正常"
/// obj : {"isFinish":false,"correctCount":0,"questionCount":0,"parentIndex":0,"sublevelIndex":2,"time":null,"exerciseVos":[{"id":1648489081851772929,"userId":1,"subjectId":1648489081579143169,"journalCatalogueId":1647898280209838082,"isFinish":false,"time":"09:14:07","exerciseLists":[{"id":1648489081851772929,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489081851772929,"answer":"fafdas","isRight":true,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772930,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083034566658,"answer":"2312321","isRight":false,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772931,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083361722369,"answer":"DFAGD","isRight":true,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772932,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083621769217,"answer":"zvffa","isRight":false,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772933,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083818901505,"answer":"exercise","isRight":true,"createTime":"2023-04-19 17:24:00"}]}]}
/// p : null

class StartExam extends BaseResp{
  StartExam({
      num? code, 
      String? message,
    Exercise? obj,
      dynamic p,}):super(code,message) {
    _obj = obj;
    _p = p;
}

  StartExam.fromJson(dynamic json):super.fromJson(json) {
    _obj = json['obj'] != null ? Exercise.fromJson(json['obj']) : null;
    _p = json['p'];
  }
  Exercise? _obj;
  dynamic _p;
StartExam copyWith({  num? code,
  String? message,
  Exercise? obj,
  dynamic p,
}) => StartExam(  code: code ?? code,
  message: message ?? message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  Exercise? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (_obj != null) {
      map['obj'] = _obj?.toJson();
    }
    map['p'] = _p;
    return map;
  }

}

/// isFinish : false
/// correctCount : 0
/// questionCount : 0
/// parentIndex : 0
/// sublevelIndex : 2
/// time : null
/// exerciseVos : [{"id":1648489081851772929,"userId":1,"subjectId":1648489081579143169,"journalCatalogueId":1647898280209838082,"isFinish":false,"time":"09:14:07","exerciseLists":[{"id":1648489081851772929,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489081851772929,"answer":"fafdas","isRight":true,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772930,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083034566658,"answer":"2312321","isRight":false,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772931,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083361722369,"answer":"DFAGD","isRight":true,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772932,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083621769217,"answer":"zvffa","isRight":false,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772933,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083818901505,"answer":"exercise","isRight":true,"createTime":"2023-04-19 17:24:00"}]}]


class JouralResultResponse {
  JouralResultResponse({
    num? code,
    String? msg,
    List<Exercise>? data,}){
    _code = code;
    _msg = msg;
    _data = data;
  }

  JouralResultResponse.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['obj'] != null) {
      _data = [];
      json['obj'].forEach((v) {
        _data?.add(Exercise.fromJson(v));
      });
    }
  }
  num? _code;
  String? _msg;
  List<Exercise>? _data;
  JouralResultResponse copyWith({  num? code,
    String? msg,
    List<Exercise>? data,
  }) => JouralResultResponse(  code: code ?? _code,
    msg: msg ?? _msg,
    data: data ?? _data,
  );
  num? get code => _code;
  String? get msg => _msg;
  List<Exercise>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _msg;
    if (_data != null) {
      map['obj'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Exercise {
  Exercise({
      bool? isFinish, 
      num? correctCount, 
      num? questionCount, 
      num? parentIndex, 
      num? sublevelIndex, 
      num? time,
      List<ExerciseVos>? exerciseVos,}){
    _isFinish = isFinish;
    _correctCount = correctCount;
    _questionCount = questionCount;
    _parentIndex = parentIndex;
    _sublevelIndex = sublevelIndex;
    _time = time;
    _exerciseVos = exerciseVos;
}

  Exercise.fromJson(dynamic json) {
    _isFinish = json['isFinish'];
    _correctCount = json['correctCount'];
    _questionCount = json['questionCount'];
    _parentIndex = json['parentIndex'];
    _sublevelIndex = json['sublevelIndex'];
    _time = json['time'];
    if (json['exerciseVos'] != null) {
      _exerciseVos = [];
      json['exerciseVos'].forEach((v) {
        _exerciseVos?.add(ExerciseVos.fromJson(v));
      });
    }
  }
  bool? _isFinish;
  num? _correctCount;
  num? _questionCount;
  num? _parentIndex;
  num? _sublevelIndex;
  num? _time;
  List<ExerciseVos>? _exerciseVos;
  Exercise copyWith({  bool? isFinish,
  num? correctCount,
  num? questionCount,
  num? parentIndex,
  num? sublevelIndex,
  num? time,
  List<ExerciseVos>? exerciseVos,
}) => Exercise(  isFinish: isFinish ?? _isFinish,
  correctCount: correctCount ?? _correctCount,
  questionCount: questionCount ?? _questionCount,
  parentIndex: parentIndex ?? _parentIndex,
  sublevelIndex: sublevelIndex ?? _sublevelIndex,
  time: time ?? _time,
  exerciseVos: exerciseVos ?? _exerciseVos,
);
  bool? get isFinish => _isFinish;
  num? get correctCount => _correctCount;
  num? get questionCount => _questionCount;
  num? get parentIndex => _parentIndex;
  num? get sublevelIndex => _sublevelIndex;
  num? get time => _time;
  List<ExerciseVos>? get exerciseVos => _exerciseVos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isFinish'] = _isFinish;
    map['correctCount'] = _correctCount;
    map['questionCount'] = _questionCount;
    map['parentIndex'] = _parentIndex;
    map['sublevelIndex'] = _sublevelIndex;
    map['time'] = _time;
    if (_exerciseVos != null) {
      map['exerciseVos'] = _exerciseVos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1648489081851772929
/// userId : 1
/// subjectId : 1648489081579143169
/// journalCatalogueId : 1647898280209838082
/// isFinish : false
/// time : "09:14:07"
/// exerciseLists : [{"id":1648489081851772929,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489081851772929,"answer":"fafdas","isRight":true,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772930,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083034566658,"answer":"2312321","isRight":false,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772931,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083361722369,"answer":"DFAGD","isRight":true,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772932,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083621769217,"answer":"zvffa","isRight":false,"createTime":"2023-04-19 17:24:00"},{"id":1648489081851772933,"userId":1,"exerciseId":1648489081851772929,"subjectId":1648489081579143169,"subtopicId":1648489083818901505,"answer":"exercise","isRight":true,"createTime":"2023-04-19 17:24:00"}]

class ExerciseVos {
  ExerciseVos({
      num? id, 
      num? userId, 
      num? subjectId, 
      num? correctCount,
      num? questionCount,
      num? journalCatalogueId,
      bool? isFinish, 
      num? time,
      List<ExerciseLists>? exerciseLists,}){
    _id = id;
    _userId = userId;
    _subjectId = subjectId;
    _correctCount = correctCount;
    _questionCount = questionCount;
    _journalCatalogueId = journalCatalogueId;
    _isFinish = isFinish;
    _time = time;
    _exerciseLists = exerciseLists;
}

  ExerciseVos.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _subjectId = json['subjectId'];
    _correctCount = json['correctCount'];
    _questionCount = json['questionCount'];
    _journalCatalogueId = json['journalCatalogueId'];
    _isFinish = json['isFinish'];
    _time = json['time'];
    if (json['exerciseLists'] != null) {
      _exerciseLists = [];
      json['exerciseLists'].forEach((v) {
        _exerciseLists?.add(ExerciseLists.fromJson(v));
      });
    }
  }
  num? _id;
  num? _userId;
  num? _subjectId;
  num? _correctCount;
  num? _questionCount;
  num? _journalCatalogueId;
  bool? _isFinish;
  num? _time;
  List<ExerciseLists>? _exerciseLists;
ExerciseVos copyWith({  num? id,
  num? userId,
  num? subjectId,
  num? correctCount,
  num? questionCount,
  num? journalCatalogueId,
  bool? isFinish,
  num? time,
  List<ExerciseLists>? exerciseLists,
}) => ExerciseVos(  id: id ?? _id,
  userId: userId ?? _userId,
  subjectId: subjectId ?? _subjectId,
  correctCount: correctCount ?? _correctCount,
  questionCount: questionCount ?? _questionCount,
  journalCatalogueId: journalCatalogueId ?? _journalCatalogueId,
  isFinish: isFinish ?? _isFinish,
  time: time ?? _time,
  exerciseLists: exerciseLists ?? _exerciseLists,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get subjectId => _subjectId;
  num? get correctCount => _correctCount;
  num? get questionCount => _questionCount;
  num? get journalCatalogueId => _journalCatalogueId;
  bool? get isFinish => _isFinish;
  num? get time => _time;
  List<ExerciseLists>? get exerciseLists => _exerciseLists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['subjectId'] = _subjectId;
    map['correctCount'] = _correctCount;
    map['questionCount'] = _questionCount;
    map['journalCatalogueId'] = _journalCatalogueId;
    map['isFinish'] = _isFinish;
    map['time'] = _time;
    if (_exerciseLists != null) {
      map['exerciseLists'] = _exerciseLists?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1648489081851772929
/// userId : 1
/// exerciseId : 1648489081851772929
/// subjectId : 1648489081579143169
/// subtopicId : 1648489081851772929
/// answer : "fafdas"
/// isRight : true
/// createTime : "2023-04-19 17:24:00"

class ExerciseLists {
  ExerciseLists({
      num? id, 
      num? userId, 
      num? exerciseId, 
      num? subjectId, 
      num? subtopicId, 
      String? answer, 
      bool? isRight, 
      String? createTime,}){
    _id = id;
    _userId = userId;
    _exerciseId = exerciseId;
    _subjectId = subjectId;
    _subtopicId = subtopicId;
    _answer = answer;
    _isRight = isRight;
    _createTime = createTime;
}

  ExerciseLists.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _exerciseId = json['exerciseId'];
    _subjectId = json['subjectId'];
    _subtopicId = json['subtopicId'];
    _answer = json['answer'];
    _isRight = json['isRight'];
    _createTime = json['createTime'];
  }
  num? _id;
  num? _userId;
  num? _exerciseId;
  num? _subjectId;
  num? _subtopicId;
  String? _answer;
  bool? _isRight;
  String? _createTime;
ExerciseLists copyWith({  num? id,
  num? userId,
  num? exerciseId,
  num? subjectId,
  num? subtopicId,
  String? answer,
  bool? isRight,
  String? createTime,
}) => ExerciseLists(  id: id ?? _id,
  userId: userId ?? _userId,
  exerciseId: exerciseId ?? _exerciseId,
  subjectId: subjectId ?? _subjectId,
  subtopicId: subtopicId ?? _subtopicId,
  answer: answer ?? _answer,
  isRight: isRight ?? _isRight,
  createTime: createTime ?? _createTime,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get exerciseId => _exerciseId;
  num? get subjectId => _subjectId;
  num? get subtopicId => _subtopicId;
  String? get answer => _answer;
  bool? get isRight => _isRight;
  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['exerciseId'] = _exerciseId;
    map['subjectId'] = _subjectId;
    map['subtopicId'] = _subtopicId;
    map['answer'] = _answer;
    map['isRight'] = _isRight;
    map['createTime'] = _createTime;
    return map;
  }

}