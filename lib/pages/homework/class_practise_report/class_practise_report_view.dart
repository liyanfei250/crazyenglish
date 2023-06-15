import 'dart:typed_data';

import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkHistoryResponse.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:crazyenglish/entity/report_response.dart' as list;
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/ShareScreen.dart';
import '../../../utils/colors.dart';
import '../../../utils/permissions/permissions_util.dart';
import 'class_practise_report_logic.dart';
import 'dart:ui' as ui;

/**
 * 班级练习报告页面
 */
class ClassPractiseReportPage extends BasePage {
  static const String HistoryItem = "history";
  late History history;

  ClassPractiseReportPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      history = Get.arguments[HistoryItem] ?? false;
    }
  }

  @override
  BasePageState<ClassPractiseReportPage> getState() =>
      _ClassPractiseReportPageState();
}

class _ClassPractiseReportPageState
    extends BasePageState<ClassPractiseReportPage> {
  final logic = Get.put(ClassPractiseReportLogic());
  final state = Get.find<ClassPractiseReportLogic>().state;
  final GlobalKey _globalKey = GlobalKey();
  List<list.TopThree> topList = [];
  List<list.NotSubmit> bottomList = [];

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getTeacherGetRerport, () {
      hideLoading();
      topList.clear();
      topList.addAll(state.listTop!);
      bottomList.clear();
      bottomList.addAll(state.listBottom!);
      if (mounted) {
        setState(() {});
      }
    });
    logic.getReportResponseList(widget.history.id!.toString());
  }

  @override
  void onDestroy() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: buildNormalAppBar("练习报告"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 24.w, left: 18.w, right: 18.w, bottom: 26.w),
              padding: EdgeInsets.only(left: 27.w, right: 27.w, bottom: 19.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(7.w)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffe3edff).withOpacity(0.5), // 阴影的颜色
                    offset: Offset(0.w, 0.w), // 阴影与容器的距离
                    blurRadius: 10.w, // 高斯的标准偏差与盒子的形状卷积。
                    spreadRadius: 0.w,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        R.imagesClassReportGold,
                        width: 54.w,
                        height: 54.w,
                      ),
                      Text(
                        "${widget.history.name}",
                        style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.c_FF353E4D),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.history.studentCompleteSize ?? '0'}",
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: AppColors.c_FF353E4D,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "/${widget.history.studentTotalSize ?? '0'}",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.c_FF353E4D),
                              ),
                            ],
                          ),
                          Text(
                            "完成人数",
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.c_FF898A93),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.history.accuracy ?? '0'}",
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: AppColors.c_FF353E4D,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "%",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.c_FF353E4D),
                              ),
                            ],
                          ),
                          Text(
                            "正确率",
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.c_FF898A93),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 22.w),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "统计时间：${TimeUtil.getFormatTime(widget.history.updateTime ?? "")}",
                      style: TextStyle(
                          fontSize: 10.w, color: AppColors.c_FFB4B9C6),
                    ),
                  ),
                ],
              ),
            ),
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(R.imagesClassReportBg),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(13.w),
                        topLeft: Radius.circular(13.w))),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 14.w,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: 167.w, left: 54.w, right: 54.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.w),
                                topRight: Radius.circular(10.w)),
                            color: Colors.white.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffe3edff).withOpacity(0.5),
                                // 阴影的颜色
                                offset: Offset(0.w, 0.w),
                                // 阴影与容器的距离
                                blurRadius: 10.w,
                                // 高斯的标准偏差与盒子的形状卷积。
                                spreadRadius: 0.w,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 14.w,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 48.w, right: 48.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.w),
                                topRight: Radius.circular(10.w)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffe3edff).withOpacity(0.5),
                                // 阴影的颜色
                                offset: Offset(0.w, 0.w),
                                // 阴影与容器的距离
                                blurRadius: 10.w,
                                // 高斯的标准偏差与盒子的形状卷积。
                                spreadRadius: 0.w,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 352.w,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 40.w, right: 40.w),
                          padding: EdgeInsets.only(top: 72.w),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffe3edff).withOpacity(0.5),
                                // 阴影的颜色
                                offset: Offset(0.w, 0.w),
                                // 阴影与容器的距离
                                blurRadius: 10.w,
                                // 高斯的标准偏差与盒子的形状卷积。
                                spreadRadius: 0.w,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              buildHeadList(),
                              Container(
                                width: double.infinity,
                                height: 0.8.w,
                                margin: EdgeInsets.only(
                                    left: 40.w,
                                    right: 40.w,
                                    top: 30.w,
                                    bottom: 13.w),
                                color: AppColors.c_FFD2D5DC,
                              ),
                              Text(
                                "未提交(${bottomList.length})",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.c_FF353E4D),
                              ),
                              Text(
                                "请家长及时督促，认真对待学习~",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppColors.c_FFB4B9C6),
                              ),
                              Expanded(child: Container(
                                  margin: EdgeInsets.only(top: 17.w,left: 20.w,right: 20.w,bottom: 10.w),
                                  child: GridView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Text(
                                        bottomList[index].studentName ?? '',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.c_FF353E4D,
                                            fontWeight: FontWeight.w500),
                                      );
                                    },
                                    itemCount: bottomList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, //每行显示的元素个数
                                        crossAxisSpacing: 20.0,
                                        mainAxisSpacing: 16.0,
                                        childAspectRatio: 1.0
                                    ),
                                  )
                              ))

                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await PermissionsUtil.checkPermissions(
                                context,
                                "为了正常访问相册，需要您授权以下权限",
                                [RequestPermissionsTag.PHOTOS], () {
                              _saveImage();
                            });
                          },
                          child: Container(
                            height: 39.w,
                            width: double.infinity,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: 48.w,
                                right: 48.w,
                                top: 20.w,
                                bottom: 46.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffe3edff).withOpacity(0.5),
                                  // 阴影的颜色
                                  offset: Offset(0.w, 0.w),
                                  // 阴影与容器的距离
                                  blurRadius: 10.w,
                                  // 高斯的标准偏差与盒子的形状卷积。
                                  spreadRadius: 0.w,
                                ),
                              ],
                            ),
                            child: Text(
                              "分享给家长",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.c_FF353E4D,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                    Image.asset(
                      R.imagesClassReportGoldBg,
                      width: 275.w,
                      height: 251.w,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveImage() async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }

    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    await ImageGallerySaver.saveImage(pngBytes);
    if (byteData != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ShareScreen(
            imageBytes: byteData.buffer.asUint8List(),
          ),
        ),
      );
    }
  }

  Widget buildHeadList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 132.w,
          width: 60.w,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Image.asset(
                    R.imagesClassReportSecondBg,
                    width: 60.w,
                    height: 64.w,
                  ),
                  Container(
                    width: 60.w,
                    height: 64.w,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      R.imagesClassReportSecondUser,
                      width: 52.w,
                      height: 52.w,
                    ),
                  ),
                  Container(
                    width: 60.w,
                    height: 64.w,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      R.imagesClassReportSecond,
                      width: 20.w,
                      height: 51.w,
                    ),
                  )
                ],
              ),
              Text(
                topList.length > 1 ? topList[1].studentName ?? '' : '第二名',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff748ea3)),
              )
            ],
          ),
        ),
        Container(
          height: 132.w,
          width: 74.w,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Image.asset(
                    R.imagesClassReportFirstBg,
                    width: 74.w,
                    height: 79.w,
                  ),
                  Container(
                    width: 74.w,
                    height: 79.w,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      R.imagesClassReportFirstUser,
                      width: 66.w,
                      height: 66.w,
                    ),
                  ),
                  Container(
                    width: 74.w,
                    height: 79.w,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      R.imagesClassReportFirst,
                      width: 17.w,
                      height: 64.w,
                    ),
                  )
                ],
              ),
              Text(
                topList.length > 0 ? topList[0].studentName ?? '' : '第一名',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffff9700)),
              )
            ],
          ),
        ),
        Container(
          height: 132.w,
          width: 60.w,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Image.asset(
                    R.imagesClassReportThirdBg,
                    width: 60.w,
                    height: 64.w,
                  ),
                  Container(
                    width: 60.w,
                    height: 64.w,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      R.imagesClassReportSecondUser,
                      width: 52.w,
                      height: 52.w,
                    ),
                  ),
                  Container(
                    width: 60.w,
                    height: 64.w,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      R.imagesClassReportThird,
                      width: 20.w,
                      height: 51.w,
                    ),
                  )
                ],
              ),
              Text(
                topList.length > 2 ? topList[2].studentName ?? '' : '第三名',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffff5d00)),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<ClassPractiseReportLogic>();
    super.dispose();
  }
}
