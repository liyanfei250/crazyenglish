import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/homework/choose_exam_paper/choose_exam_paper_view.dart';
import 'package:crazyenglish/pages/homework/choose_history_new_homework/choose_history_new_homework_view.dart';
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
import '../choose_history_homework/choose_history_homework_view.dart';
import '../choose_question/choose_question_view.dart';
import 'assign_homework_logic.dart';

/**
 * 布置作业
 */
class AssignHomeworkPage extends BasePage {
  late int paperType = 0;
  late String? paperId;
  late String? examDesc;

  AssignHomeworkPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      paperType = Get.arguments['paperType'] ?? 0;
      paperId = Get.arguments['paperId'] ?? '';
      examDesc = Get.arguments['examDesc'] ?? '';
    }
  }

  @override
  BasePageState<BasePage> getState() => _AssignHomeworkPageState();
}

class _AssignHomeworkPageState extends BasePageState<AssignHomeworkPage> {
  final logic = Get.put(AssignHomeworkLogic());
  final state = Get.find<AssignHomeworkLogic>().state;
  final TextEditingController _editingController = TextEditingController();
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
    if (widget.paperType! > 0) {
      logic!.updateAssignHomeworkRequest(
          paperType: widget.paperType,
          paperId: widget.paperId,
          examDesc: widget.examDesc.toString());
    }

