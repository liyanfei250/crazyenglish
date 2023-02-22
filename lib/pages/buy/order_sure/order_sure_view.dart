import 'package:crazyenglish/pages/dialog/address_edit_dialog/address_add.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'order_sure_logic.dart';

class OrderSurePage extends BasePage {
  const OrderSurePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToOrderSurePageState();
}

class _ToOrderSurePageState extends BasePageState<OrderSurePage> {
  final logic = Get.put(Order_sureLogic());
  final state = Get.find<Order_sureLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("确认订单"),
        backgroundColor: AppColors.theme_bg,
        // 判断列表数量是否大于0
        body: Stack(
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
                addAdddress(context),
                showAdddress(context),
                cartItem(),
                cartItem(),
                payInfo(),
                // 和全选按钮来点距离
                SizedBox(height: 100.0)
              ],
            ),

            // 底部按钮条
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 78.0,
                padding: EdgeInsets.only(left: 9.w),
                // 顶部线条
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 2.0, color: Colors.black12)),
                    color: Colors.white),

                // 左全选 右结算
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // 全选
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      // 左单选框 右文本
                      children: <Widget>[
                        Text("实付金额："),
                        Text("¥ 564",
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp))
                      ],
                    ),
                    // 结算
                    ElevatedButton(
                      child: Text("立即购买",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                      // onPressed: doCheckOut,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        RouterUtil.toNamed(AppRoutes.CashierPage);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Widget addAdddress(BuildContext context) => Center(
          child: Container(
        width: 347.w,
        height: 71.w,
        margin: EdgeInsets.only(top: 11.w, left: 14.w, right: 14.w),
        decoration: BoxDecoration(
            color: AppColors.c_FFFFFFFF,
            borderRadius: BorderRadius.all(Radius.circular(6.w))),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _clickOk();
            showDialog(
              context: context,
              builder: (context) => MyDialog("添加收货地址", "content"),
            );
          },
          child: Center(
            child: Text("+ 添加地址",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ),
        )
        /* child: Center(
          child: Row(
          mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(left: 7.w)),
              Image.asset(
                R.imagesHomeSearch,
                width: 18.w,
                height: 18.w,
              ),
              Padding(padding: EdgeInsets.only(left: 6.w)),
              Text(
                "+添加地址",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
              )
            ],
          ))*/

        ,
      ));

  Widget showAdddress(BuildContext context) => Center(
      child: Container(
          width: 347.w,
          height: 71.w,
          margin: EdgeInsets.only(top: 11.w, left: 14.w, right: 14.w),
          padding: EdgeInsets.only(left: 14.w, right: 14.w),
          decoration: BoxDecoration(
              color: AppColors.c_FFFFFFFF,
              borderRadius: BorderRadius.all(Radius.circular(6.w))),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _clickOk();
              showDialog(
                context: context,
                builder: (context) => MyDialog("添加收货地址", "content"),
              );
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("豆豆",
                              style: TextStyle(
                                  color: Color(0xff151619),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 14.w),
                          Text("+86 18902837192",
                              style: TextStyle(
                                  color: Color(0xff151619),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 30.w),
                          Container(
                            width: 25.w,
                            height: 12.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.w)),
                                color: Color(0xfffcecee)),
                            child: Text("默认",
                                style: TextStyle(
                                    color: AppColors.THEME_COLOR,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                      SizedBox(height: 5.w),
                      Text("山西太原小店区鸿泰国际大厦",
                          style: TextStyle(
                              color: Color(0xff6a6e7e),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700))
                    ],
                  )),
                  Image.asset(
                    'images/icon_to_next.png',
                    fit: BoxFit.cover,
                    width: 22.w,
                    height: 22.w,
                  ),
                ],
              ),
            ),
          )));

  Widget cartItem() => InkWell(
        onTap: () {
          // RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,arguments: weekPaperList![index]);
        },
        child: Container(
          width: 332.w,
          height: 92.w,
          margin: EdgeInsets.only(top: 11.w, left: 14.w, right: 14.w),
          padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.c_0FA50D1A.withOpacity(0.05), // 阴影的颜色
                  offset: Offset(10, 20), // 阴影与容器的距离
                  blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                  spreadRadius: 0,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
              color: AppColors.c_FFFFFFFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 62.w,
                height: 76.w,
                margin: EdgeInsets.only(left: 7.w, right: 16.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://fanyi-cdn.cdn.bcebos.com/static/translation/img/header/logo_e835568.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(6.w)),
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 4.w, bottom: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "英语周刊 年度订阅",
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.c_FF101010,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "已选：高考综合",
                              style: TextStyle(
                                  color: AppColors.TEXT_GRAY_COLOR,
                                  fontSize: 12.sp),
                            ),
                            Text("￥ 199.00",
                                style: TextStyle(
                                    color: AppColors.TEXT_GRAY_COLOR,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      );

  Widget payInfo() => Container(
      width: 332.w,
      height: 92.w,
      margin: EdgeInsets.only(top: 11.w, left: 14.w, right: 14.w),
      padding: EdgeInsets.only(top: 8.w, bottom: 8.w, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.c_0FA50D1A.withOpacity(0.05), // 阴影的颜色
              offset: Offset(10, 20), // 阴影与容器的距离
              blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(6.w)),
          color: AppColors.c_FFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "付款信息",
            maxLines: 1,
            style: TextStyle(
                color: AppColors.c_FF101010,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "商品金额",
                maxLines: 1,
                style: TextStyle(
                    color: AppColors.c_FF101010,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              )),
              Text(
                "￥218.90",
                maxLines: 1,
                style: TextStyle(
                    color: AppColors.c_FF101010,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              "合计：",
              maxLines: 1,
              style: TextStyle(
                  color: AppColors.c_FF101010,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "￥218.90",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            )
          ])
        ],
      ));
}

_clickOk() {}
