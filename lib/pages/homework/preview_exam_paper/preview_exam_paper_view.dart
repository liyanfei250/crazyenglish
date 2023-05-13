import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/homework/preview_exam_paper/exam_question/exam_question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'preview_exam_paper_logic.dart';

/**
 * 试卷预览
 */
class PreviewExamPaperPage extends BasePage {
  const PreviewExamPaperPage({Key? key}) : super(key: key);

  @override
  BasePageState<PreviewExamPaperPage> getState() => _PreviewExamPaperPageState();
}

class _PreviewExamPaperPageState extends BasePageState<PreviewExamPaperPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(PreviewExamPaperLogic());
  final state = Get.find<PreviewExamPaperLogic>().state;

  late TabController _tabController;

  final List<String> tabs = const[
    "听力",
    "阅读",
    "写作",
    "语法",
    "词汇",
  ];

  var isChooseName = "".obs;

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(() {
      isChooseName.value = tabs[_tabController!.index];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.c_FFFFFFFF,
            centerTitle: true,
            title: Text("试卷预览",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
            leading: Util.buildBackWidget(context),
            // bottom: ,
            elevation: 0,
            actions: [
              Container(
                height: 22.w,
                margin: EdgeInsets.only(left:17.w,right: 22.w),
                child: InkWell(
                  onTap: (){
                    RouterUtil.toNamed(AppRoutes.AssignHomeworkPage);
                  },
                  child: Text("布置作业",style: TextStyle(fontSize: 14.sp,color: AppColors.c_FFED702D),),
                ),
              ),
            ],
          ),
          Container(
            color: AppColors.c_FFFFFFFF,
            child: _buildTabBar(),
          ),
          Expanded(child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(
                        color: Color(0xffee754f),		// 阴影的颜色
                        offset: Offset(0.w, 0.w),						// 阴影与容器的距离
                        blurRadius: 9.w,							// 高斯的标准偏差与盒子的形状卷积。
                        spreadRadius: 0.w,
                      ),
                    ],
                  ),
                ),
              )];
            },
            body: _buildTableBarView(),
          ),),
        ],
      ),
    );
  }


  Widget _buildTabBar() => TabBar(
    onTap: (tab)=> print(tab),
    controller: _tabController,
    indicatorColor: AppColors.c_FFFFFFFF,
    indicatorSize: TabBarIndicatorSize.tab,
    isScrollable: true,
    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    indicatorWeight: 3,
    labelColor: AppColors.TEXT_COLOR,
    tabs: tabs.map((e) => Tab(child: Obx(()=>Container(
      height: 26.w,
      padding: EdgeInsets.only(left:18.w,right: 18.w),
      decoration: isChooseName.value == e ? BoxDecoration(
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
      ):BoxDecoration(color: AppColors.c_FFFFFFFF),
      child: Text(e,style: TextStyle(fontSize: 14.sp,color: isChooseName.value == e ? AppColors.c_FFFFFFFF:AppColors.c_FF898A93,fontWeight: FontWeight.w500),),
    )),)).toList(),
  );


  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return ExamQuestionPage(tagId: e);
      }).toList());

  @override
  void dispose() {
    Get.delete<PreviewExamPaperLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
  }

  @override
  bool get wantKeepAlive => true;
}