import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config_logic.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final logic = Get.put(ConfigLogic());
  final state = Get.find<ConfigLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<ConfigLogic>();
    super.dispose();
  }
}