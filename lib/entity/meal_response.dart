/// meal : "季度版 原价¥168"
/// money : "98"
/// period_of_validity : 3
/// id : 1
/// validity : 1

class MealResponse {
  String? _meal;
  String? _money;
  int? _periodOfValidity;
  int? _id;
  int? _validity;

  String? get meal => _meal;
  String? get money => _money;
  int? get periodOfValidity => _periodOfValidity;
  int? get id => _id;
  int? get validity => _validity;

  MealResponse({
      String? meal, 
      String? money, 
      int? periodOfValidity, 
      int? id, 
      int? validity}){
    _meal = meal;
    _money = money;
    _periodOfValidity = periodOfValidity;
    _id = id;
    _validity = validity;
}

  MealResponse.fromJson(dynamic json) {
    _meal = json['meal'];
    _money = json['money'];
    _periodOfValidity = json['period_of_validity'];
    _id = json['id'];
    _validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['meal'] = _meal;
    map['money'] = _money;
    map['period_of_validity'] = _periodOfValidity;
    map['id'] = _id;
    map['validity'] = _validity;
    return map;
  }

}

class MealResponseList{
  List<MealResponse>? _list;

  List<MealResponse>? get list => _list;

  setList(List<MealResponse> value) {
    _list = value;
  }

  MealResponseList(List<MealResponse>? list) {
    this._list = list;
  }

  MealResponseList.fromJson(dynamic json) {
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(MealResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}