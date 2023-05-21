import 'dart:math';

import 'package:crazyenglish/utils/MyImageLoader.dart';
import 'package:crazyenglish/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../utils/sp_util.dart';
import '../../../widgets/PlaceholderPage.dart';
import '../../mine/class_page_card/class_page_card_view.dart';
import 'class_message_logic.dart';
import '../../../entity/class_detail_response.dart';

class Class_messagePage extends BasePage {
  int? isShowAdd;

  String? classId;

  // bool? isStudent;
  // bool? isAdd;

  Class_messagePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isShowAdd = Get.arguments['isShowAdd'];
      classId = Get.arguments['classId'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToClassMessagePageState();
}

class _ToClassMessagePageState extends BasePageState<Class_messagePage> {
  final logic = Get.put(Class_messageLogic());
  final state = Get.find<Class_messageLogic>().state;
  late Obj detailBean = Obj();
  late TeacherInfo teacherInfo = TeacherInfo();

  @override
  void initState() {
    super.initState();

    logic.addListenerId(
        GetBuilderIds.getMyClassListDetail +
            widget.classId.toString() +
            (widget.isShowAdd == 1 ? true : false).toString(), () {
      if (mounted &&
          state.myClassListDetail != null &&
          state.myClassListDetail!.obj != null) {
        print("班级数据===" + state.myClassListDetail!.obj!.name!);

        detailBean = state.myClassListDetail!.obj!;
        if (state.myClassListDetail!.obj!.teacherInfo != null) {
          teacherInfo = state.myClassListDetail!.obj!.teacherInfo!;
        }
        setState(() {});
      }
    });
    logic.addListenerId(
        GetBuilderIds.getMyClassListDetail +
            widget.classId.toString() +
            (true).toString(), () {
      if (mounted &&
          state.myClassListDetail != null &&
          state.myClassListDetail!.obj != null) {
        print("班级数据===" + state.myClassListDetail!.obj!.name!);

        detailBean = state.myClassListDetail!.obj!;
        if (state.myClassListDetail!.obj!.teacherInfo != null) {
          teacherInfo = state.myClassListDetail!.obj!.teacherInfo!;
        }
        setState(() {});
      }
    });
    if (widget.classId != null && widget.classId!.isNotEmpty) {
      if (widget.isShowAdd == 1) {
        logic.getMyClassDetail(widget.classId.toString(),
            isTeacher: true, isJoin: true);
      } else {
        logic.getMyClassDetail(widget.classId.toString(),
            isTeacher: true, isJoin: false);
      }
    }
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
        Positioned(
            top: 116.w,
            child: detailBean == null || detailBean.name == null
                ? PlaceholderPage(
                    imageAsset: R.imagesCommenNoDate,
                    title: widget.classId != null && widget.classId!.isNotEmpty ? '识别错误':'未加入班级' ,
                    topMargin: 0.w,
                    subtitle: '')
                : ClassCard(
                    isShowAdd:
                        detailBean.isJoin != null ? !detailBean.isJoin! : false,
                    isShowRank: true,
                    className: detailBean.name!,
                    classImage: detailBean.image!,
                    studentUserId: SpUtil.getInt(BaseConstant.USER_ID),
                    classId: detailBean.id!,
                    studentSize: detailBean.studentSize!.toString(),
                    teacherName: teacherInfo.actualname ?? '',
                    teacherSex: TimeUtil.getSex(teacherInfo.sex),
                    teacherAge: TimeUtil.getTimeDay(
                        teacherInfo.teachingExperience ?? ''),
                    teacherConnect: teacherInfo.phone ?? ''))
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

  @override
  void onCreate() {}

  @override
  void dispose() {
    Get.delete<Class_messageLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {}
}
