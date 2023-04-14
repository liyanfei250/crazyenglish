import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/AppUtil.dart';
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

class ToListeningPracticePageState extends BasePageState<ListeningPracticePage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(Listening_practiceLogic());
  final state = Get.find<Listening_practiceLogic>().state;
  late AnimationController _controller;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;

  // List<Rows> weekPaperList = [];
  final int pageStartIndex = 1;
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

  late var textTitle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 1) {
      textTitle = "听力·按顺序练习";
    }
    if (widget.type == 2) {
      textTitle = "阅读·按顺序练习";
    }
    if (widget.type == 3) {
      textTitle = "写作·按顺序练习";
    }
    if (widget.type == 4) {
      textTitle = "词语运用·按顺序练习";
    }
    return Scaffold(
      appBar: buildNormalAppBar(textTitle),
      backgroundColor: AppColors.theme_bg,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70.w),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      buildItemTop,
                      childCount: listDataOne.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          MenuWidget(
            title: '全部分类',
            items: ['选项1', '选项2', '选项3', '高中十一年级', '选项5', '选项6'],
            onSelected: (index) {
              print('选中了第${index + 1}项');
            },
          ),
        ],
      ),
    );
  }

  Widget buildItemTop(BuildContext context, int index) {
    return InkWell(
      onTap: () {},
      child: listitemBigBg(),
    );
  }

  AppBar buildNormalAppBar(String text) {
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
      // bottom: ,
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  @override
  void onCreate() {
    // logic.getPracCords(1, 10);

    // logic.addListenerId(key, () { })
  }

  @override
  void onDestroy() {
    _controller.dispose();
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    // logic.getList("2022-12-22",pageStartIndex,pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getList("2022-12-22",currentPageNo,pageSize);
  }

  @override
  void dispose() {
    Get.delete<Listening_practiceLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  Widget listitemBigBg() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: 18.w, right: 18.w, top: 8.w, bottom: 11.w),
                child: Text(
                  '七年级 新课程 第29期｜共4篇',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            InkWell(
              onTap: () {
                RouterUtil.toNamed(AppRoutes.ResultOverviewPage);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 11.w, right: 2.w),
                child: Text('期刊成绩',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff353e4d),
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 2.w,
                top: 9.w,
                bottom: 11.w,
                right: 18.w,
              ),
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
        Container(
          margin:
              EdgeInsets.only(top: 11.w, left: 18.w, right: 18.w, bottom: 10.w),
          // padding:
          //     EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 10.w),
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
          child: ListView.builder(
            itemBuilder: itemBuilder,
            itemCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return listitemBig(index);
  }

  Widget listitemBig(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: index == 0
                ? BorderRadius.only(topLeft: Radius.circular(7.w))
                : BorderRadius.only(topLeft: Radius.circular(0.w)),
            gradient: LinearGradient(
              colors: [Color(0xfffcefd8), Color(0x0fcefd8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w, left: 17.w),
                  child: Text(
                    'Module 1',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xffed702d),
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                  child: Text(
                    ' > ',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff858aa0),
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                  child: Text(
                    'Unit 3',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xffed702d),
                        fontWeight: FontWeight.w500),
                  )),
              Expanded(child: Text('')),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 17.w, right: 17.w),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return listitem(listData[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1, color: Color(0xffd2d5dc));
            },
            itemCount: listData.length,
          ),
        ),
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
}
