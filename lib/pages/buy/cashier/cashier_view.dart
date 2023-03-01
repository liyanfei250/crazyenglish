import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'CounterDownPage.dart';
import 'cashier_logic.dart';

class CashierPage extends BasePage {
  const CashierPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToCashierPageState();
}

class _ToCashierPageState extends BasePageState<CashierPage> {
  final logic = Get.put(CashierLogic());
  final state = Get.find<CashierLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("收银台"),
        backgroundColor: AppColors.theme_bg,
        // 判断列表数量是否大于0
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 23.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "支付剩余时间",
                style: TextStyle(
                    color: Color(0xff6a6e7e),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              CounterDownPage(),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10.w),
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LineDate(),
                    Divider(
                      height: 1.w,
                    ),
                    LineDateTwo(),
                    Divider(
                      height: 1.w,
                    ),
                    LineDateThree(),
                    Divider(
                      height: 1.w,
                    ),
                    LineDateFour(),
                    Divider(
                      height: 1.w,
                    ),
                    LineDateFive(),
                    Divider(
                      height: 1.w,
                    ),
                    LineDateSix(),
                  ],
                ),
              ),
              SizedBox(
                height: 13.w,
              ),
              LineDateSeven(),
              Container(
                width: 347.w,
                height: 48.w,
                margin: EdgeInsets.only(top: 26.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.w)),
                    color: AppColors.c_FFFF4D35),
                child: Text(
                  "立即支付",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Widget LineDate() => Container(
        width: double.infinity,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: 17.w, bottom: 11.w, left: 10.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "商品名称",
                  maxLines: 1,
                  style: TextStyle(
                      color: Color(0xff393939),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                )),
            Expanded(
              flex: 1,
              child: Text(
                "英语周刊 年度订阅 英语周刊 月度订阅",
                maxLines: 2,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Color(0xff393939),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      );

  Widget LineDateTwo() => Container(
        width: double.infinity,
        height: 50.w,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: 17.w, bottom: 8.w, left: 10.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              "商品金额",
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )),
            Text(
              "¥ 218.90",
              maxLines: 2,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  Widget LineDateThree() => Container(
        width: double.infinity,
        height: 50.w,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: 17.w, bottom: 8.w, left: 10.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              "运费",
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )),
            Text(
              "¥ 0.00",
              maxLines: 2,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  Widget LineDateFour() => Container(
        width: double.infinity,
        height: 50.w,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: 17.w, bottom: 8.w, left: 10.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              "优惠券",
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )),
            Text(
              "-¥ 0.00",
              maxLines: 2,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  Widget LineDateFive() => Container(
        width: double.infinity,
        height: 50.w,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: 17.w, bottom: 8.w, left: 10.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              "礼品卡",
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )),
            Text(
              "无",
              maxLines: 2,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );

  Widget LineDateSix() => Container(
        width: double.infinity,
        height: 50.w,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: 17.w, bottom: 8.w, left: 10.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              "发票",
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )),
            Text(
              "普票（个人）",
              maxLines: 2,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );

  Widget LineDateSeven() => InkWell(
      onTap: () {
        RouterUtil.toNamed(AppRoutes.MyOrderPage);
        RouterUtil.toNamed(AppRoutes.OrderDetailPage);
      },
      child: Container(
        width: double.infinity,
        height: 50.w,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: 17.w, bottom: 8.w, left: 25.w, right: 29.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              "支付方式",
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )),
            Text(
              "微信支付",
              maxLines: 2,
              style: TextStyle(
                  color: Color(0xff393939),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ));
}
