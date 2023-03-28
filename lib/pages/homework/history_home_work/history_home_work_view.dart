import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'history_home_work_logic.dart';

/**
 * 历史作业
 */
class HistoryHomeWorkPage extends StatefulWidget {
  const HistoryHomeWorkPage({Key? key}) : super(key: key);

  @override
  State<HistoryHomeWorkPage> createState() => _HistoryHomeWorkPageState();
}

class _HistoryHomeWorkPageState extends State<HistoryHomeWorkPage> {
  final logic = Get.put(HistoryHomeWorkLogic());
  final state = Get.find<HistoryHomeWorkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<HistoryHomeWorkLogic>();
    super.dispose();
  }
}