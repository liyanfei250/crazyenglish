import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/search_bar.dart';
import 'student_list_logic.dart';

class StudentListPage extends BasePage {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToStudentListPageState();
}

class _ToStudentListPageState extends BasePageState<StudentListPage> {
  final logic = Get.put(Student_listLogic());
  final state = Get.find<Student_listLogic>().state;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("学生列表"),
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
    // logic.getList("2022-12-22",pageStartIndex,pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getList("2022-12-22",currentPageNo,pageSize);
  }

  @override
  void dispose() {
    Get.delete<Student_listLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onCreate() {

  }

  @override
  void onDestroy() {

  }
  Widget buildContainer(String first) {
    return Container(
      height: 22.w,
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
        onTap: () {
          Util.toast('message');
        },
        child: Row(
          children: [
            Image.asset(
              R.imagesStudentNotifyIc,
              width: 9.w,
              height: 9.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Text(
                first,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 10.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemClass(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
        Expanded(child: Text('')),
        Text(second,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff353e4d))),
      ],
    );
  }
  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        RouterUtil.toNamed(AppRoutes.TEACHER_STUDENT);
      },
      child: Container(
        height: 171.w,
        margin: EdgeInsets.only(top: 10.w, left: 22.w, right: 22.w),
        padding: EdgeInsets.only(left: 16.w),
        width: double.infinity,
        alignment: Alignment.center,
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
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  R.imagesStudentHead,
                  width: 80.w,
                  height: 80.w,
                ),
                Padding(padding: EdgeInsets.only(top: 8.w)),
                buildContainer('提醒学生'),
                Padding(padding: EdgeInsets.only(top: 8.w)),
                buildContainer('提醒家长'),
              ],
            ),
            Padding(padding: EdgeInsets.only(left: 15.w)),
            Container(
              width: 220.w,
              height: 142.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItemClassStudent('姓名：', '张慧敏'),
                  buildItemClassStudent('努力值：', '80分'),
                  buildItemClassStudent('学习时长：', '20小时'),
                  buildItemClassStudent('听力时长：', '100分钟'),
                  buildItemClassStudent('阅读时长：', '10分钟'),
                  buildItemClassStudent('答题总数：', '听(20) 说(12) 读(21)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemClassStudent(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
        Text(
          second,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
      ],
    );
  }
}
