import 'package:crazyenglish/pages/error/error_note_child/TabBarPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../r.dart';
import '../../../utils/colors.dart';
import 'error_note_child_logic.dart';

class ErrorNoteChildPage extends StatefulWidget {
  static int WAIT_CORRECT = 0;
  static int HAS_CORRECTED = 1;

  int type;

  ErrorNoteChildPage(this.type, {Key? key}) : super(key: key);

  @override
  _ErrorNoteChildPageState createState() => _ErrorNoteChildPageState();
}

class _ErrorNoteChildPageState extends State<ErrorNoteChildPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ErrorNoteChildLogic());
  final state = Get.find<ErrorNoteChildLogic>().state;
  late TabController _tabController;

  final List<String> tabs = const [
    "听力",
    "阅读",
    "写作",
    "语法",
  ];

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [/*TabBarPage(_tabController, tabs)*/buildBg(), Expanded(child: _buildTableBarView())],
    );
  }

  @override
  void dispose() {
    Get.delete<ErrorNoteChildLogic>();
    super.dispose();
  }

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return Container(
          alignment: Alignment.center,
          child: ListView(
            children: listDataOne.map((value) {
              return listitemBigBg();
            }).toList(),
          ),
        );
      }).toList());

  Widget buildBg() => Container(
        margin:
            EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
        width: double.infinity,
        height: 38.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            /*boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(2, 4), // 阴影与容器的距离
              )
            ],*/
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
            color: Color(0xfff2f5fc)),
        child: TabBar(
          onTap: (tab) => print(tab),
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          isScrollable: false,
          controller: _tabController,
          labelColor: Color(0xffffbc00),
          indicatorWeight: 2,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 28),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffffbc00),
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      );

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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
