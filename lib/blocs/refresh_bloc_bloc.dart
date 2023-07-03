import 'package:bloc/bloc.dart';

import 'refresh_bloc_event.dart';
import 'refresh_bloc_state.dart';

class RefreshBlocBloc extends Bloc<RefreshBlocEvent, RefreshBlocState> {
  RefreshBlocBloc() : super(RefreshBlocState().init());

  @override
  Stream<RefreshBlocState> mapEventToState(RefreshBlocEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
    else if(event is RefreshPersonInfoEvent){
      yield RefreshPersonInfoState();
    }else if(event is RefreshAnswerStateInfoEvent){
      yield RefreshAnswerState();
    }else if(event is RefreshPreviewExamPaperEvent){
      yield RefreshPreviewExamPaperState();
    }
  }

  Future<RefreshBlocState> init() async {
    return state.clone();
  }
}
