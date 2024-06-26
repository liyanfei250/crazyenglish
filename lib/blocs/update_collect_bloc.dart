import 'package:crazyenglish/blocs/update_collect_event.dart';
import 'package:crazyenglish/blocs/update_collect_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//收藏取消的刷新处理
class UpdateCollectBloc extends Bloc<CollectChangeEvent, CollectChangeState> {
  UpdateCollectBloc() : super(CollectChangeInitial());

  @override
  Stream<CollectChangeState> mapEventToState(
    CollectChangeEvent event,
  ) async* {
    if (event is SendCollectChangeEvent) {
      yield CollectChangeSuccess();
    }
  }
}
