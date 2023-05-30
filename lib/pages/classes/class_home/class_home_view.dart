import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/class_bottom_info.dart' as bottomData;
import '../../../entity/class_top_info.dart' as topData;
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import 'class_home_logic.dart';
import 'package:qr_flutter/qr_flutter.dart';
//内部班级列表
class ClassHomePage extends StatefulWidget {
  var classId = 0;

  ClassHomePage(int id, {Key? key}) : super(key: key) {
    this.classId = id;
  }

  @override
  _ClassHomePageState createState() => _ClassHomePageState();
}

class _ClassHomePageState extends State<ClassHomePage> {
  final logic = Get.put(ClassHomeLogic());
  final state = Get.find<ClassHomeLogic>().state;
  late topData.Obj top = topData.Obj();
  late bottomData.Obj bottom = bottomData.Obj();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    logic.addListenerId(
        GetBuilderIds.getMyClassHomeTop + widget.classId.toString(), () {
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
        if (state.myClassTop != null && state.myClassTop!.obj != null) {
          top = state.myClassTop!.obj!;
          setState(() {});
        }
      }
    });
    logic.addListenerId(
        GetBuilderIds.getMyClassHomeBottom + widget.classId.toString(), () {
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
        if (state.myClassBottom != null && state.myClassBottom!.obj != null) {
          bottom = state.myClassBottom!.obj!;
          setState(() {});
        }
      }
    });

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 337.w,
                  height: 273.w,
                  padding: EdgeInsets.only(
                      right: 32.w, top: 24.w, left: 32.w, bottom: 24.w),
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildItemClass(
                                '班级状态：', top?.status == 1 ? "正常" : ''),
                            buildItemClass(
                                '答题正确率：',
                                top == null
                                    ? "0%"
                                    : top.accuracy.toString() + "%"),
                            buildItemClass(
                                '班级平均分：',
                                top == null
                                    ? "0分"
                                    : top.score.toString() + "分"),
                            buildItemClass(
                                '班级努力值：',
                                top == null
                                    ? "0分"
                                    : top.effort.toString() + "分"),
                            buildItemClass(
                                '班级已做卷子：',
                                top == null
                                    ? "0份"
                                    : top.operationSize.toString() + '份'),
                            buildItemClass(
                                '班级人数：',
                                top == null
                                    ? "0人"
                                    : top.studentSize.toString() + '人'),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          buildContainerQr(R.imagesClassMyClassBefore),
                          SizedBox(
                            height: 15.w,
                          ),
                          Container(
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
                            child: InkWell(
                              onTap: () {
                                RouterUtil.toNamed(
                                    AppRoutes.QRViewPageNextClass,
                                    arguments: {
                                      'isShowAdd': 0,
                                      'classId': top?.id.toString()
                                    });
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    R.imagesClassMyClassBefore,
                                    width: 10.w,
                                    height: 10.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 6.w),
                                    child: Text(
                                      "我的班级",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    RouterUtil.toNamed(AppRoutes.StudentListPage,
                        arguments: {'classId': widget.classId.toString()});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30.w, left: 22.w, right: 22.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          "学生列表",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.TEXT_BLACK_COLOR),
                        )),
                        Image.asset(
                          R.imagesHomeNextIcBlack,
                          width: 9.w,
                          height: 9.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                bottom.records != null && bottom.records!.length > 0
                    ? ListView.builder(
                        itemBuilder: buildItem,
                        itemCount: bottom.records!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                      )
                    : buildContainerNodate()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainerQr(String imageUrl) {
    return Container(
      alignment: Alignment.center,
      width: 99.w,
      height: 114.w,
      decoration: BoxDecoration(
          color: Color(0xfffff7ed),
          borderRadius: BorderRadius.all(Radius.circular(20.w))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QrImage(
            data: top?.id.toString() ?? "",
            version: QrVersions.auto,
            size: 87.w,
          ),
          Text(
            '班级二维码',
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffed702d)),
          ),
        ],
      ),
    );
  }

  Widget buildContainerNodate() {
    return Container(
      padding: EdgeInsets.only(top: 30.w, bottom: 30.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            R.imagesStudentNoDate,
            width: 138.w,
            height: 138.w,
          ),
          SizedBox(
            height: 20.w,
          ),
        ],
      ),
    );
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
          // Util.toast('message');
          // switch (first) {
          //   case '提醒学生':
          //     return _emptyView;
          //     break;
          //   case '提醒家长':
          //     return _emptyView;
          //     break;
          //   default:
          //     return null;
          // }
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
        RouterUtil.toNamed(AppRoutes.TEACHER_STUDENT,
            arguments: {'studentId': bottom?.records![index]!.userId});
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
                bottom?.records![index]!.avatar ??
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
                      '姓名：',
                      bottom == null
                          ? ""
                          : bottom.records![index]!.actualname ?? ''),
                  buildItemClassStudent(
                      '努力值：',
                      bottom == null
                          ? "0分"
                          : bottom.records![index]!.effort.toString() + '分'),
                  buildItemClassStudent(
                      '学习时长：',
                      bottom == null
                          ? "0小时"
                          : bottom.records![index]!.studyTime.toString() +
                              '小时'),
                  buildItemClassStudent(
                      '答题总数：',
                      bottom == null
                          ? "0道"
                          : bottom.records![index]!.totalSize.toString() + '道'),
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

  void _onRefresh() async {
    logic.getMyClassTop(widget.classId.toString());
    logic.getMyClassBottom(widget.classId.toString(), 10, 1);
  }

  void _onLoading() async {}

  @override
  void dispose() {
    Get.delete<ClassHomeLogic>();
    _refreshController.dispose();
    super.dispose();
  }
}
