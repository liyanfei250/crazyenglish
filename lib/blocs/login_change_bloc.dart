import 'dart:async';

import 'package:bloc/bloc.dart';

import 'login_change_event.dart';
import 'login_change_state.dart';


class LoginChangeBloc extends Bloc<LoginChangeEvent, LoginChangeState> {
  LoginChangeBloc() : super(LoginChangeInitial());

  @override
  Stream<LoginChangeState> mapEventToState(
    LoginChangeEvent event,
  ) async* {
    if(event is SendLoginChangeEvent){
      yield LoginChangeSuccess();
    }
  }
}
