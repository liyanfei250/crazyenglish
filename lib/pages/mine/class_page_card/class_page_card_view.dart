import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'class_page_card_logic.dart';

class ClassCard extends StatefulWidget {
  final bool isShowAdd;
  final bool isShowRank;
  final int index;
  final String className;
  final String classImage;
  final String studentSize;
  final String teacherName;
  final String teacherSex;
  final String teacherAge;
  final String teacherConnect;

  const ClassCard(
      {Key? key,
      this.isShowAdd = false,
      this.isShowRank = false,
      this.className = "",
      this.classImage = "",
      this.studentSize = "",
      this.teacherName = "",
      this.teacherSex = "",
      this.teacherAge = "",
      this.teacherConnect = "",
      this.index = 0})
      : super(key: key);

  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(top: 20.w, left: 14.w, right: 14.w, bottom: 14.w),
        padding:
            EdgeInsets.only(left: 18.w, right: 18.w, top: 2.w, bottom: 2.w),
        width: 340.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.c_FFFFEBEB.withOpacity(0.5),
              offset: Offset(10, 20),
              blurRadius: 45.0,
              spreadRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: AppColors.c_FFFFFFFF,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 70.w,
              alignment: Alignment.bottomLeft,
              child: _myHorizontalLayout(
                  R.imagesClassInfoName, "班级名称:", widget.className ?? ''),
            ),
            Divider(
              color: AppColors.c_FFD2D5DC,
            ),
            _myHorizontalLayoutImage(R.imagesClassInfoPhoto, "班级照片:",
                R.imagesHomeNextIcBlack, widget.classImage),
            Divider(
              color: AppColors.c_FFD2D5DC,
            ),
            Visibility(
              visible: widget.isShowAdd | widget.isShowRank,
              child: _myHorizontalLayoutNum(R.imagesClassInfoTeacherName,
                  "班级人数", widget.studentSize ?? ''),
            ),
            Visibility(
              visible: widget.isShowAdd | widget.isShowRank,
              child: Divider(
                color: AppColors.c_FFD2D5DC,
              ),
            ),
            _myHorizontalLayout(R.imagesClassInfoTeacherName, "讲师名称:",
                widget.teacherName ?? ''),
            Divider(
              color: AppColors.c_FFD2D5DC,
            ),
            _myHorizontalLayout(
                R.imagesClassInfoTeacherSex, "讲师性别:", widget.teacherSex ?? ''),
            Divider(
              color: AppColors.c_FFD2D5DC,
            ),
            _myHorizontalLayout(
                R.imagesClassInfoTeacherAge, "讲师教龄:", widget.teacherAge ?? ''),
            Divider(
              color: AppColors.c_FFD2D5DC,
            ),
            _myHorizontalLayout(R.imagesClassInfoTeacherPhoneNum, "联系方式:",
                widget.teacherConnect ?? ''),
            SizedBox(
              height: 36.w,
            ),
            Visibility(
              visible: widget.isShowAdd,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text(
                            '是否加入当前班级：' + widget.className ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: Color(0xffd2d5dc),
                                    width: 1.0,
                                  ),
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
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
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
              ),
            ),
            SizedBox(
              height: widget.isShowAdd ? 42.w : 0.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _myHorizontalLayoutImage(
          String iconData, String title, String subtitle, String netImage) =>
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
                color: Color(0xff353e4d),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Padding(
            padding: EdgeInsets.only(top: 17.w, bottom: 17.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1.0),
              child: Image.network(
                netImage ??
                    "https://pics0.baidu.com/feed/0b55b319ebc4b74531587bda64b9f91c888215fb.jpeg@f_auto?token=c5e40b1e9aa7359c642904f84b564921",
                width: 120.w,
                height: 80.w,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(1.0),
                      child: Image(
                        image: AssetImage(R.imagesSearchPlaceIc),
                        width: 120.w,
                        height: 80.w,
                        fit: BoxFit.cover,
                      ));
                },
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
              color: Color(0xff353e4d),
            ),
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
                  color: Color(0xff353e4d),
                ),
              ),
            ),
          ),
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
              color: Color(0xff353e4d),
            ),
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
                color: Color(0xff353e4d),
              ),
            ),
          ),
          Expanded(child: Text('')),
          GestureDetector(
            onTap: () {
              RouterUtil.toNamed(AppRoutes.StudentRankingPage);
            },
            child: Text(
              '学员排名',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Color(0xffed702d),
              ),
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
}
