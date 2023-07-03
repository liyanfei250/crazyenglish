import 'package:crazyenglish/blocs/update_class_event.dart';
import 'package:crazyenglish/blocs/update_class_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//新建班级的刷新处理
class UpdateClassBloc extends Bloc<ClassChangeEvent, ClassChangeState> {
  UpdateClassBloc() : super(ClassChangeInitial());

  @override
  Stream<ClassChangeState> mapEventToState(
    ClassChangeEvent event,
  ) async* {
    if (event is SendClassChangeEvent) {
      yield ClassChangeSuccess();
    }
  }
}
