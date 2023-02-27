import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import 'role_two_logic.dart';

class RoleTwoPage extends BasePage {
  const RoleTwoPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToRoleTwoPageState();
}

class _ToRoleTwoPageState extends BasePageState<RoleTwoPage> {
  final logic = Get.put(Role_twoLogic());
  final state = Get.find<Role_twoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.theme_bg,
      body: Stack(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.imagesLoginTopBg), fit: BoxFit.cover),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OutlinedButton(
              onPressed: onPressed,
              child: Text('跳过'),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  void onPressed() {}
}
