import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../base_homework_page_state.dart';
import 'assign_homework_logic.dart';

/**
 * 布置作业
 */
class AssignHomeworkPage extends BasePage {
  const AssignHomeworkPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _AssignHomeworkPageState();
}

class _AssignHomeworkPageState extends BaseHomeworkPageState<AssignHomeworkPage> {
  final logic = Get.put(AssignHomeworkLogic());
  final state = Get.find<AssignHomeworkLogic>().state;
  final TextEditingController _editingController = TextEditingController();
  var homeworkName = "".obs;
  var chooseStudentInfo = "已选班级（七年级一班50/50）\n（七年级二班50/30）".obs;
  var chooseQuestionsInfo = "听（80）/说（36）/读（52） /写（88）".obs;
  var chooseJournalInfo = "初二阅读01期".obs;
  var chooseExamPaperInfo = "试卷名称：清明节假期作业1".obs;
  var chooesHistoryInfo = "作业名称：清明节假期作业1".obs;
  var chooesEndDateInfo = "2023年03月23日10:00".obs;
  var chooseAsExam = false.obs;

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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Util.buildWhiteWidget(context),
                        Text("布置作业"),
                      ],
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: 28.w,
                        padding: EdgeInsets.symmetric(horizontal: 17.w),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(R.imagesIconHomeWorkAsign,width: 16.w,height: 16.w,),
                            Text("发布",style: TextStyle(color: Colors.white,fontSize: 12.sp),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildTipsWidget("作业名称"),
                            Padding(padding: EdgeInsets.only(left: 18.w),
                              child: Container(
                                height: 22.w,
                                constraints: BoxConstraints(maxWidth: 168.w),
                                padding: EdgeInsets.only(left: 11.w,right: 11.w),
                                decoration: BoxDecoration(
                                    color: AppColors.c_FFFFF7ED,
                                    borderRadius: BorderRadius.all(Radius.circular(8.w))
                                ),
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(hintText: "请输入作业名称",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: AppColors.c_80ED702D,
                                        fontSize: 11.sp,
                                      )),
                                  style: TextStyle(fontSize: 18, color: AppColors.c_FFED702D,),
                                  onChanged: (String str) {
                                    homeworkName.value = str;
                                    if(homeworkName.value.isNotEmpty){
                                    } else {
                                    }
                                  },
                                  controller: _editingController,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                          crossAxisAlignment: chooseStudentInfo.value.isEmpty? CrossAxisAlignment.center :CrossAxisAlignment.start,
                          children: [
                            buildTipsWidget("学生选择"),
                            Padding(padding: EdgeInsets.only(left: 18.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: chooseStudentInfo.value.isNotEmpty,
                                      child: Container(
                                        width: 168.w,
                                        margin: EdgeInsets.only(bottom: 18.w),
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 8.w,bottom: 8.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.c_FFFFF7ED,
                                            borderRadius: BorderRadius.all(Radius.circular(8.w))
                                        ),
                                        child: Text("${chooseStudentInfo.value}"),
                                      )),
                                  buildHomeworkNormalBtn(() { }, "选择"),
                                ],
                              ),
                            )
                          ],
                        )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                          crossAxisAlignment: chooseQuestionsInfo.value.isEmpty? CrossAxisAlignment.center :CrossAxisAlignment.start,
                          children: [
                            buildTipsWidget("习题选择"),
                            Padding(padding: EdgeInsets.only(left: 18.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: chooseQuestionsInfo.value.isNotEmpty,
                                      child: Container(
                                        width: 168.w,
                                        margin: EdgeInsets.only(bottom: 18.w),
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 8.w,bottom: 8.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.c_FFFFF7ED,
                                            borderRadius: BorderRadius.all(Radius.circular(8.w))
                                        ),
                                        child: Text("${chooseQuestionsInfo.value}"),
                                      )),
                                  buildHomeworkNormalBtn(() { }, "选择"),
                                ],
                              ),
                            )
                          ],
                        )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                          crossAxisAlignment: chooseJournalInfo.value.isEmpty? CrossAxisAlignment.center :CrossAxisAlignment.start,
                          children: [
                            buildTipsWidget("期刊选择"),
                            Padding(padding: EdgeInsets.only(left: 18.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: chooseJournalInfo.value.isNotEmpty,
                                      child: Container(
                                        width: 168.w,
                                        margin: EdgeInsets.only(bottom: 18.w),
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 8.w,bottom: 8.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.c_FFFFF7ED,
                                            borderRadius: BorderRadius.all(Radius.circular(8.w))
                                        ),
                                        child: Text("${chooseJournalInfo.value}"),
                                      )),
                                  buildHomeworkNormalBtn(() { }, "选择"),
                                ],
                              ),
                            )
                          ],
                        )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildTipsWidget("作业截止时间"),
                            Visibility(
                                visible: chooesEndDateInfo.value.isNotEmpty,
                                child: Container(
                                  padding: EdgeInsets.only(left: 12.w,right: 12.w),
                                  margin: EdgeInsets.only(left: 8.w),
                                  height: 22.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.c_FFFFF7ED,
                                      borderRadius: BorderRadius.all(Radius.circular(16.5.w))
                                  ),
                                  child: Text("${chooesEndDateInfo.value}"),
                                )),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 6.w),
                                child: Image.asset(R.imagesHomeWorkTime,width: 16.w,height: 16.w,),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Row(
                          children: [
                            buildTipsWidget("是否存入个人试卷库"),
                            Padding(padding: EdgeInsets.only(left: 12.w)),
                            Obx(() => buildCheckBox((){
                              chooseAsExam.value = !chooseAsExam.value;
                            },chooseEnable: chooseAsExam.value)),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                          crossAxisAlignment: chooseExamPaperInfo.value.isEmpty? CrossAxisAlignment.center :CrossAxisAlignment.start,
                          children: [
                            buildTipsWidget("试卷库"),
                            Padding(padding: EdgeInsets.only(left: 18.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: chooseExamPaperInfo.value.isNotEmpty,
                                      child: Container(
                                        width: 168.w,
                                        margin: EdgeInsets.only(bottom: 18.w),
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 8.w,bottom: 8.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.c_FFFFF7ED,
                                            borderRadius: BorderRadius.all(Radius.circular(8.w))
                                        ),
                                        child: Text("${chooseExamPaperInfo.value}",style:TextStyle(color:AppColors.c_FFED702D,)),
                                      )),
                                  buildHomeworkNormalBtn(() { }, "选择"),
                                ],
                              ),
                            )
                          ],
                        )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                          crossAxisAlignment: chooesHistoryInfo.value.isEmpty? CrossAxisAlignment.center :CrossAxisAlignment.start,
                          children: [
                            buildTipsWidget("历史作业"),
                            Padding(padding: EdgeInsets.only(left: 18.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: chooesHistoryInfo.value.isNotEmpty,
                                      child: Container(
                                        width: 168.w,
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 8.w,bottom: 8.w),
                                        margin: EdgeInsets.only(bottom: 18.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.c_FFFFF7ED,
                                            borderRadius: BorderRadius.all(Radius.circular(8.w))
                                        ),
                                        child: Text("${chooesHistoryInfo.value}"),
                                      )),
                                  buildHomeworkNormalBtn(() { }, "选择"),
                                ],
                              ),
                            )
                          ],
                        )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                      ],
                    ),
                  ),
                ),
              ),

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