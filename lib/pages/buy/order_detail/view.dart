import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'logic.dart';

class OrderDetailPage extends BasePage {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToOrderDetailPageState();
}

class _ToOrderDetailPageState extends BasePageState<OrderDetailPage> {
  final logic = Get.put(Order_detailLogic());
  final state = Get.find<Order_detailLogic>().state;
  List listData = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("订单详情"),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: Text('已取消',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
          ),
          _layout_one(),
          SizedBox(
            width: double.infinity,
            height: 10.w,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xfff2f4f7)),
            ),
          ),
          _layout_two(),
          SizedBox(
            width: double.infinity,
            height: 10.w,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xfff2f4f7)),
            ),
          ),
          _layout_three(),
          SizedBox(
            width: double.infinity,
            height: 10.w,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xfff2f4f7)),
            ),
          ),
          _layout_four(),
          SizedBox(
            width: double.infinity,
            height: 10.w,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xfff2f4f7)),
            ),
          ),
          _layout_five(),
        ],
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Widget _layout_one() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20.w, right: 23.w, bottom: 24.w),
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                RouterUtil.toNamed(AppRoutes.RolePage);
              },
              child: Container(
                height: 26.w,
                width: 80.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  //圆角半径
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  //边框线宽、颜色
                  border: Border.all(width: 1.0, color: Color(0xffb4b9c6)),
                ),
                child: const Text('删除订单',
                    style: TextStyle(color: Color(0xff353e4d), fontSize: 14)),
              )),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20.w, bottom: 24.w),
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                RouterUtil.toNamed(AppRoutes.RolePage);
              },
              child: Container(
                height: 26.w,
                width: 80.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    //圆角半径
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: Colors.red),
                child: const Text('重新购买',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              )),
        ),
      ],
    );
  }

  Widget _layout_two() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('收货信息',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
        Row(
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
                    Image.asset(
                      R.imagesShopAddressLocationIcon,
                      fit: BoxFit.cover,
                      width: 22.w,
                      height: 22.w,
                    ),
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
                          borderRadius: BorderRadius.all(Radius.circular(0.w)),
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20.w, right: 23.w, bottom: 24.w),
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    RouterUtil.toNamed(AppRoutes.RolePage);
                  },
                  child: Container(
                    height: 26.w,
                    width: 80.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      //圆角半径
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      //边框线宽、颜色
                      border: Border.all(width: 1.0, color: Color(0xffb4b9c6)),
                    ),
                    child: const Text('修改',
                        style:
                            TextStyle(color: Color(0xff353e4d), fontSize: 14)),
                  )),
            ),
          ],
        )
      ],
    );
  }

  Widget _layout_three() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('订单详情',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: listData.map((value) {
            return listitem(value);
          }).toList(),
        ),
      ],
    );
  }

  Widget _layout_four() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('付款信息',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 0.w),
                child: Text(
                  '￥已选：中考综合',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w400),
                )),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 0.w),
              child: Text('￥199.00',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        Text('已取消',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600))
      ],
    );
  }

  Widget _layout_five() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('订单信息',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
        Row(
          children: [
            Text("订单编号： ",
                style: TextStyle(
                    color: Color(0xff151619),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 14.w),
            Text("384028392827484728",
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
                  borderRadius: BorderRadius.all(Radius.circular(0.w)),
                  color: Color(0xfffcecee)),
              child: Text("复制",
                  style: TextStyle(
                      color: AppColors.THEME_COLOR,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ),
        Row(
          children: [
            Text("订单编号： ",
                style: TextStyle(
                    color: Color(0xff151619),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 14.w),
            Text("384028392827484728",
                style: TextStyle(
                    color: Color(0xff151619),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        Row(
          children: [
            Text("订单编号： ",
                style: TextStyle(
                    color: Color(0xff151619),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 14.w),
            Text("384028392827484728",
                style: TextStyle(
                    color: Color(0xff151619),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }

  Widget listitem(value) {
    return Container(
        padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
        child: Container(
            height: 80.w,
            margin: EdgeInsets.only(left: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '已选：中考综合',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff151619),
                      fontWeight: FontWeight.w900),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 8.w, bottom: 0.w),
                        child: Text(
                          '￥已选：中考综合',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff858aa0),
                              fontWeight: FontWeight.w400),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w, bottom: 0.w),
                      child: Text('￥199.00',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            )));
  }
}
