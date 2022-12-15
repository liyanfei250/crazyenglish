

import 'package:flutter/cupertino.dart';

enum ViewState {Loading, Success , Failure}

class BaseModel extends ChangeNotifier{
  ViewState _state = ViewState.Loading;

  ViewState get state => _state;

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }
}