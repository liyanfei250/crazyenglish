import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    "答疑",
    "课件",
    "班级作业",
    "班级群",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Container(
          width: 331.w,
          height: 180.w,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(R.imagesTeacherClassTop),
              fit: BoxFit.cover
            )
          ),
          child: Image.asset(R.imagesClassQrcode,width: 77.w,height: 77.w,),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.w,left: 22.w,right: 22.w),
          child: GridView.builder(
              shrinkWrap:true,
              itemCount: functionTxt.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemBuilder: (_,int position){
                String e = functionTxt[position];
                return _buildFuncAreaItem(e);
              }),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.w,left: 22.w,right: 22.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("学生列表",style: TextStyle(fontSize: 18.sp,color: AppColors.TEXT_BLACK_COLOR),),
              Image.asset(R.imagesTeacherHomeBtnPop,width: 9.w,height: 9.w,)
            ],
          ),
        ),
        Expanded(child: ListView.builder(itemBuilder: buildItem),)
      ],
    );
  }

  Widget buildItem(BuildContext context,int index){
    return InkWell(
      onTap: (){
        RouterUtil.toNamed(AppRoutes.TEACHER_STUDENT);
      },
      child: Container(
        height: 171.w,
        margin: EdgeInsets.only(top: 10.w,left: 22.w,right: 22.w),
        padding: EdgeInsets.only(left: 16.w),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5),		// 阴影的颜色
                offset: Offset(10, 20),						// 阴影与容器的距离
                blurRadius: 45.0,							// 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: AppColors.c_FFFFFFFF
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(R.imagesStudentHead,width: 80.w,height: 80.w,),
                Padding(padding: EdgeInsets.only(top: 14.w)),
                Image.asset(R.imagesStudentNotify,width: 80.w,height: 20.w,),
                Padding(padding: EdgeInsets.only(top: 5.w)),
                Image.asset(R.imagesStudentNotifyParent,width: 80.w,height: 20.w,),
              ],
            ),
            Padding(padding: EdgeInsets.only(left: 15.w)),
            Image.asset(R.imagesStudentInfo,width: 195.w,height: 142.w,),
          ],
        ),
      ),
    );
  }


  Widget _buildFuncAreaItem(String e) => InkWell(
    onTap: (){
      switch(e){
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("images/class_fun_${functionTxt.indexOf(e)}.png",width: 40.w,height: 40.w,),
        Padding(padding: EdgeInsets.only(bottom: 2.w)),
        Text(e,style: TextStyle(fontSize: 12.sp,color: AppColors.TEXT_BLACK_COLOR),)
      ],
    ),
  );

  @override
  void dispose() {
    Get.delete<ClassHomeLogic>();
    super.dispose();
  }
}