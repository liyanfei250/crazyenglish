import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkQuestionResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/QuestionListResponse.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../base_choose_page_state.dart';
import 'choose_question_logic.dart';
import 'question_list/question_list_view.dart';

class ChooseQuestionPage extends BasePage {
  const ChooseQuestionPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ChooseQuestionPageState();
}

class _ChooseQuestionPageState extends BaseChoosePageState<ChooseQuestionPage,Questions> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ChooseQuestionLogic());
  final state = Get.find<ChooseQuestionLogic>().state;

  late TabController _tabController;

  final List<String> tabs = const[
    "听力",
    "阅读",
    "写作",
    "语法",
    "词汇",
  ];

  @override
  String getDataId(String key,Questions n) {
    assert(n.id !=null);
    return n.id!.toString();
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Util.buildWhiteWidget(context),
                        Text("习题选择"),
                      ],
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 27.w,
                        width: 27.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xfff19e59),
                                Color(0xffec5f2a),
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(16.5.w)),
                          boxShadow:[
                            BoxShadow(
                              color: Color(0xffee754f).withOpacity(0.25),		// 阴影的颜色
                              offset: Offset(0.w, 4.w),						// 阴影与容器的距离
                              blurRadius: 8.w,							// 高斯的标准偏差与盒子的形状卷积。
                              spreadRadius: 0.w,
                            ),
                          ],
                        ),
                        child: Image.asset(R.imagesHomeWorkQuestionFilter,width: 14.w,height: 14.w,),
                      ),
                    )
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
          ),
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
        return QuestionListPage(chooseLogic: this,tagId: e);
      }).toList());


  @override
  void dispose() {
    Get.delete<ChooseQuestionLogic>();
    super.dispose();
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
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}