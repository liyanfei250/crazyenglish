import 'package:crazyenglish/blocs/refresh_bloc_bloc.dart';
import 'package:crazyenglish/blocs/update_collect_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login_change_bloc.dart';
import 'app_start.dart';
import 'local_db.dart';


/// 说明: Bloc提供器包裹层

final AppStart storage = AppStart();

class BlocWrapper extends StatefulWidget {
  final Widget? child;

  BlocWrapper({this.child});

  @override
  _BlocWrapperState createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<BlocWrapper> {
  // final WidgetRepository repository = WidgetDbRepository();
  //
  // final categoryBloc = CategoryBloc(repository: CategoryDbRepository());
  // final authBloc = AuthenticBloc()..add(const AppStarted());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        //使用MultiBlocProvider包裹
        providers: [
          //Bloc提供器
          BlocProvider<LoginChangeBloc>(create: (_) => LoginChangeBloc()),
          BlocProvider<RefreshBlocBloc>(create: (_) => RefreshBlocBloc()),
          BlocProvider<UpdateCollectBloc>(create: (_) => UpdateCollectBloc()),
        ], child: widget.child!);
  }

  @override
  void dispose() {
    // categoryBloc.close();
    // authBloc.close();
    LocalDb.instance.closeDb();
    super.dispose();
  }
}
