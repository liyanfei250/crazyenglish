import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'read_practise_logic.dart';

class ReadPractisePage extends StatefulWidget {
  const ReadPractisePage({Key? key}) : super(key: key);

  @override
  _ReadPractisePageState createState() => _ReadPractisePageState();
}

class _ReadPractisePageState extends State<ReadPractisePage> {
  final logic = Get.put(ReadPractiseLogic());
  final state = Get.find<ReadPractiseLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<ReadPractiseLogic>();
    super.dispose();
  }
}