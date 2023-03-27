import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import 'scan_audio_message_logic.dart';

class Scan_audio_messagePage extends BasePage {
  const Scan_audio_messagePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<Scan_audio_messagePage> {
  final logic = Get.put(Scan_audio_messageLogic());
  final state = Get.find<Scan_audio_messageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return _buildBgView(
        context); /*Scaffold(
      appBar: buildNormalAppBar("扫描结果"),
      backgroundColor: AppColors.theme_bg,
    );*/
  }

  Widget _buildBgView(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(R.imagesReviewTopBg), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Util.buildBackWidget(context),
            centerTitle: true,
            title: Text(
              "扫描结果",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Color(0xff353e4d)),
            ),
          ),
          SizedBox(
            height: 40.w,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                R.imagesShopImageLogoTest,
                width: 282.w,
                height: 282.w,
              )),
          SizedBox(
            height: 108.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.w, bottom: 22.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Module 1 Unit3",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: Color(0xff353e4d)),
              ),
            ),
          ),
          Container(
            color: Colors.yellow,
            width: 300.w,
            height: 45.w,
          ),
          SizedBox(
            height: 40.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  // 点击返回按钮的操作
                },
                child: Image.asset(
                  R.imagesScanResultBack15,
                  width: 42.w,
                  height: 42.w,
                ),
              ),
              InkWell(
                onTap: () {
                  // 点击暂停按钮的操作
                },
                child: Image.asset(
                  R.imagesScanResultSuspend,
                  width: 22.w,
                  height: 28.w,
                ),
              ),
              InkWell(
                onTap: () {
                  // 点击广播按钮的操作
                },
                child: Image.asset(
                  R.imagesScanResultBroadcast,
                  width: 22.w,
                  height: 28.w,
                ),
              ),
              InkWell(
                onTap: () {
                  // 点击快进按钮的操作
                },
                child: Image.asset(
                  R.imagesScanResultFast15,
                  width: 42.w,
                  height: 42.w,
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
