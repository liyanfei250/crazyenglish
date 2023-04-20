import 'dart:math';

import 'package:crazyenglish/utils/MyImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import 'class_message_logic.dart';

class Class_messagePage extends BasePage {
  int? isShowAdd;

  Class_messagePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isShowAdd = Get.arguments['isShowAdd'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToClassMessagePageState();
}

class _ToClassMessagePageState extends BasePageState<Class_messagePage> {
  final logic = Get.put(Class_messageLogic());
  final state = Get.find<Class_messageLogic>().state;

  @override
  void initState() {
    super.initState();
    logic.getClassInfo();
    logic.addListenerId(GetBuilderIds.getHomeScanDate, () {
      if (state.paperDetail != null) {
        /*paperDetail = state.paperDetail;
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
        body: Stack(
      alignment: Alignment.center,
      children: [
        _buildBgView(context),
        Positioned(
            child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Util.buildBackWidget(context),
          centerTitle: true,
          title: Text(
            "班级信息",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Color(0xff353e4d)),
          ),
        )),
        Positioned(top: 116.w, child: _buildClassCard(0))
      ],
    ));
  }

  Widget _buildBgView(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesReviewTopBg), fit: BoxFit.cover),
        ));
  }

  Widget _buildClassCard(int index) => SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
                top: 20.w, left: 14.w, right: 14.w, bottom: 14.w),
            padding:
                EdgeInsets.only(left: 18.w, right: 18.w, top: 2.w, bottom: 2.w),
            width: 340.w,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 70.w,
                  alignment: Alignment.bottomLeft,
                  child: _myHorizontalLayout(
                      R.imagesClassInfoName, "班级名称:", "七年级一班"),
                ),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayoutImage(
                    R.imagesClassInfoPhoto, "班级照片:", R.imagesHomeNextIcBlack),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                Visibility(
                    visible: widget.isShowAdd == 0,
                    child: _myHorizontalLayoutNum(
                        R.imagesClassInfoTeacherName, "班级人数", "22人")),
                Visibility(
                    visible: widget.isShowAdd == 0,
                    child: Divider(
                      color: AppColors.c_FFD2D5DC,
                    )),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherName, "讲师名称:", "七年级一班"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherSex, "讲师性别:", "七年级一班"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherAge, "讲师教龄:", "七年级一班"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherPhoneNum, "联系方式:", "七年级一班"),
                SizedBox(
                  height: 36.w,
                ),
                Visibility(
                    visible: widget.isShowAdd == 1,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  '是否加入当前班级：七年级一班',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '否',
                                      style: TextStyle(
                                          color: Color(0xff353e4d),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(
                                            color: Color(0xffd2d5dc),
                                            width: 1.0),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // TODO: 处理确认按钮点击事件
                                    },
                                    child: Text(
                                      '是',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 270.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          '加入班级',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: widget.isShowAdd == 1 ? 42.w : 0.w,
                ),
              ],
            )),
      );

  Widget _myHorizontalLayoutImage(
          String iconData, String title, String subtitle) =>
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 17.w, bottom: 17.w),
            child: Image.asset(
              iconData,
              width: 16.w,
              height: 16.w,
            ),
          ),
          SizedBox(width: 12.w),
          Padding(
              padding: EdgeInsets.only(top: 17.w, bottom: 17.w),
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Color(0xff353e4d)),
              )),
          SizedBox(width: 10.0),
          Padding(
            padding: EdgeInsets.only(top: 17.w, bottom: 17.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1.0),
              child: Image.network(
                "https://pics0.baidu.com/feed/0b55b319ebc4b74531587bda64b9f91c888215fb.jpeg@f_auto?token=c5e40b1e9aa7359c642904f84b564921",
                width: 120.w,
                height: 80.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );

  Widget _placeWidget() {
    return Container();
  }

  Widget _myHorizontalLayout(String iconData, String title, String subtitle) =>
      Row(
        children: [
          Image.asset(
            iconData,
            width: 16.w,
            height: 16.w,
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Color(0xff353e4d)),
          ),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
            child: Expanded(
                child: Text(
              subtitle,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff353e4d)),
            )),
          )
        ],
      );

  Widget _myHorizontalLayoutNum(
          String iconData, String title, String subtitle) =>
      Row(
        children: [
          Image.asset(
            iconData,
            width: 16.w,
            height: 16.w,
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Color(0xff353e4d)),
          ),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
            child: Text(
              subtitle,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff353e4d)),
            ),
          ),
          Expanded(child: Text('')),
          GestureDetector(
            onTap: () {
              //RouterUtil.offAndToNamed(AppRoutes.QRViewPageNextAudio);
              RouterUtil.toNamed(AppRoutes.StudentRankingPage);
            },
            child: Text(
              '学员排名',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Color(0xffed702d)),
            ),
          ),
          Align(
            heightFactor: 1.3,
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              R.imagesClassInfoNext,
              width: 30.w,
              height: 30.w,
            ),
          ),
        ],
      );

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
