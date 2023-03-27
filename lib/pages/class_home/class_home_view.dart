import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import 'class_home_logic.dart';

class ClassHomePage extends StatefulWidget {
  const ClassHomePage({Key? key}) : super(key: key);

  @override
  _ClassHomePageState createState() => _ClassHomePageState();
}

class _ClassHomePageState extends State<ClassHomePage> {
  final logic = Get.put(ClassHomeLogic());
  final state = Get.find<ClassHomeLogic>().state;

  final List<String> functionTxt = [
    "公告",
    "作业",
    "班级",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      buildItemClass('班级状态：', '正常'),
                      buildItemClass('答题正确率：', '78%'),
                      buildItemClass('班级已做卷子：', '53份'),
                      buildItemClass('阅读总数：', '正常'),
                      buildItemClass('班级努力值：', '正常'),
                      buildItemClass('班级人数：', '正常'),
                    ],
                  ),
                ),
                Image.asset(
                  R.imagesClassQrcode,
                  width: 77.w,
                  height: 77.w,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 26.w, left: 40.w, right: 40.w),
            child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: functionTxt.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (_, int position) {
                  String e = functionTxt[position];
                  return _buildFuncAreaItem(e);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.w, left: 22.w, right: 22.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "学生列表",
                  style: TextStyle(
                      fontSize: 18.sp, color: AppColors.TEXT_BLACK_COLOR),
                ),
                Image.asset(
                  R.imagesHomeNextIcBlack,
                  width: 9.w,
                  height: 9.w,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.w,
          ),
          ListView.builder(
            itemBuilder: buildItem,
            itemCount: 6,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
          ),
          buildContainerNodate()
        ],
      ),
    );
  }

  Widget buildContainerNodate() {
    return Container(
      padding: EdgeInsets.only(top: 30.w,bottom: 30.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            R.imagesStudentNoDate,
            width: 138.w,
            height: 138.w,
          ),
          SizedBox(height: 20.w,),
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

  Widget _buildFuncAreaItem(String e) => InkWell(
        onTap: () {
          switch (e) {
            case "作业":
              RouterUtil.toNamed(AppRoutes.AssignHomeworkPage);
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "images/class_fun_${functionTxt.indexOf(e)}.png",
              width: 40.w,
              height: 40.w,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15.w)),
            Text(
              e,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xff898a93),
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );

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

  @override
  void dispose() {
    Get.delete<ClassHomeLogic>();
    super.dispose();
  }
}
