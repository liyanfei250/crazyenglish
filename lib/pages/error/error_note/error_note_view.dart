import 'package:crazyenglish/pages/error/error_note/ToolMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import 'error_note_logic.dart';

class ErrorNotePage extends BasePage {
  const ErrorNotePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorNotePageState();
}

class _ToErrorNotePageState extends BasePageState<ErrorNotePage>
    with SingleTickerProviderStateMixin {
  final RestorableInt _selectedIndex = RestorableInt(0);
  final logic = Get.put(Error_noteLogic());
  final state = Get.find<Error_noteLogic>().state;
  List listDataOne = [
    {"title": "01.情景反应", "type": 0},
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
  late TabController _tabController;
  final List<String> tabs = const [
    '待订正',
    '已订正',
  ];
  final List<String> tabsTwo = const [
    '听力',
    '阅读',
    '写作',
    '语法',
  ];

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

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
    return Scaffold(
      appBar: buildBottomAppBar("错题本"),
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
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        isScrollable: true,
        controller: _tabController,
        labelColor: Color(0xffeb5447),
        indicatorWeight: 3,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 28),
        unselectedLabelColor: Colors.grey,
        indicatorColor: Color(0xffeb5447),
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  Widget listitemBigBg() {
    return Container(
      margin: EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
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
              child: Text('2023.2.27 16:48',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
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

  Widget listitem(value) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: Colors.grey,
            height: 1.w,
          ),
          Padding(padding: EdgeInsets.only(top: 10.w)),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.w),
                    child: Text(
                      '正确率 9/15',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff858aa0)),
                    ),
                  ),
                ],
              ),
              Expanded(child: Text('')),
              Image.asset(
                R.imagesErrorToCorrect,
                fit: BoxFit.cover,
                width: 41.w,
                height: 15.w,
              ),
              Image.asset(
                R.imagesErrorToCorrectOver,
                fit: BoxFit.cover,
                width: 56.w,
                height: 56.w,
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10.w)),
        ],
      ),
    );
  }
}
