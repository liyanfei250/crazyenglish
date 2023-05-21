import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'refresh_bloc_bloc.dart';
import 'refresh_bloc_event.dart';
import 'refresh_bloc_state.dart';

class RefreshBlocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RefreshBlocBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<RefreshBlocBloc>(context);

    return Container();
  }
}

