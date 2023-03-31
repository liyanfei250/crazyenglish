import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/watting_push/watting_push_view.dart';
import 'package:crazyenglish/widgets/DashedLine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import 'student_logic.dart';

class StudentPage extends BasePage {
  const StudentPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() {
    return _StudentPageState();
  }
}

class _StudentPageState extends BasePageState<StudentPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(StudentLogic());
  final state = Get.find<StudentLogic>().state;
  late TabController _tabController;
  String stateText = '';
  var selectData = {
    DateMode.YMDHMS: '',
    DateMode.YMDHM: '',
    DateMode.YMDH: '',
    DateMode.YMD: '',
    DateMode.YM: '',
    DateMode.Y: '',
    DateMode.MDHMS: '',
    DateMode.HMS: '',
    DateMode.MD: '',
    DateMode.S: '',
  };
  List tabs = [
    {"title": "待提交", "type": 1},
    {"title": "已完成", "type": 2},
    {"title": "待批改", "type": 3},
    {"title": "无数据", "type": 0},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(
          '学生详情',
          style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Util.buildBackWidget(context),
        elevation: 10.w,
        shadowColor: const Color(0x1F000000),
        actions: [
          InkWell(
            onTap: () {
              // 点击事件处理逻辑
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              child: Text(
                '练习记录',
                style: TextStyle(
                  color: Color(0xffed702d),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: buildContainerTop(),
            ),
            SliverToBoxAdapter(
              child: buildContainerTitle(),
            ),
            SliverPersistentHeader(
              // 可以吸顶的TabBar
              pinned: true,
              delegate: CustomStickyTabBarDelegate(tabBar: buildTabBar()),
            ),
          ];
        },
        body: Container(
          // padding:
          // EdgeInsets.only(left: 2.w, right: 2.w),
          margin:
              EdgeInsets.only(top: 0.w, left: 18.w, right: 18.w, bottom: 10.w),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 3),
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
              ],
              color: Colors.white),
          child: TabBarView(
            controller: this._tabController,
            children: <Widget>[
              Watting_pushPage(1, 1),
              Watting_pushPage(2, 1),
              Watting_pushPage(3, 1),
              Watting_pushPage(0, 1),
            ],
          ),
        ),
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      onTap: (tab) => print(tab),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      isScrollable: false,
      controller: _tabController,
      labelColor: Color(0xff353e4d),
      indicatorWeight: 2,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 40),
      unselectedLabelColor: Colors.grey,
      indicatorColor: Color(0xffffbc00),
      tabs: tabs.map((e) => Tab(text: e['title'])).toList(),
    );
  }

  Container buildContainerTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 18.w, top: 26.w, left: 18.w, right: 33.w),
      child: Text(
        '作业情况',
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16.sp, color: Colors.black),
      ),
    );
  }

  Container buildContainerTop() {
    return Container(
      padding:
          EdgeInsets.only(top: 19.w, bottom: 20.w, left: 25.w, right: 25.w),
      margin: EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
              offset: Offset(2, 4), // 阴影与容器的距离
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
              child: Image.asset(
            R.imagesShopImageLogoTest,
            width: 80.w,
            height: 80.w,
          )),
          SizedBox(
            height: 16.w,
          ),
          Text('张慧敏',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff353e4d))),
          SizedBox(
            height: 4.w,
          ),
          Text('一班（初一）',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff898a93))),
          SizedBox(
            height: 24.w,
          ),
          Row(
            children: [
              Text('学习总时长',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff353e4d))),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: DashedLine()),
              ),
              Text('343天20小时58分钟',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffed702d))),
            ],
          ),
          SizedBox(
            height: 6.w,
          ),
          Row(
            children: [
              Text('客观题正确率',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff353e4d))),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: DashedLine()),
              ),
              Text('85%',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffed702d))),
            ],
          ),
          SizedBox(
            height: 6.w,
          ),
          Row(
            children: [
              Text('主观题平均分',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff353e4d))),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: DashedLine()),
              ),
              Text('77分',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffed702d))),
            ],
          ),
          SizedBox(
            height: 6.w,
          ),
          Row(
            children: [
              Text('努力值',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff353e4d))),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: DashedLine()),
              ),
              Text('77分',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffed702d))),
            ],
          ),
          SizedBox(
            height: 20.w,
          ),
          buildContainer('学习报告生成')
        ],
      ),
    );
  }

  Widget buildContainer(String first) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20.w),
        gradient: LinearGradient(
          colors: [Color(0xFFF19B57), Color(0xFFEC622D)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding:
              EdgeInsets.only(left: 7.w, right: 7.w, bottom: 5.w, top: 5.w),
          child: Text(
            first,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 12.sp),
          ),
        ),
      ),
    );
  }

  Widget buildBg() => Container(
        margin:
            EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
        width: double.infinity,
        height: 38.w,
        alignment: Alignment.center,
        child: TabBar(
          onTap: (tab) => print(tab),
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          isScrollable: false,
          controller: _tabController,
          labelColor: Color(0xffffbc00),
          indicatorWeight: 2,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 28),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffffbc00),
          tabs: tabs.map((e) => Tab(text: e['title'])).toList(),
        ),
      );

  @override
  void dispose() {
    Get.delete<StudentLogic>();
    super.dispose();
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  @override
  bool get wantKeepAlive => true;
}

class CustomStickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  CustomStickyTabBarDelegate({required this.tabBar});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(left: 2.w, right: 2.w),
      margin: EdgeInsets.only(top: 0.w, left: 18.w, right: 18.w, bottom: 0.w),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.w), topLeft: Radius.circular(20.w)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, -3),
              blurRadius: 3,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(-3, 0),
              blurRadius: 3,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(3, 0),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
          color: Colors.white),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant CustomStickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
