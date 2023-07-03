import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'app_update_panel_logic.dart';


class UpdateRedPoint extends StatelessWidget {
  const UpdateRedPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AppUpdatePanelLogic());
    final state = Get.find<AppUpdatePanelLogic>().state;
    Widget radPoint = Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
    return GetBuilder<AppUpdatePanelLogic>(builder: (logic){
      // if (state is ShouldUpdateState) {
        return radPoint;
      // } else {
      //   return const SizedBox.shrink();
      // }
    });
  }
}
