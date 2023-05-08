import 'dart:math';

import 'package:crazyenglish/utils/MyImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../mine/class_page_card/class_page_card_view.dart';
import 'class_message_logic.dart';

class Class_messagePage extends BasePage {
  int? isShowAdd;

  Class_messagePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isShowAdd = Get.arguments['isShowAdd'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToClassMessagePageState();
}

class _ToClassMessagePageState extends BasePageState<Class_messagePage> {
  final logic = Get.put(Class_messageLogic());
  final state = Get.find<Class_messageLogic>().state;

  @override
  void initState() {
    super.initState();
    logic.getClassInfo();
    logic.addListenerId(GetBuilderIds.getHomeScanDate, () {
      if (state.paperDetail != null) {
        /*paperDetail = state.paperDetail;
        if(mounted && _refreshController!=null){
          if(paperDetail!.data!=null
              && paperDetail!.data!.videoFile!=null
              && paperDetail!.data!.videoFile!.isNotEmpty){
          }
          if(paperDetail!.data!=null
              && paperDetail!.data!.audioFile!=null
              && paperDetail!.data!.audioFile!.isNotEmpty){

          }
          setState(() {
          });
        }*/

      }
    });
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
        Positioned(top: 116.w, child: ClassCard())
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
