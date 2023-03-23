import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../utils/colors.dart';
import 'scan_audio_message_logic.dart';

class Scan_audio_messagePage  extends  BasePage {
  const Scan_audio_messagePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<Scan_audio_messagePage> {
  final logic = Get.put(Scan_audio_messageLogic());
  final state = Get.find<Scan_audio_messageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("扫描结果"),
      backgroundColor: AppColors.theme_bg,
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
