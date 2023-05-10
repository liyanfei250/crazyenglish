import 'package:crazyenglish/entity/class_bottom_info.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/search_bar.dart';
import 'student_list_logic.dart';

class StudentListPage extends BasePage {
  String? classId;

  StudentListPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      classId = Get.arguments['classId'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToStudentListPageState();
}

class _ToStudentListPageState extends BasePageState<StudentListPage> {
  final logic = Get.put(Student_listLogic());
  final state = Get.find<Student_listLogic>().state;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;

  List<Records> paperList = [];
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
        child: paperList.length > 0
            ? CustomScrollView(
                slivers: [
                  /*SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 5.w, top: 12.w, left: 33.w, right: 33.w),
                      child: SearchBar(
                        width: double.infinity,
                        height: 28.w,
                      ),
                    ),
                  ),*/
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      buildItem,
                      childCount: paperList.length,
                    ),
                  ),
                ],
              )
            : PlaceholderPage(
                imageAsset: R.imagesCommenNoDate,
                title: '暂无数据',
                topMargin: 0,
                subtitle: '快去邀请学生加入吧'),
      ),
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getMyClassBottom(widget.classId.toString(), pageSize, pageStartIndex);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getMyClassBottom(
        widget.classId.toString(), pageSize, currentPageNo + 1);
  }

  @override
  void dispose() {
    Get.delete<Student_listLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onCreate() {
    logic.addListenerId(
        GetBuilderIds.getMyClassHomeBottom + widget.classId.toString(), () {
      hideLoading();
      if (state.list != null) {
        if (state.pageNo == currentPageNo + 1) {
          currentPageNo++;
          paperList.addAll(state!.list!);
          if (mounted && _refreshController != null) {
            _refreshController.loadComplete();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        } else if (state.pageNo == pageStartIndex) {
          currentPageNo = pageStartIndex;
          paperList.clear();
          paperList.addAll(state.list!);
          if (mounted && _refreshController != null) {
            _refreshController.refreshCompleted();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        }
      }
    });

    _onRefresh();
    showLoading('');
  }

  @override
  void onDestroy() {}

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
        margin: EdgeInsets.only(top: 10.w, left: 22.w, right: 22.w),
        padding: EdgeInsets.only(left: 16.w, top: 17.w, bottom: 17.w),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(1.0),
              child: Image.network(
                paperList[index]!.avatar ??
                    "https://pics0.baidu.com/feed/0b55b319ebc4b74531587bda64b9f91c888215fb.jpeg@f_auto?token=c5e40b1e9aa7359c642904f84b564921",
                width: 88.w,
                height: 88.w,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(1.0),
                      child: Image(
                        image: AssetImage(R.imagesStudentHead),
                        width: 88.w,
                        height: 88.w,
                        fit: BoxFit.cover,
                      ));
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15.w)),
            Container(
              height: 88.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItemClassStudent(
                      '姓名：', paperList![index]!.actualname ?? ''),
                  buildItemClassStudent(
                      '努力值：', paperList![index]!.effort.toString() + '分'),
                  buildItemClassStudent(
                      '学习时长：', paperList[index]!.studyTime.toString() + '小时'),
                  buildItemClassStudent(
                      '答题总数：', paperList[index]!.totalSize.toString() + '道'),
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
