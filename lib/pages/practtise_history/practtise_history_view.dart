import 'dart:async';
import 'dart:ui' as ui;
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
              child:
                  newLayout() /*ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return listitemBigBg();
              },
            ),*/
              )
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
              Text(
                value['title'],
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff353e4d)),
              ),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Image.asset(
                R.imagesListenigLastIcon,
                fit: BoxFit.cover,
                width: 26.w,
                height: 18.w,
              ),
              Expanded(child: Text('')),
              Text(
                '正确率 9/15',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff858aa0)),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.w)),
        ],
      ),
    );
  }

  Widget newLayout() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // 圆和线
                  height: 32,
                  child: LeftLineWidget(
                      showTop: false, showBottom: true, isLight: false),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '天天乐超市（限时降价）已取货',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
              ],
            ),
            //这里需要自定义虚线BoxDecoration
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(left: BorderSide(width: 2, color: Colors.grey))),
              margin: EdgeInsets.only(left: 23),
              padding: EdgeInsets.fromLTRB(22, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listData.map((value) {
                  return listitem(value);
                }).toList(),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // 圆和线
                  height: 32,
                  child: LeftLineWidget(
                      showTop: true, showBottom: true, isLight: false),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '天天乐超市（限时降价）已取货',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // 圆和线
                  height: 100.w,
                  child: LeftLineWidget(
                      showTop: true, showBottom: true, isLight: true),
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('配送员：吴立亮 18888888888'),
                      Text('时间：2018-12-17 09:55:22'),
                      Text('配送员：吴立亮 18888888888'),
                      Text('时间：2018-12-17 09:55:22'),
                    ],
                  ),
                ))
              ],
            ),
            Divider(
              color: Colors.grey,
              height: 1,
              indent: 40.w,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // 圆和线
                  height: 32,
                  child: LeftLineWidget(
                      showTop: true, showBottom: false, isLight: false),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '天天乐超市（限时降价）已取货',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 2, color: Colors.transparent))),
              margin: EdgeInsets.only(left: 23),
              padding: EdgeInsets.fromLTRB(22, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('配送员：吴立亮 18888888888'),
                  Text('时间：2018-12-17 09:55:22')
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
