import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../utils/colors.dart';
import 'logic.dart';

class OrderDetailPage extends BasePage {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToOrderDetailPageState();
}

class _ToOrderDetailPageState extends BasePageState<OrderDetailPage> {
  final logic = Get.put(Order_detailLogic());
  final state = Get.find<Order_detailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("订单详情"),
      backgroundColor: AppColors.theme_bg,
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
