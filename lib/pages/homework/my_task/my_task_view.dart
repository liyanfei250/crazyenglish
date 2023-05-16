import 'package:crazyenglish/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/common.dart' as common;
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../widgets/search_bar.dart';
import '../preview_exam_paper/preview_exam_paper_view.dart';
import 'my_task_logic.dart';
import 'package:crazyenglish/entity/home/HomeMyTasksDate.dart' as homemytask;

class MyTaskPage extends BasePage {
  const MyTaskPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyTaskPageState();
}

class _ToMyTaskPageState extends BasePageState<MyTaskPage> {
  final logic = Get.put(My_taskLogic());
  final state = Get.find<My_taskLogic>().state;
  List<homemytask.Obj> listData = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;

  final int pageStartIndex = 1;

  @override
  void initState() {
    super.initState();
    //获取我的任务
    logic.addListenerId(GetBuilderIds.getMyTasksDate, () {
      if (state.paperList != null) {
        listData = state.paperList;
        if(mounted && _refreshController!=null){
          setState(() {
          });
        }
      }
    });
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("我的任务"),
      backgroundColor: AppColors.theme_bg,
      body: SmartRefresher(
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
                childCount: listData!=null? listData.length:0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getMyTasks("2022-12-22",pageStartIndex,pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getMyTasks("2022-12-22",currentPageNo,pageSize);
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        RouterUtil.toNamed(AppRoutes.PreviewExamPaperPage, arguments: {
          PreviewExamPaperPage.PaperType:common.PaperType.HistoryHomework,
          PreviewExamPaperPage.StudentOperationId:listData[index].id,
          PreviewExamPaperPage.StudentOperationId:listData[index].id,
          PreviewExamPaperPage.PaperId:listData[index].operationId});
      },
      child: Container(
          margin:
              EdgeInsets.only(top: 14.w, left: 14.w, right: 14.w, bottom: 2.w),
          padding:
              EdgeInsets.only(left: 14.w, right: 14.w, top: 2.w, bottom: 2.w),
          width: double.infinity,
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
          child: _listOne(listData[index])),
    );
  }

  Widget _listOne(homemytask.Obj value) => Container(
        padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Container(
                      width: 27.w,
                      height: 14.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: yellowGreen(),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.w),
                              topRight: Radius.circular(7.w),
                              bottomRight: Radius.circular(7.w),
                              bottomLeft: Radius.circular(0.w)),
                          color: Color(0xfff0e9ff)),
                      child: Text("${value.completeSize}/${value.totalSize}",
                          style: TextStyle(
                              color: Color(0xff8b8f9f),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(width: 10.w),
                    Text("${value.name}",
                        style: TextStyle(
                            color: Color(0xff353e4d),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                  ]),
                  SizedBox(
                    height: 5.w,
                  ),
                  Row(
                    children: [
                      Text("剩余时间：${value.timeRemaining}",
                          style: TextStyle(
                              color: Color(0xff8b8f9f),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700)),
                      SizedBox(width: 30.w),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  LinearGradient yellowGreen(
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      _getLinearGradient(Color(0xfffaeed7), Color(0xffe5d2ac),
          begin: begin, end: end, opacity: opacity);

  LinearGradient _getLinearGradient(Color left, Color right,
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      LinearGradient(
        colors: [
          left.withOpacity(opacity),
          right.withOpacity(opacity),
        ],
        begin: begin,
        end: end,
      );

  @override
  void dispose() {
    Get.delete<My_taskLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
