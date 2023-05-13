/// p : {"current":1,"size":10}
/// actionType : 1
/// teacherId : "228"
/// schoolClassId : "953"
/// startDate : "2023-05-04"
/// endDate : "2023-05-04"
/// orderType : "460"

class HomeworkRequest {
  HomeworkRequest({
      P? p, 
      num? actionType, 
      String? teacherId, 
      String? schoolClassId, 
      String? startDate, 
      String? endDate, 
      String? orderType,}){
    _p = p;
    _actionType = actionType;
    _teacherId = teacherId;
    _schoolClassId = schoolClassId;
    _startDate = startDate;
    _endDate = endDate;
    _orderType = orderType;
}

  HomeworkRequest.fromJson(dynamic json) {
    _p = json['p'] != null ? P.fromJson(json['p']) : null;
    _actionType = json['actionType'];
    _teacherId = json['teacherId'];
    _schoolClassId = json['schoolClassId'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _orderType = json['orderType'];
  }
  P? _p;
  num? _actionType;
  String? _teacherId;
  String? _schoolClassId;
  String? _startDate;
  String? _endDate;
  String? _orderType;
HomeworkRequest copyWith({  P? p,
  num? actionType,
  String? teacherId,
  String? schoolClassId,
  String? startDate,
  String? endDate,
  String? orderType,
}) => HomeworkRequest(  p: p ?? _p,
  actionType: actionType ?? _actionType,
  teacherId: teacherId ?? _teacherId,
  schoolClassId: schoolClassId ?? _schoolClassId,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  orderType: orderType ?? _orderType,
);
  P? get p => _p;
  num? get actionType => _actionType;
  String? get teacherId => _teacherId;
  String? get schoolClassId => _schoolClassId;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get orderType => _orderType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_p != null) {
      map['p'] = _p?.toJson();
    }
    map['actionType'] = _actionType;
    map['teacherId'] = _teacherId;
    map['schoolClassId'] = _schoolClassId;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['orderType'] = _orderType;
    return map;
  }

}

/// current : 1
/// size : 10

class P {
  P({
      num? current, 
      num? size,}){
    _current = current;
    _size = size;
}

  P.fromJson(dynamic json) {
    _current = json['current'];
    _size = json['size'];
  }
  num? _current;
  num? _size;
P copyWith({  num? current,
  num? size,
}) => P(  current: current ?? _current,
  size: size ?? _size,
);
  num? get current => _current;
  num? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current'] = _current;
    map['size'] = _size;
    return map;
  }

}