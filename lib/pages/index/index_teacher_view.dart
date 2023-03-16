import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/teacher_index/teacher_index_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../utils/colors.dart';
import 'index_logic.dart';

class IndexTeacherPage extends BasePage {
  const IndexTeacherPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _IndexTeacherPageState();
}

class _IndexTeacherPageState extends BasePageState<IndexTeacherPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  final logic = Get.put(IndexLogic());
  final state = Get.find<IndexLogic>().state;
  late TabController _tabController;

  final List<String> tabs = const[
    "精选",
    "错题本",
    "精品试卷",
    "音标练习",
    "听写单词",
    "朗读",
  ];


  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this,length: tabs.length);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        _buildTabBar(),
        Expanded(child: _buildTableBarView())
      ],
    );
  }


  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        switch(e){
          case "精选":
            return TeacherIndexPage();
        }
        return Container();
      }).toList()
  );

  Widget _buildTabBar() => TabBar(
    onTap: (tab)=> print(tab),
    controller: _tabController,
    indicatorColor: AppColors.TAB_COLOR,
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

  Widget _buildSearchBar() => Container(
    margin: EdgeInsets.only(left: 14.w,right: 14.w,top: 7.w),
    height: 28.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 294.w,
          height: 28.w,
          padding: EdgeInsets.only(left: 11.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
              color: AppColors.c_FFF0F0F0
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(R.imagesIndexSearch,fit:BoxFit.cover,width: 22.w,height: 22.w,),
              Padding(padding: EdgeInsets.only(left: 9.w)),
              Text("搜索/翻译",style: TextStyle(fontSize:16.sp,color: AppColors.TEXT_GRAY_COLOR),)
            ],
          ),
        ),
        Image.asset(R.imagesTeacherScan,width: 22.w,height: 22.w,)
      ],
    ),
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<IndexLogic>();
    super.dispose();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}