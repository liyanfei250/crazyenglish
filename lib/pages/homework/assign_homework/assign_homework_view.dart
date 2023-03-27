import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../r.dart';
import '../../../utils/colors.dart';
import 'assign_homework_logic.dart';

/**
 * 布置作业
 */
class AssignHomeworkPage extends BasePage {
  const AssignHomeworkPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _AssignHomeworkPageState();
}

class _AssignHomeworkPageState extends BasePageState<AssignHomeworkPage> {
  final logic = Get.put(AssignHomeworkLogic());
  final state = Get.find<AssignHomeworkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: [
          Image.asset(R.imagesTeacherClassTop,width: double.infinity),
          Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Text("布置作业"),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 19.w,bottom:19.w,top:35.w,right: 19.w),
                  padding: EdgeInsets.only(left: 27.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.w)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 17.w,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.c_FFFCEFD8,width: 5.w))
                        ),
                        child: Text("作业名称",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 12.sp,fontWeight: FontWeight.w500),),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 53.w,bottom: 30.w,right: 58.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("全选",style: TextStyle(color: AppColors.c_FFED702D,fontSize: 12.sp,fontWeight: FontWeight.w500),),
                        Padding(padding: EdgeInsets.only(left: 36.w)),
                        Text("已选",style: TextStyle(color: AppColors.c_FFED702D,fontSize: 12.sp,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: 77.w,
                        height: 28.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xfff19e59),
                                Color(0xffec5f2a),
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(16.5.w)),
                          boxShadow:[
                            BoxShadow(
                              color: Color(0xffee754f).withOpacity(0.25),		// 阴影的颜色
                              offset: Offset(0.w, 4.w),						// 阴影与容器的距离
                              blurRadius: 8.w,							// 高斯的标准偏差与盒子的形状卷积。
                              spreadRadius: 0.w,
                            ),
                          ],
                        ),
                        child: Text("完成",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<AssignHomeworkLogic>();
    super.dispose();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}