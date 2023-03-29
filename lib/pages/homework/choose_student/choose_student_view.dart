import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkStudentResponse.dart';
import 'package:crazyenglish/pages/homework/choose_student/student_list/student_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../base_choose_page_state.dart';
import 'choose_student_logic.dart';

class ChooseStudentPage extends BasePage {
  const ChooseStudentPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ChooseStudentPageState();
}

class _ChooseStudentPageState extends BaseChoosePageState<ChooseStudentPage,Students> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ChooseStudentLogic());
  final state = Get.find<ChooseStudentLogic>().state;
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
  String getDataId(String key,Students n) {
    assert(n.id !=null);
    return n.id!.toString();
  }

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: tabs.length);
    currentKey.value = tabs[0];
    _tabController.addListener(() {
      currentKey.value = tabs[_tabController!.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: [
          Image.asset(R.imagesTeacherClassTop,width: double.infinity),
          Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Util.buildWhiteWidget(context),
                    Text("学生选择"),
                  ],
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              Expanded(child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 19.w,bottom:19.w,top:35.w,right: 19.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                ),
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [SliverToBoxAdapter(
                      child: _buildTabBar(),
                    )];
                  },
                  body: _buildTableBarView(),
                ),
              ),),
              buildBottomWidget()
            ],
          )
        ],
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
        return StudentListPage(chooseLogic: this,classId: e);
      }).toList());

  @override
  void dispose() {
    Get.delete<ChooseStudentLogic>();
    super.dispose();
  }



  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}