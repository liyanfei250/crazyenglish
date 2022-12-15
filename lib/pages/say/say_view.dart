import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'say_logic.dart';

class SayPage extends StatefulWidget {
  const SayPage({Key? key}) : super(key: key);

  @override
  _SayPageState createState() => _SayPageState();
}

class _SayPageState extends State<SayPage> {
  final logic = Get.put(SayLogic());
  final state = Get.find<SayLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<SayLogic>();
    super.dispose();
  }
}