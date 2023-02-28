/*
class MyOrderPage extends  BasePage {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<MyOrderPage> {
  final logic = Get.put(My_order_listLogic());
  final state = Get.find<My_order_listLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("我的订单"),
      backgroundColor: AppColors.theme_bg,
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
*/
