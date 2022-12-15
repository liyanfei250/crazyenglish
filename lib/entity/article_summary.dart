/// forward_count : 0
/// click_count : 1
/// read_count : 3
/// publish_count : 1

class ArticleSummary {
  int? _forwardCount;
  int? _clickCount;
  int? _readCount;
  int? _publishCount;

  int? get forwardCount => _forwardCount;
  int? get clickCount => _clickCount;
  int? get readCount => _readCount;
  int? get publishCount => _publishCount;

  ArticleSummary({
      int? forwardCount, 
      int? clickCount, 
      int? readCount, 
      int? publishCount}){
    _forwardCount = forwardCount;
    _clickCount = clickCount;
    _readCount = readCount;
    _publishCount = publishCount;
}

  ArticleSummary.fromJson(dynamic json) {
    _forwardCount = json['forward_count'];
    _clickCount = json['click_count'];
    _readCount = json['read_count'];
    _publishCount = json['publish_count'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['forward_count'] = _forwardCount;
    map['click_count'] = _clickCount;
    map['read_count'] = _readCount;
    map['publish_count'] = _publishCount;
    return map;
  }

}