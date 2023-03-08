import 'dart:async';
import 'dart:ui' as ui;
import 'package:crazyenglish/pages/practtise_history/CustomDecoration.dart';
import 'package:crazyenglish/pages/practtise_history/MyDecoration.dart';
import 'package:crazyenglish/pages/practtise_history/XFDashedLine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import 'LeftLineWidget.dart';
import 'practtise_history_logic.dart';

class PracttiseHistoryPage extends BasePage {
  const PracttiseHistoryPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToPracttiseHistoryPageState();
}

class _ToPracttiseHistoryPageState extends BasePageState<PracttiseHistoryPage> {
  final logic = Get.put(Practtise_historyLogic());
  final state = Get.find<Practtise_historyLogic>().state;
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
      "title": "01.期末综合能力评估试题",
      "type": 0,
    },
    {"title": "02.期末综合能力评估试题", "type": 1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.theme_bg,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250.w,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.imagesPracticeBlackBg),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 60.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 14.w, right: 14.w),
                      child: Image.asset(
                        R.imagesIconBackBlack,
                        fit: BoxFit.fill,
                        color: Colors.white,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          '练习记录',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 116.w,
                  margin: EdgeInsets.only(top: 42.w, left: 26.w, right: 26.w),
                  padding: EdgeInsets.only(left: 22.w, right: 22.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(R.imagesPracticeGoldTop),
                        fit: BoxFit.scaleDown),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                          child: Image.asset(
                        R.imagesShopImageLogoTest,
                        width: 42.w,
                        height: 42.w,
                      )),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: Text('练习训练：348次'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 214.w,
              ),
              padding: EdgeInsets.only(
                  left: 14.w, right: 14.w, top: 10.w, bottom: 10.w),
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  /*boxShadow: [
                        BoxShadow(
                          color: AppColors.c_FFFFEBEB.withOpacity(0.5),
                          // 阴影的颜色
                          offset: Offset(10, 20),
                          // 阴影与容器的距离
                          blurRadius: 45.0,
                          // 高斯的标准偏差与盒子的形状卷积。
                          spreadRadius: 10.0,
                        )
                      ],*/
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.w),
                      topRight: Radius.circular(12.w)),
                  color: Colors.white),
              child: newLayout())
        ],
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Widget listitemBigBg() {
    return Container(
      width: double.infinity,
      alignment: Alignment.topRight,
      color: Colors.yellow,
      // child: listitemBig(),
      child: newLayout(),
    );
  }

  Widget listitemBigBgNew(value, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // 圆和线
              height: 35,
              child: LeftLineWidget(
                  showTop: index == 0 ? false : true,
                  showBottom: true,
                  isLight: false),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '2023.2.24',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ))
          ],
        ),
        //这里需要自定义虚线BoxDecoration
        Container(
          decoration: MyDecoration(),
          margin: EdgeInsets.only(left: 24),
          padding: EdgeInsets.fromLTRB(22, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listData.map((value) {
              return listitem(value);
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget listitemBig() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              R.imagesTimePointIcon,
              width: 15.w,
              height: 15.w,
            ),
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text(
                  '2023.2.24',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff1b1d2c),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
          ],
        ),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: listData.map((value) {
            return listitem(value);
          }).toList(),
        )
      ],
    );
  }

  Widget listitem(value) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(top: 20.w)),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value['title'],
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff353e4d)),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      width: 48.w,
                      height: 17.w,
                      margin: EdgeInsets.only(top: 7.w),
                      padding: EdgeInsets.only(
                          top: 2.w, bottom: 2.w, left: 5.w, right: 5.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.w)),
                          color: Color(0xfff3f3f6)),
                      child: Text("16:48",
                          style: TextStyle(
                              color: Color(0xff656d8f),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.w, left: 13.w),
                      child: Text(
                        '60%正确率',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff898a93)),
                      ),
                    )
                  ])
                ],
              ),
              Expanded(child: Text('')),
              Image.asset(
                R.imagesNextThreeIcon,
                fit: BoxFit.cover,
                width: 10.w,
                height: 10.w,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10.w)),
        ],
      ),
    );
  }

  Widget newLayout() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listDataOne.length,
      itemBuilder: (BuildContext context, int index) {
        return listitemBigBgNew(listDataOne[index], index);
      },
    );
  }
}
