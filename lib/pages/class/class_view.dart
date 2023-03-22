import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../class_home/class_home_view.dart';
import 'class_logic.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  final logic = Get.put(ClassLogic());
  final state = Get.find<ClassLogic>().state;
  late TabController _tabController;

  final List<String> tabs = const[
    "初一1班",
    "初一2班",
    "初一3班",
    "初一4班",
    "初一5班",
    "初一6班",
  ];

  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this,length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFCF5E6),Color(0xFFF6F8FC)]
            )
        ),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: _buildTabBar(),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            Expanded(child: _buildTableBarView())
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
    onTap: (tab)=> print(tab),
    controller: _tabController,
    indicatorColor: AppColors.TAB_COLOR2,
    indicatorSize: TabBarIndicatorSize.label,
    isScrollable: true,
    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    indicatorWeight: 3,
    labelStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 14.sp,color: AppColors.TEXT_BLACK_COLOR),
    labelColor: AppColors.TEXT_COLOR,
    tabs: tabs.map((e) => Tab(text:e)).toList(),
  );


  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return ClassHomePage();
      }).toList()
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<ClassLogic>();
    super.dispose();
  }
}