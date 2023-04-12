import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import 'MenuWidget.dart';
import 'listening_practice_logic.dart';

class ListeningPracticePage extends BasePage {
  var type;

  ListeningPracticePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      type = Get.arguments["type"];
    }
  }

  @override
  BasePageState<BasePage> getState() => ToListeningPracticePageState();
}

class ToListeningPracticePageState
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

  late var textTitle ;

  @override
  Widget build(BuildContext context) {

    if(widget.type ==1){
      textTitle = "听力·按顺序练习";
    }
    if(widget.type ==2){
      textTitle = "阅读·按顺序练习";
    }
    if(widget.type ==3){
      textTitle = "写作·按顺序练习";
    }
    if(widget.type ==4){
      textTitle = "词语运用·按顺序练习";
    }
    return Scaffold(
      appBar: buildNormalAppBar(textTitle),
      backgroundColor: AppColors.theme_bg,
      body: Container(
        child: Column(
          children: [
            MenuWidget(
              title: '全部分类',
              items: ['选项1', '选项2', '选项3', '高中十一年级', '选项5', '选项6'],
              onSelected: (index) {
                print('选中了第${index + 1}项');
              },
            ),
            Expanded(
                child: ListView(
              children: listDataOne.map((value) {
                return listitemBigBg();
              }).toList(),
            ))
          ],
        ),
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
                  '七年级 新课程 第29期｜共4篇',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            InkWell(
              onTap: (){
                RouterUtil.toNamed(AppRoutes.ResultOverviewPage);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text('期刊成绩',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff353e4d),
                        fontWeight: FontWeight.w600)),
              ),
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
}