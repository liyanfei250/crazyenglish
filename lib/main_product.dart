import 'package:flutter/material.dart';
import 'package:crazyenglish/config.dart';
import 'package:flutter_bugly/flutter_bugly.dart';

import 'base/bloc_wrapper.dart';
import 'base/global.dart';
import 'main.dart';

void main() {
  Config.env = Env.PRODUCT;
  Global.init(() {
    FlutterBugly.postCatchedException(() {
      runApp(BlocWrapper(child: MyApp()));
    }, debugUpload: true);
  });
}

