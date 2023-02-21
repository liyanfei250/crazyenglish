import 'dart:async';

import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import 'listen_practise_logic.dart';

class ListenPractisePage extends BasePage {
  const ListenPractisePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _ListenPractisePageState();
  }


}

class _ListenPractisePageState extends BasePageState<ListenPractisePage> {
  final logic = Get.put(ListenPractiseLogic());
  final state = Get.find<ListenPractiseLogic>().state;

  bool isCountTime = true;
  late Timer _timer;
  var countTime = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("标题",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp,fontWeight: FontWeight.bold),),
        leading: Util.buildBackWidget(context),
        actions: [
          Visibility(
            visible: isCountTime,
            child: Row(
              children: [
                Image.asset(R.imagesPractiseCountTimeIcon,width: 18.w,height: 18.w,),
                Obx(()=>Text("$countTime"))
              ],
          ))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Column(

          )),
          Container(
            margin: EdgeInsets.only(left: 66.w,right: 66.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Image.asset(R.imagesPractisePreQuestionEnable,width: 40.w,height: 40.w,),
                ),
                Text(
                  "1/5",
                  style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold,color: AppColors.c_FF353E4D),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Image.asset(R.imagesPractisePreQuestionEnable,width: 40.w,height: 40.w,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    startTimer();
  }

  startTimer(){
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      countTime++;
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }


  @override
  void onDestroy() {
    cancelTimer();
    Get.delete<ListenPractiseLogic>();
  }
}