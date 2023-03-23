import 'package:crazyenglish/utils/MyImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import 'class_message_logic.dart';

class Class_messagePage extends BasePage {
  const Class_messagePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToClassMessagePageState();
}

class _ToClassMessagePageState extends BasePageState<Class_messagePage> {
  final logic = Get.put(Class_messageLogic());
  final state = Get.find<Class_messageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    ) /*Scaffold(
      appBar: buildNormalAppBar("班级信息"),
      backgroundColor: AppColors.theme_bg,
    )*/
        ;
  }

  Widget _buildBgView(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesReviewTopBg), fit: BoxFit.cover),
        ));
  }

  Widget _buildClassCard(int index) => Container(
      margin: EdgeInsets.only(top: 20.w, left: 14.w, right: 14.w, bottom: 14.w),
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 2.w, bottom: 2.w),
      width: 300.w,
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
        children: [
          _myHorizontalLayout(R.imagesHomeNextIcBlack, "班级名称", "七年级一班"),
          Divider(
            color: AppColors.c_FFD2D5DC,
            indent: 15.w,
            endIndent: 15.w,
          ),
          _myHorizontalLayoutImage(
              R.imagesHomeNextIcBlack, "班级名称", R.imagesHomeNextIcBlack),
          Divider(
            color: AppColors.c_FFD2D5DC,
            indent: 15.w,
            endIndent: 15.w,
          ),
          _myHorizontalLayout(R.imagesHomeNextIcBlack, "班级名称", "七年级一班"),
          _myHorizontalLayout(R.imagesHomeNextIcBlack, "班级名称", "七年级一班"),
          _myHorizontalLayout(R.imagesHomeNextIcBlack, "班级名称", "七年级一班"),
          _myHorizontalLayout(R.imagesHomeNextIcBlack, "班级名称", "七年级一班"),
        ],
      ));

  Widget _myHorizontalLayoutImage(
          String iconData, String title, String subtitle) =>
      Row(
        children: [
          Image.asset(
            iconData,
            width: 16.w,
            height: 16.w,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: MyImageLoader(
                imageUrl:
                    "https://pics0.baidu.com/feed/0b55b319ebc4b74531587bda64b9f91c888215fb.jpeg@f_auto?token=c5e40b1e9aa7359c642904f84b564921",
                height: 80.w,
                width: 120.w,
                placeholder: _placeWidget()),
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
          SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      );

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
