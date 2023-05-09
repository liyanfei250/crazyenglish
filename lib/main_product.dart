import 'package:flutter/material.dart';
import 'package:crazyenglish/config.dart';

import 'base/bloc_wrapper.dart';
import 'base/global.dart';
import 'main.dart';

void main() {
  Config.env = Env.PRODUCT;
  Global.init(() {
    runApp(BlocWrapper(child: MyApp()));
  });
}