    logic.addListenerId(GetBuilderIds.getToReleaseWork, () {
      if (state.releaseWork.code == 0) {
        Util.toast('发布作业成功');
        setState(() {});
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
                        logic.toReleaseWork();
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.c_FFED702D,
                                  ),
                                  onChanged: (String str) {
                                    logic.updateAssignHomeworkRequest(
                                        homeworkName: str);
                                  },
                                  controller: _editingController,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        GetBuilder<AssignHomeworkLogic>(
                            id: GetBuilderIds.getUpdateAssignHomeworkRequest,
                            builder: (logic) {
                              return Row(
                                crossAxisAlignment: logic
                                                .state
                                                .assignHomeworkRequest
                                                .classInfos ==
                                            null ||
                                        logic.state.assignHomeworkRequest
                                            .classInfos!.isEmpty
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
                                            visible: logic
                                                        .state
                                                        .assignHomeworkRequest
                                                        .classInfos !=
                                                    null &&
                                                logic
                                                    .state
                                                    .assignHomeworkRequest
                                                    .classInfos!
                                                    .isNotEmpty,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.w))),
                                              child: Text(
                                                  logic.state
                                                      .schoolClassInfoDesc,
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.c_FFED702D,
                                                      fontSize: 11.w)),
                                            )),
                                        GetBuilder<AssignHomeworkLogic>(
                                          id: GetBuilderIds
                                              .getUpdateAssignHomeworkRequest,
                                          builder: (logic) {
                                            return Util.buildHomeworkNormalBtn(
                                                () {
                                              RouterUtil.toNamed(
                                                  AppRoutes.ChooseStudentPage,
                                                  arguments: {
                                                    ChooseHistoryHomeworkPage
                                                        .IsAssignHomework: true
                                                  });
                                            }, "选择", enable: true);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        GetBuilder<AssignHomeworkLogic>(
                            id: GetBuilderIds.getUpdateAssignHomeworkRequest,
                            builder: (logic) {
                              return Row(
                                crossAxisAlignment: (logic
                                                .state
                                                .assignHomeworkRequest
                                                .journalCatalogueIds ??
                                            [])
                                        .isEmpty
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
                                            visible: (logic
                                                        .state
                                                        .assignHomeworkRequest
                                                        .journalCatalogueIds ??
                                                    [])
                                                .isNotEmpty,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.w))),
                                              child: Text(
                                                  logic.state.questionDesc,
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.c_FFED702D,
                                                      fontSize: 11.w)),
                                            )),
                                        GetBuilder<AssignHomeworkLogic>(
                                          id: GetBuilderIds
                                              .getUpdateAssignHomeworkRequest,
                                          builder: (logic) {
                                            return Util.buildHomeworkNormalBtn(
                                                () {
                                              RouterUtil.toNamed(
                                                  AppRoutes.ChooseQuestionPage,
                                                  arguments: {});
                                            }, "选择",
                                                enable: (logic
                                                                .state
                                                                .assignHomeworkRequest
                                                                .paperType ??
                                                            0) <=
                                                        0 ||
                                                    (logic.state.assignHomeworkRequest
                                                                .paperType ??
                                                            0) ==
                                                        PaperType.Questions);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        GetBuilder<AssignHomeworkLogic>(
                            id: GetBuilderIds.getUpdateAssignHomeworkRequest,
                            builder: (logic) {
                              return Row(
                                crossAxisAlignment: (logic
                                                .state
                                                .assignHomeworkRequest
                                                .journalId ??
                                            "")
                                        .isEmpty
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
                                            visible: (logic
                                                        .state
                                                        .assignHomeworkRequest
                                                        .journalId ??
                                                    "")
                                                .isNotEmpty,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.w))),
                                              child: Text(
                                                  logic.state.journalDesc,
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.c_FFED702D,
                                                      fontSize: 11.w)),
                                            )),
                                        GetBuilder<AssignHomeworkLogic>(
                                          id: GetBuilderIds
                                              .getUpdateAssignHomeworkRequest,
                                          builder: (logic) {
                                            return Util.buildHomeworkNormalBtn(
                                                () {
                                              RouterUtil.toNamed(
                                                  AppRoutes.ChooseJournalPage,
                                                  arguments: {});
                                            }, "选择",
                                                enable: (logic
                                                                .state
                                                                .assignHomeworkRequest
                                                                .paperType ??
                                                            0) <=
                                                        0 ||
                                                    (logic.state.assignHomeworkRequest
                                                                .paperType ??
                                                            0) ==
                                                        PaperType.Journals);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        GetBuilder<AssignHomeworkLogic>(
                            id: GetBuilderIds.getUpdateAssignHomeworkRequest,
                            builder: (logic) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildTipsWidget("作业截止时间"),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 12.w, right: 12.w),
                                    margin: EdgeInsets.only(left: 8.w),
                                    height: 22.w,
                                    width: (logic.state.assignHomeworkRequest
                                                    .deadline ??
                                                "")
                                            .isEmpty
                                        ? 150.w
                                        : null,
                                    decoration: BoxDecoration(
                                        color: AppColors.c_FFFFF7ED,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.5.w))),
                                    child: Text(
                                        (logic.state.assignHomeworkRequest
                                                        .deadline ??
                                                    "")
                                                .isEmpty
                                            ? ''
                                            : (logic.state.assignHomeworkRequest
                                                    .deadline ??
                                                ""),
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
                              );
                            }),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        GetBuilder<AssignHomeworkLogic>(
                            id: GetBuilderIds.getUpdateAssignHomeworkRequest,
                            builder: (logic) {
                              return Row(
                                children: [
                                  buildTipsWidget("是否存入个人试卷库"),
                                  Padding(padding: EdgeInsets.only(left: 12.w)),
                                  GetBuilder<AssignHomeworkLogic>(
                                    id: GetBuilderIds
                                        .getUpdateAssignHomeworkRequest,
                                    builder: (logic) {
                                      return Util.buildCheckBox(() {
                                        logic.updateAssignHomeworkRequest(
                                            isCreatePaper: !(logic
                                                    .state
                                                    .assignHomeworkRequest
                                                    .isCreatePaper ??
                                                false));
                                      },
                                          chooseEnable: logic
                                                  .state
                                                  .assignHomeworkRequest
                                                  .isCreatePaper ??
                                              false);
                                    },
                                  ),
                                ],
                              );
                            }),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        GetBuilder<AssignHomeworkLogic>(
                          id: GetBuilderIds.getUpdateAssignHomeworkRequest,
                          builder: (logic) {
                            return Row(
                              crossAxisAlignment:
                                  (logic.state.assignHomeworkRequest.paperId ??
                                              "")
                                          .isEmpty
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
                                          visible: (logic
                                                      .state
                                                      .assignHomeworkRequest
                                                      .paperId ??
                                                  "")
                                              .isNotEmpty,
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
                                            child: Text(logic.state.examDesc,
                                                style: TextStyle(
                                                    color: AppColors.c_FFED702D,
                                                    fontSize: 11.w)),
                                          )),
                                      GetBuilder<AssignHomeworkLogic>(
                                        id: GetBuilderIds
                                            .getUpdateAssignHomeworkRequest,
                                        builder: (logic) {
                                          return Util.buildHomeworkNormalBtn(
                                              () {
                                            RouterUtil.toNamed(
                                                AppRoutes.ChooseExamPaperPage,
                                                arguments: {
                                                  ChooseExamPaperPage
                                                      .IsAssignHomework: true
                                                });
                                          }, "选择",
                                              enable: (logic
                                                              .state
                                                              .assignHomeworkRequest
                                                              .paperType ??
                                                          0) <=
                                                      0 ||
                                                  (logic.state.assignHomeworkRequest
                                                              .paperType ??
                                                          0) ==
                                                      PaperType.exam);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.w)),
                        GetBuilder<AssignHomeworkLogic>(
                          id: GetBuilderIds.getUpdateAssignHomeworkRequest,
                          builder: (logic) {
                            return Row(
                              crossAxisAlignment: (logic
                                              .state
                                              .assignHomeworkRequest
                                              .historyOperationId ??
                                          "")
                                      .isEmpty
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
                                          visible: (logic
                                                      .state
                                                      .assignHomeworkRequest
                                                      .historyOperationId ??
                                                  "")
                                              .isNotEmpty,
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
                                                logic.state.historyHomeworkDesc,
                                                style: TextStyle(
                                                    color: AppColors.c_FFED702D,
                                                    fontSize: 11.w)),
                                          )),
                                      GetBuilder<AssignHomeworkLogic>(
                                        id: GetBuilderIds
                                            .getUpdateAssignHomeworkRequest,
                                        builder: (logic) {
                                          return Util.buildHomeworkNormalBtn(
                                              () {
                                            RouterUtil.toNamed(
                                                AppRoutes
                                                    .ChooseHistoryNewHomeworkPage,
                                                arguments: {
                                                  ChooseHistoryNewHomeworkPage
                                                      .IsAssignHomework: true
                                                });
                                          }, "选择",
                                              enable: (logic
                                                              .state
                                                              .assignHomeworkRequest
                                                              .paperType ??
                                                          0) <=
                                                      0 ||
                                                  (logic.state.assignHomeworkRequest
                                                              .paperType ??
                                                          0) ==
                                                      PaperType
                                                          .HistoryHomework);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
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
        switch (model) {
          case DateMode.YMDHMS:
            selectData[model] =
                '${p.year}年${p.month}月${p.day}日 ${p.hour}:${p.minute}:${p.second}';
            DateFormat inputFormat = DateFormat("yyyy年M月d日 H:m:s");
            DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
            DateTime dateTime = inputFormat.parse(
                '${p.year}年${p.month}月${p.day}日 ${p.hour}:${p.minute}:${p.second}');
            String output = outputFormat.format(dateTime);
            logic.updateAssignHomeworkRequest(deadline: output);
            break;
        }
      },
      // onChanged: (p) => print(p),
    );
  }
}
