import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'learn_logic.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final logic = Get.put(LearnLogic());
  final state = Get.find<LearnLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<LearnLogic>();
    super.dispose();
  }
}