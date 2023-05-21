/// sourceId : 1648489081579143169
/// type : 2
/// content : "wwww"
/// imgs : ["diamond/performance.png","diamond/building.png"]

class FeedbackRequest {
  FeedbackRequest({
      num? sourceId, 
      num? type, 
      String? content, 
      List<String>? imgs,}){
    _sourceId = sourceId;
    _type = type;
    _content = content;
    _imgs = imgs;
}

  FeedbackRequest.fromJson(dynamic json) {
    _sourceId = json['sourceId'];
    _type = json['type'];
    _content = json['content'];
    _imgs = json['imgs'] != null ? json['imgs'].cast<String>() : [];
  }
  num? _sourceId;
  num? _type;
  String? _content;
  List<String>? _imgs;
FeedbackRequest copyWith({  num? sourceId,
  num? type,
  String? content,
  List<String>? imgs,
}) => FeedbackRequest(  sourceId: sourceId ?? _sourceId,
  type: type ?? _type,
  content: content ?? _content,
  imgs: imgs ?? _imgs,
);
  num? get sourceId => _sourceId;
  num? get type => _type;
  String? get content => _content;
  List<String>? get imgs => _imgs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sourceId'] = _sourceId;
    map['type'] = _type;
    map['content'] = _content;
    map['imgs'] = _imgs;
    return map;
  }

}