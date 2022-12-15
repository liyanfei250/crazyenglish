import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index_logic.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final logic = Get.put(IndexLogic());
  final state = Get.find<IndexLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<IndexLogic>();
    super.dispose();
  }
}