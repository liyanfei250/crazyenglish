import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/ShareScreen.dart';
import '../../utils/permissions/permissions_util.dart';
import 'student_ranking_logic.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
class Student_rankingPage extends BasePage {
  const Student_rankingPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToStudentRankingPageState();
}

class _ToStudentRankingPageState extends BasePageState<Student_rankingPage> {
  final logic = Get.put(Student_rankingLogic());
  final state = Get.find<Student_rankingLogic>().state;
  final GlobalKey _globalKey = GlobalKey();

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
                  await PermissionsUtil.checkPermissions(
                      context,
                      "为了正常访问相册，需要您授权以下权限",
                      [RequestPermissionsTag.PHOTOS], () {
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
          //点击右上角的"分享"按钮，将当前的屏幕显示的view截图，然后跳转到下个新界面，新界面顶部显示刚才截图的图片，width为屏幕的80%，顶部有close图标，点击可退出，图片底部横向均分三个按钮，整个新界面的背景带透明的阴影，类似dialog的效果
          Positioned(
              top: 244.w,
              bottom: 30.w,
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
              )),
          Positioned(
              bottom: 0.w,
              left: 0.w,
              right: 0.w,
              child: Container(
                height: 95,
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
              ))
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
  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
