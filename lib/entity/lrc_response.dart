/// childQuestionItem : []
/// serialNumber : "TOEFL--0TF-T58-L-C1"
/// start : 0
/// createUser : "学员zbdde"
/// end : 8020
/// sortNum : 1
/// entext : "Narrator: Listen to a conversation between a student and an employee in the university work study office."
/// id : 166798
/// cntext : "旁白：听大学勤工俭学办公室中学生和员工之间的对话。"

class LrcResponse {
  String? _serialNumber;
  int? _start;
  String? _createUser;
  int? _end;
  int? _sortNum;
  String? _entext;
  int? _id;
  String? _cntext;

  String? get serialNumber => _serialNumber;
  int? get start => _start;
  String? get createUser => _createUser;
  int? get end => _end;
  int? get sortNum => _sortNum;
  String? get entext => _entext;
  int? get id => _id;
  String? get cntext => _cntext;

  LrcResponse({
      String? serialNumber,
      int? start, 
      String? createUser, 
      int? end, 
      int? sortNum, 
      String? entext, 
      int? id, 
      String? cntext}){
    _serialNumber = serialNumber;
    _start = start;
    _createUser = createUser;
    _end = end;
    _sortNum = sortNum;
    _entext = entext;
    _id = id;
    _cntext = cntext;
}

  LrcResponse.fromJson(dynamic json) {
    _serialNumber = json['serialNumber'];
    _start = json['start'];
    _createUser = json['createUser'];
    _end = json['end'];
    _sortNum = json['sortNum'];
    _entext = json['entext'];
    _id = json['id'];
    _cntext = json['cntext'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['serialNumber'] = _serialNumber;
    map['start'] = _start;
    map['createUser'] = _createUser;
    map['end'] = _end;
    map['sortNum'] = _sortNum;
    map['entext'] = _entext;
    map['id'] = _id;
    map['cntext'] = _cntext;
    return map;
  }

}