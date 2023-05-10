import 'dart:math';

import 'package:crazyenglish/utils/MyImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/common.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../utils/sp_util.dart';
import '../../widgets/PlaceholderPage.dart';
import '../mine/class_page_card/class_page_card_view.dart';
import 'class_message_logic.dart';
import '../../entity/class_detail_response.dart';

class Class_messagePage extends BasePage {
  int? isShowAdd;
  String? classId;

  // bool? isStudent;
  // bool? isAdd;

  Class_messagePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isShowAdd = Get.arguments['isShowAdd'];
      classId = Get.arguments['classId'];
      //todo 学生进去的逻辑处理  1.查看自己是否已经加入，加入不显示“加入班级”按钮，2.显示讲师的数据；3.加入班级的按钮接口处理；
      // isStudent = Get.arguments['isStudent'];
      // isAdd = Get.arguments['isAdd'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToClassMessagePageState();
}

class _ToClassMessagePageState extends BasePageState<Class_messagePage> {
  final logic = Get.put(Class_messageLogic());
  final state = Get.find<Class_messageLogic>().state;
  late Obj detailBean = Obj();

  @override
  void initState() {
    super.initState();

    logic.addListenerId(
        GetBuilderIds.getMyClassListDetail + widget.classId.toString(), () {
      if (state.myClassListDetail != null &&
          state.myClassListDetail!.obj != null) {
        print("班级数据===" + state.myClassListDetail!.obj!.name!);

        detailBean = state.myClassListDetail!.obj!;
        setState(() {});
      }
    });

    logic.getMyClassDetail(widget.classId.toString());
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
            child: detailBean == null||detailBean.name==null
                ? PlaceholderPage(
                imageAsset: R.imagesCommenNoDate,
                title: '识别错误',
                topMargin: 0.w,
                subtitle: '')
                : ClassCard(
                    isShowAdd: widget.isShowAdd == 1,
                    isShowRank: true,
                    className: detailBean.name!,
                    classImage: detailBean.image!,
                    classId: detailBean.id!,
                    studentSize: detailBean.studentSize!.toString(),
                    teacherName: SpUtil.getString(BaseConstant.TEACHER_NAME),
                    teacherSex: SpUtil.getString(BaseConstant.TEACHER_SEX),
                    teacherAge: SpUtil.getString(BaseConstant.TEACHER_AGE),
                    teacherConnect:
                        SpUtil.getString(BaseConstant.TEACHER_PHONE)))
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
  void onDestroy() {}
}
