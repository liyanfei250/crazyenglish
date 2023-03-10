import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../../../widgets/search_bar.dart';
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
                    bottom: 5.w, top: 12.w, left: 33.w, right: 33.w),
                child: SearchBar(
                  width: double.infinity,
                  height: 28.w,
                ),
              ),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text(
                  '01.情景反应',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
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
                  color: Color(0xff858aa0),
                  fontWeight: FontWeight.w500),
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
