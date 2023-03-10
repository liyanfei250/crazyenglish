import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import 'listening_practice_logic.dart';

class ListeningPracticePage extends BasePage {
  const ListeningPracticePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToListeningPracticePageState();
}

class _ToListeningPracticePageState
    extends BasePageState<ListeningPracticePage> {
  final logic = Get.put(Listening_practiceLogic());
  final state = Get.find<Listening_practiceLogic>().state;
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
    {"title": "03.语篇理解", "type": 2},
    {"title": "04.听力填空", "type": 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("听力·按顺序练习"),
      backgroundColor: AppColors.theme_bg,
      body: ListView(
        children: listDataOne.map((value) {
          return listitemBigBg();
        }).toList(),
      ),
    );
  }

  @override
  void onCreate() {
    // logic.getPracCords(1, 10);

    // logic.addListenerId(key, () { })
  }

  @override
  void onDestroy() {}

  Widget listitemBigBg() {
    return Container(
      margin: EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w,bottom: 10.w),
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
                  '七年级 新课程 第29期｜共4篇',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text('期刊成绩',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, top: 9.w, bottom: 17.w),
              child: Image.asset(
                R.imagesIconToNext,
                color: Color(0xff353e4d),
                fit: BoxFit.cover,
                width: 7.w,
                height: 11.w,
              ),
            ),
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
          Divider(
            color: Colors.grey,
            height: 1.w,
          ),
          Padding(padding: EdgeInsets.only(top: 20.w)),
          Row(
            children: [
              Text(value['title'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff353e4d)),),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Image.asset(
                R.imagesListenigLastIcon,
                fit: BoxFit.cover,
                width: 26.w,
                height: 18.w,
              ),
              Expanded(child: Text('')),
              Text('正确率 9/15',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff858aa0)),)
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.w)),
        ],
      ),
    );
  }
}
