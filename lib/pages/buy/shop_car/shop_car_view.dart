import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../provider/CheckOutProvider.dart';
import '../provider/cartItem.dart';
import 'shop_car_logic.dart';

class ShopCarPage extends BasePage {
  const ShopCarPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToShopCarPageState();
}

class _ToShopCarPageState extends BasePageState<ShopCarPage> {
  final logic = Get.put(Shop_carLogic());
  final state = Get.find<Shop_carLogic>().state;
  late TabController _tabController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late CheckOutProvider _checkOutProvider;

// 是否编辑状态支持删除
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("购物车"),
        backgroundColor: AppColors.theme_bg,
        // 判断列表数量是否大于0
        body: /*cartProvider.cartList.length > 0
            ? */
            Stack(
          // 上ListView 下Position
          children: <Widget>[
            // 商品·列表
            ListView(
              children: <Widget>[
                // 加入Column, 商品数量多时候不会被全选按钮覆盖
                Column(
                    /*children: cartProvider.cartList.map((value) {
                          return CartItem(value);
                        }).toList(),*/
                    ),
                CartItem(),
                CartItem(),
                CartItem(),
              ],
            ),

            // 底部按钮条
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 56.w,
                padding: EdgeInsets.only(left: 20.w),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // 全选
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      // 左单选框 右文本
                      children: <Widget>[
                        Text("合计："),
                        Text("¥ 218.90",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    // 结算
                    InkWell(
                      onTap: () {
                        RouterUtil.toNamed(AppRoutes.OrderSurePage);
                      },
                      child: Container(
                        width: 130.w,
                        height: 56.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffeb4c4a), Color(0xffee7d7a)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )),
                        child: Text("去支付",
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
        /*: Center(
                child: Text("购物车是空的..."),
              )*/
        );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
