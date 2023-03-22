import 'package:crazyenglish/base/AppUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../base/widgetPage/base_page_widget.dart';
import '../../../../r.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/search_bar.dart';
import 'collect_practic_logic.dart';

class ErrorColectPrctePage extends BasePage {
  const ErrorColectPrctePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorColectPrctePageState();
}

class _ToErrorColectPrctePageState extends BasePageState<ErrorColectPrctePage> {
  final logic = Get.put(Collect_practicLogic());
  final state = Get.find<Collect_practicLogic>().state;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;
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
  ];

  List searchList = [
    {
      "title": "全部",
      "type": 0,
    },
    {"title": "最近查看", "type": 1},
    {"title": "听力题", "type": 2},
    {"title": "阅读题", "type": 3},
    {"title": "写作题", "type": 4},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                    bottom: 0.w, top: 12.w, left: 33.w, right: 33.w),
                child: Container(
                  width: double.infinity,
                  height: 28.w,
                  margin: EdgeInsets.only(top: 16.w, bottom: 20.w),
                  decoration: BoxDecoration(
                      color: AppColors.c_FFFFFFFF,
                      borderRadius: BorderRadius.all(Radius.circular(14.w))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 7.w)),
                      Image.asset(
                        R.imagesHomeSearch,
                        width: 16.w,
                        height: 16.w,
                      ),
                      Padding(padding: EdgeInsets.only(left: 6.w)),
                      Text(
                        "搜索",
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xffb3b7c0)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(
                      bottom: 0.w, top: 0.w, left: 33.w, right: 33.w),
                  child: Wrap(
                      spacing: 6.0, // 主轴(水平)方向间距
                      runSpacing: 1.0, // 纵轴（垂直）方向间距
                      alignment: WrapAlignment.start,
                      children: searchList.map((e) {
                        return listitem(e);
                      }).toList())),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                buildItem,
                childCount: listDataOne.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget test(value) {
    var newlist = searchList.where((element) => element['type'] > 1);
    return listitem(newlist);
  }

  Widget listitem(value) {
    return ActionChip(
      // padding: EdgeInsets.only(top: 4.w,bottom: 4.w),
      // labelPadding:EdgeInsets.only(top: 0.w,bottom: 0.w) ,
      onPressed: () {
        //Util.toast(value['title']);
        Util.toast(value['type'].toString());
      },
      label: Text(
        value['title'],
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      ),
      backgroundColor: Colors.white,
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
                  '七年级新课程第29期',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text('2023.2.27 16:48',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff656d8f),
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 2.w),
                child: Text(
                  '01.情景反应',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w400),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 2.w),
              child: Image.asset(
                R.imagesCollecPracIcon,
                width: 46.w,
                height: 13.w,
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
            child: Text(
              'As winter approaches, warm-blooded animals have two ways to cope with the cold. The first is , building a layer of fat under the skin and shedding their svelte As winter approaches, warm-blooded animals...',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff353e4d),
                  height: 1.5,
                  fontWeight: FontWeight.w400),
            )),
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        //RouterUtil.toNamed(AppRoutes.WeeklyTestCategory);
      },
      child: listitemBigBg(),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {
    Get.delete<Collect_practicLogic>();
    _refreshController.dispose();
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    // logic.getList("2022-12-22",pageStartIndex,pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getList("2022-12-22",currentPageNo,pageSize);
  }
}