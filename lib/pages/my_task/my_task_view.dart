import 'package:crazyenglish/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/search_bar.dart';
import 'my_task_logic.dart';

class MyTaskPage extends BasePage {
  const MyTaskPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyTaskPageState();
}

class _ToMyTaskPageState extends BasePageState<MyTaskPage> {
  final logic = Get.put(My_taskLogic());
  final state = Get.find<My_taskLogic>().state;
  List listData = [
    {
      "title": "【完形填空】Module 1 Unit3",
      "type": 0,
    },
    {"title": "【单词速记】Module 1 Unit3", "type": 1},
    {"title": "【单词速记】Module 2 Unit3", "type": 2},
    {"title": "【单词速记】Module 3 Unit3", "type": 3},
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;

  // List<Rows> weekPaperList = [];
  final int pageStartIndex = 1;

  @override
  void initState() {
    super.initState();
    //获取我的任务
    logic.addListenerId(GetBuilderIds.getMyTasksDate, () {
      if (state.paperList != null) {
        /*paperList = state.paperList;
        if(mounted && _refreshController!=null){
          if(paperDetail!.data!=null
              && paperDetail!.data!.videoFile!=null
              && paperDetail!.data!.videoFile!.isNotEmpty){
          }
          if(paperDetail!.data!=null
              && paperDetail!.data!.audioFile!=null
              && paperDetail!.data!.audioFile!.isNotEmpty){

          }
          setState(() {
          });
        }*/

      }
    });
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
                childCount: 4,
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
        //todo 需要接入真实的数据
        RouterUtil.toNamed(AppRoutes.WeeklyTestCategory, arguments: 4);
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

  Widget _listOne(value) => Container(
        padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Padding(padding: EdgeInsets.only(left: 7.w,right: 7.w)),
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
                      child: Text("7/99",
                          style: TextStyle(
                              color: Color(0xff8b8f9f),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(width: 10.w),
                    Text(value['title'],
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
                      Text("剩余时间：7小时29分钟",
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
