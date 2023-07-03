import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'my_order_list_logic.dart';

class MyOrderPage extends BasePage {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<MyOrderPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(My_order_listLogic());
  final state = Get.find<My_order_listLogic>().state;
  List listDataOne = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
    {"title": "03.语篇理解", "type": 2},
    {"title": "04.听力填空", "type": 3},
  ];
  List listData = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
  ];
  final List<String> tabs = const [
    '全部',
    '待支付',
    '已支付',
    '已取消',
    '已退款',
  ];
  late TabController _tabController;

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onDestroy() {
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: buildBottomAppBar("我的订单"),
        backgroundColor: AppColors.theme_bg,
        body: TabBarView(
          controller: _tabController,
          //构建
          children: tabs.map((e) {
            return Container(
              alignment: Alignment.center,
              child: ListView(
                children: listDataOne.map((value) {
                  return listitemBigBg();
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  AppBar buildBottomAppBar(String text) {
    return AppBar(
      backgroundColor: AppColors.c_FFFFFFFF,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
      ),
      leading: Util.buildBackWidget(context),
      bottom: TabBar(
        onTap: (tab) => print(tab),
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        isScrollable: true,
        controller: _tabController,
        labelColor: Colors.black,
        indicatorWeight: 3,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.transparent,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  Widget listitemBigBg() {
    return Container(
      margin: EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 10.w),
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 10.w),
      width: double.infinity,
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
              offset: Offset(10, 20), // 阴影与容器的距离
              blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: AppColors.c_FFFFFFFF),
      child: listitemBig(),
    );
  }

  Widget listitemBig() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text(
                  '2023年02月09日 14:50:39',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text('已完成',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 1.w,
        ),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: listData.map((value) {
            return listitem(value);
          }).toList(),
        ),
        Divider(
          color: Colors.grey,
          height: 1.w,
        ),
        _bottomOne(),
        _bottomTwo(),
      ],
    );
  }

  Widget listitem(value) {
    return Container(
      padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                R.imagesShopImageLogoTest,
                width: 80.w,
                height: 80.w,
              )),
          Expanded(
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
                  )))
        ],
      ),
    );
  }

  Widget _bottomOne() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '共2件商品',
          style: TextStyle(
              fontSize: 12,
              color: Color(0xff858aa0),
              fontWeight: FontWeight.w500),
        ),
        Expanded(child: Text('')),
        Text('合计：',
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff353e4d),
                fontWeight: FontWeight.w600)),
        Padding(
            padding: EdgeInsets.only(top: 14.w, bottom: 0.w),
            child: Text('¥218.90',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffeb5447),
                    fontWeight: FontWeight.w600)))
      ],
    );
  }

  Widget _bottomTwo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 24.w, right: 23.w),
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
          margin: EdgeInsets.only(
            top: 24.w,
          ),
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
}
