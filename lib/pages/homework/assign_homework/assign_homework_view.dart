import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../../../utils/sp_util.dart';
import '../choose_question/choose_question_view.dart';
import '../choose_student/choose_student_view.dart';
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
  final TextEditingController _editingController = TextEditingController();
  var homeworkName = "".obs;
  var chooseStudentInfo = "".obs;

  var chooseQuestionsInfo = "".obs;
  var chooseJournalInfo = "".obs;
  var chooseExamPaperInfo = "".obs;
  var chooesHistoryInfo = "".obs;

  var chooesEndDateInfo = "".obs;
  var chooseAsExam = false.obs;
  late num endTime;
  var selectData = {
    DateMode.YMDHMS: '',
    DateMode.YMDHM: '',
    DateMode.YMDH: '',
    DateMode.YMD: '',
    DateMode.YM: '',
    DateMode.Y: '',
    DateMode.MDHMS: '',
    DateMode.HMS: '',
    DateMode.MD: '',
    DateMode.S: '',
  };

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getToReleaseWork, () {
      if(state.releaseWork.success!){
        Util.toast('发布作业成功');
        setState(() {

        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: [
          Image.asset(R.imagesTeacherClassTop, width: double.infinity),
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
                        Text(
                          "布置作业",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        if (homeworkName.value.isEmpty) {
                          Util.toast('请填写作业名称');
                          return;
                        }

                        if (chooesEndDateInfo.value.isEmpty) {
                          Util.toast('作业截止日期不能为空');
                          return;
                        }

                        // todo 判断其他条件  调接口
                        //先转成实体类
                        Map<String, dynamic> req = {};
                        req["name"] = homeworkName.value;
                        req["teacherId"] =
                            SpUtil.getString(BaseConstant.TEACHER_USER_ID);
                        req["deadline"] = chooesEndDateInfo.value;
                        List<Map<String, dynamic>> classInfos = [];

                        Map<String, dynamic> student = {};
                        List<num> nums = [];
                        nums.add(1651531759961624578);
                        nums.add(1651533076075499521);
                        student['schoolClassId'] = '1655395694170124290';
                        student['studentUserIds'] = nums;
                        classInfos.add(student);

                        req["classInfos"] = classInfos;

                        req["paperType"] = logic.chooesNum.value; //四选一

                        req["isCreatePaper"] = chooseAsExam.value;
                        if (logic.chooesNum.value == 1) {
                          req["journalCatalogueIds"] = [
                            1648128423083769857,
                            1648138028814798850,
                            1648159430713421825,
                            1654759659150610434
                          ];
                        }
                        if (logic.chooesNum.value == 2) {
                          req["journalId"] = '';
                        }
                        if (logic.chooesNum.value == 3) {
                          req["paperId"] = '382';
                        }
                        if (logic.chooesNum.value == 4) {
                          req["historyOperationId"] = '991';
                        }

                        logic.toReleaseWork(req);
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.5.w)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffee754f).withOpacity(0.25),
                              // 阴影的颜色
                              offset: Offset(0.w, 4.w),
                              // 阴影与容器的距离
                              blurRadius: 8.w,
                              // 高斯的标准偏差与盒子的形状卷积。
                              spreadRadius: 0.w,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              R.imagesIconHomeWorkAsign,
                              width: 16.w,
                              height: 16.w,
                            ),
                            Text(
                              "发布",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            )
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
                  margin: EdgeInsets.only(
                      left: 19.w, bottom: 19.w, top: 35.w, right: 19.w),
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
                            Padding(
                              padding: EdgeInsets.only(left: 18.w),
                              child: Container(
                                height: 22.w,
                                constraints: BoxConstraints(maxWidth: 168.w),
                                padding:
                                    EdgeInsets.only(left: 11.w, right: 11.w),
                                decoration: BoxDecoration(
                                    color: AppColors.c_FFFFF7ED,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.w))),
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                      hintText: "请输入作业名称",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: AppColors.c_80ED702D,
                                        fontSize: 11.sp,
                                      )),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.c_FFED702D,
                                  ),
                                  onChanged: (String str) {
                                    homeworkName.value = str;
                                  },
                                  controller: _editingController,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                              crossAxisAlignment:
                                  chooseStudentInfo.value.isEmpty
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                buildTipsWidget("学生选择"),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: chooseStudentInfo
                                              .value.isNotEmpty,
                                          child: Container(
                                            width: 168.w,
                                            margin:
                                                EdgeInsets.only(bottom: 18.w),
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                top: 8.w,
                                                bottom: 8.w),
                                            decoration: BoxDecoration(
                                                color: AppColors.c_FFFFF7ED,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.w))),
                                            child: Text(
                                                "${chooseStudentInfo.value}",
                                                style: TextStyle(
                                                    color: AppColors.c_FFED702D,
                                                    fontSize: 11.w)),
                                          )),
                                      Util.buildHomeworkNormalBtn(() {
                                            () async {
                                          var result = await Get.to(
                                                  () => ChooseStudentPage());
                                          if (result != null) {
                                            chooseStudentInfo.value = '';
                                          }
                                        }
                                        //todo 学生过去再带数据返回
                                        /*RouterUtil.toNamed(
                                            AppRoutes.ChooseStudentPage)*/;
                                      }, "选择"),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                              crossAxisAlignment:
                                  chooseQuestionsInfo.value.isEmpty
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                buildTipsWidget("习题选择"),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: chooseQuestionsInfo
                                              .value.isNotEmpty,
                                          child: Container(
                                            width: 168.w,
                                            margin:
                                                EdgeInsets.only(bottom: 18.w),
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                top: 8.w,
                                                bottom: 8.w),
                                            decoration: BoxDecoration(
                                                color: AppColors.c_FFFFF7ED,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.w))),
                                            child: Text(
                                                "${chooseQuestionsInfo.value}",
                                                style: TextStyle(
                                                    color: AppColors.c_FFED702D,
                                                    fontSize: 11.w)),
                                          )),
                                      Obx(() => Util.buildHomeworkNormalBtn(
                                              () async {
                                            var result = await Get.to(
                                                () => ChooseQuestionPage());
                                            if (result != null) {
                                              logic.setSelectedData(result);
                                            }
                                          }, "选择",
                                              enable: logic.chooesNum == 0 ||
                                                  logic.chooesNum == 1)),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                              crossAxisAlignment:
                                  chooseJournalInfo.value.isEmpty
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                buildTipsWidget("期刊选择"),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: chooseJournalInfo
                                              .value.isNotEmpty,
                                          child: Container(
                                            width: 168.w,
                                            margin:
                                                EdgeInsets.only(bottom: 18.w),
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                top: 8.w,
                                                bottom: 8.w),
                                            decoration: BoxDecoration(
                                                color: AppColors.c_FFFFF7ED,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.w))),
                                            child: Text(
                                                "${chooseJournalInfo.value}",
                                                style: TextStyle(
                                                    color: AppColors.c_FFED702D,
                                                    fontSize: 11.w)),
                                          )),
                                      Util.buildHomeworkNormalBtn(() {
                                        RouterUtil.toNamed(
                                            AppRoutes.ChooseJournalPage);
                                      }, "选择",
                                          enable: logic.chooesNum == 0 ||
                                              logic.chooesNum == 2),
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
                            Container(
                              padding: EdgeInsets.only(left: 12.w, right: 12.w),
                              margin: EdgeInsets.only(left: 8.w),
                              height: 22.w,
                              width: chooesEndDateInfo.value.isEmpty
                                  ? 150.w
                                  : null,
                              decoration: BoxDecoration(
                                  color: AppColors.c_FFFFF7ED,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(16.5.w))),
                              child: Text(
                                  chooesEndDateInfo.value.isEmpty
                                      ? ''
                                      : "${chooesEndDateInfo.value}",
                                  style: TextStyle(
                                      color: AppColors.c_FFED702D,
                                      fontSize: 11.w)),
                            ),
                            InkWell(
                              onTap: () {
                                _onClickItem(DateMode.YMDHMS);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 6.w),
                                child: Image.asset(
                                  R.imagesHomeWorkTime,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Row(
                          children: [
                            buildTipsWidget("是否存入个人试卷库"),
                            Padding(padding: EdgeInsets.only(left: 12.w)),
                            Obx(() => Util.buildCheckBox(() {
                                  chooseAsExam.value = !chooseAsExam.value;
                                }, chooseEnable: chooseAsExam.value)),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                              crossAxisAlignment:
                                  chooseExamPaperInfo.value.isEmpty
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                buildTipsWidget("试卷库"),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: chooseExamPaperInfo
                                              .value.isNotEmpty,
                                          child: Container(
                                            width: 168.w,
                                            margin:
                                                EdgeInsets.only(bottom: 18.w),
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                top: 8.w,
                                                bottom: 8.w),
                                            decoration: BoxDecoration(
                                                color: AppColors.c_FFFFF7ED,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.w))),
                                            child: Text(
                                                "${chooseExamPaperInfo.value}",
                                                style: TextStyle(
                                                    color: AppColors.c_FFED702D,
                                                    fontSize: 11.w)),
                                          )),
                                      Util.buildHomeworkNormalBtn(() {
                                        RouterUtil.toNamed(
                                            AppRoutes.ChooseExamPaperPage);
                                      }, "选择",
                                          enable: logic.chooesNum == 0 ||
                                              logic.chooesNum == 3),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        Obx(() => Row(
                              crossAxisAlignment:
                                  chooesHistoryInfo.value.isEmpty
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                buildTipsWidget("历史作业"),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: chooesHistoryInfo
                                              .value.isNotEmpty,
                                          child: Container(
                                            width: 168.w,
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                top: 8.w,
                                                bottom: 8.w),
                                            margin:
                                                EdgeInsets.only(bottom: 18.w),
                                            decoration: BoxDecoration(
                                                color: AppColors.c_FFFFF7ED,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.w))),
                                            child: Text(
                                                "${chooesHistoryInfo.value}",
                                                style: TextStyle(
                                                    color: AppColors.c_FFED702D,
                                                    fontSize: 11.w)),
                                          )),
                                      Util.buildHomeworkNormalBtn(() {
                                        RouterUtil.toNamed(
                                            AppRoutes.ChooseHistoryHomeworkPage,
                                            arguments: {
                                              "isAssignHomework": true
                                            });
                                      }, "选择",
                                          enable: logic.chooesNum == 0 ||
                                              logic.chooesNum == 4),
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
  void onDestroy() {}

  Widget buildTipsWidget(String text) {
    return Stack(
      children: [
        Container(
          height: 17.w,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: AppColors.c_FFFCEFD8,
            width: 5.w,
          ))),
          child: Text("${text}", style: TextStyle(color: Colors.transparent)),
        ),
        Container(
          height: 17.w,
          child: Text(
            "${text} :",
            style: TextStyle(
                color: AppColors.c_FF353E4D,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  void _onClickItem(model) {
    Pickers.showDatePicker(
      context,
      mode: model,
      suffix: Suffix.normal(),
      minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(second: 22),
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
        setState(() {
          switch (model) {
            case DateMode.YMDHMS:
              selectData[model] =
                  '${p.year}年${p.month}月${p.day}日 ${p.hour}:${p.minute}:${p.second}';
              DateFormat inputFormat = DateFormat("yyyy年M月d日 H:m:s");
              DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
              DateTime dateTime = inputFormat.parse(
                  '${p.year}年${p.month}月${p.day}日 ${p.hour}:${p.minute}:${p.second}');
              String output = outputFormat.format(dateTime);
              chooesEndDateInfo.value = output;
              break;
          }
        });
      },
      // onChanged: (p) => print(p),
    );
  }
}
