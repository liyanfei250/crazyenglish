import 'dart:ui';

import 'package:crazyenglish/entity/student_ranking_response.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/ShareScreen.dart';
import '../../../utils/permissions/permissions_util.dart';
import 'student_ranking_logic.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class Student_rankingPage extends BasePage {
  bool isStudent = false;
  num? classId ;

   Student_rankingPage({Key? key}) : super(key: key){
     if (Get.arguments != null && Get.arguments is Map) {
       isStudent = Get.arguments['isStudent'];
       classId = Get.arguments['classId'];
     }
  }

  @override
  BasePageState<BasePage> getState() => _ToStudentRankingPageState();
}

class _ToStudentRankingPageState extends BasePageState<Student_rankingPage> {
  final logic = Get.put(Student_rankingLogic());
  final state = Get.find<Student_rankingLogic>().state;
  final GlobalKey _globalKey = GlobalKey();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;
  late List<Obj> dataList = [];
  List<String> weekPaperList = [];
  final int pageStartIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RepaintBoundary(
      key: _globalKey,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.imagesRankingOne), fit: BoxFit.cover),
              )),
          Positioned(
              top: 20.w,
              width: 360.w,
              height: 221.w,
              child: Image.asset(R.imagesRankingTwo)),
          Positioned(
              right: 4.w,
              width: 218.w,
              height: 174.w,
              top: 70.w,
              child: Image.asset(R.imagesRankingThree)),
          Positioned(
              left: 16.w,
              width: 163.w,
              height: 37.w,
              top: 98.w,
              child: Image.asset(R.imagesRankingFour)),
          Positioned(
              child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.back();
              },
              child: Center(
                child: Container(
                  width: Util.setWidth(20) as double?,
                  height: Util.setWidth(20) as double?,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: Util.setWidth(13) as double),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white, // 这里修改成你想要的颜色
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      R.imagesIconBackBlack,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            centerTitle: true,
          )),
          Positioned(
              top: 50.w,
              right: 18.w,
              child: GestureDetector(
                onTap: () async {
                  await PermissionsUtil.checkPermissions(context,
                      "为了正常访问相册，需要您授权以下权限", [RequestPermissionsTag.PHOTOS], () {
                    _saveImage();
                  });
                },
                child: Container(
                  width: 48.w,
                  height: 22.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '分享',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffed702d)),
                  ),
                ),
              )),
          Positioned(
              top: 244.w,
              bottom: 86.w,
              left: 18.w,
              right: 18.w,
              child: Container(
                margin: EdgeInsets.only(left: 4.w, right: 4.w),
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SmartRefresher(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '学生信息',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff898a93)),
                              ),
                              Text(
                                '努力值',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff898a93)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 0.5.w,
                          color: Color(0xffd2d5dc),
                          margin: EdgeInsets.only(top: 4.w,bottom: 12.w),
                        ),
                      ),
                      dataList.isEmpty
                          ? SliverToBoxAdapter(
                        child: PlaceholderPage(
                            imageAsset: R.imagesCommenNoDate,
                            title: '暂无数据',
                            topMargin: 50.w,
                            subtitle: ''),
                      )
                          : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          buildItem,
                          childCount: dataList.length,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          widget.isStudent?
          Positioned(
              bottom: 0.w,
              left: 0.w,
              right: 0.w,
              child: Container(
                height: 95.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFFFACDBA),
                      Color(0xFFFFCEDB8),
                    ],
                  ),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      margin: EdgeInsets.only(left: 31.w),
                      alignment: Alignment.center,
                      child: Text('99+',
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff353e4d))),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    ClipOval(
                      child: Image.asset(
                        R.imagesStudentHead,
                        width: 44.w,
                        height: 44.w,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text('张慧敏',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff353e4d))),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('99.1',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff353e4d))),
                      ),
                    ),
                  ],
                ),
              )):SizedBox.shrink()
        ],
      ),
    ));
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

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        //RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,arguments: weekPaperList![index]);
      },
      child: Container(
        width: 332.w,
        height: 50.w,
        margin: EdgeInsets.only(top: 11.w, left: 22.w, right: 0.w),
        padding: EdgeInsets.only(top: 4.w, bottom: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _firstType(index),
            SizedBox(
              width: 22.w,
            ),
            ClipOval(
              child: Image.network(
                dataList[index]!.avatar ??
                    "https://pics0.baidu.com/feed/0b55b319ebc4b74531587bda64b9f91c888215fb.jpeg@f_auto?token=c5e40b1e9aa7359c642904f84b564921",
                width: 35.w,
                height: 35.w,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return ClipOval(
                      child: Image.asset(
                        R.imagesStudentHead,
                        width: 35.w,
                        height: 35.w,
                      ));
                },
              ),
            )
            ,
            SizedBox(
              width: 10.w,
            ),
            Text(dataList[index]!.actualname?? '',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff353e4d))),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(dataList[index]!.effort.toString(),
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff353e4d))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getStudentRanking(widget.classId.toString());

  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //logic.getList("2022-12-22",currentPageNo,pageSize);
  }

  @override
  void onCreate() {

    logic.addListenerId(
        GetBuilderIds.getStudentRanking + widget.classId.toString(), () {
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
        if (state.myRanking != null && state.myRanking!.obj != null) {
          dataList = state.myRanking!.obj!;
          setState(() {});
        }
      }
    });

    _onRefresh();
  }

  @override
  void onDestroy() {
    Get.delete<Student_rankingLogic>();
    _refreshController.dispose();
  }

  Widget _firstType(int index) {
    if (index == 0) {
      return Image.asset(
        R.imagesRankingFirst,
        width: 24.w,
        height: 44.w,
      );
    }
    if (index == 1) {
      return Image.asset(
        R.imagesRankingSecond,
        width: 24.w,
        height: 44.w,
      );
    }
    if (index == 2) {
      return Image.asset(
        R.imagesRankingThird,
        width: 24.w,
        height: 44.w,
      );
    } else {
      return Container(
        width: 26.w,
        alignment: Alignment.center,
        child: Text((index + 1).toString(),
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff898a93))),
      );
    }
  }
}
