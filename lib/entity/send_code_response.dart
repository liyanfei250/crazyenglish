/// code : "OK"
/// message : "OK"

class SendCodeResponse {
  String _data;


  String get data => _data;

  set data(String value) {
    _data = value;
  }

  SendCodeResponse(this._data);


}