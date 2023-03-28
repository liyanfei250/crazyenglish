import 'package:crazyenglish/base/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../utils/colors.dart';
import '../class_home/class_home_view.dart';
import 'class_logic.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ClassLogic());
  final state = Get.find<ClassLogic>().state;
  late TabController _tabController;
  Offset _offset = Offset(310.w, 70.w);
  bool _showAddClass = false;
  var extend = false;
  final List<String> tabs = const [
    "初一1班",
    "初一2班",
    "初一3班",
    "初一4班",
    "初一5班",
    "初一6班",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: Stack(
        children: [
          Image.asset(R.imagesTeacherClassTop, width: double.infinity),
          Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: _buildTabBar(),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              Expanded(child: _buildTableBarView()),
            ],
          ),
          Positioned(
            left: _offset.dx,
            top: _offset.dy,
            child: Draggable(
              child: buildContainer(),
              feedback: buildContainer(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() {
                  _offset = offset;
                });
              },
              childWhenDragging: Container(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      height: 38.w,
      padding: EdgeInsets.only(left: 4.w, right: extend ? 12.w : 6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Color(0xfff3b144),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Util.toast('message');
          setState(() {
            extend = !extend;
          });
        },
        child: Row(
          children: [
            Image.asset(
              R.imagesTeachClassAdd,
              width: 28.w,
              height: 28.w,
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              vsync: this,
              child: Container(
                width: extend ? 44.w : 0.w,
                child: Center(
                  child: Text(
                    '新建班级',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xffed702d),
                        fontSize: 10.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
        onTap: (tab) => print(tab),
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 14),
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        indicatorWeight: 3,
        labelStyle: TextStyle(
            fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
        labelColor: Colors.white,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return ClassHomePage();
      }).toList());

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<ClassLogic>();
    super.dispose();
  }
}
