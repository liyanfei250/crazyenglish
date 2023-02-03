import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../utils/colors.dart';
import '../../widgets/swiper.dart';

/**
 * Time: 2023/1/4 15:38
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class TORID_Widget extends StatefulWidget {
  const TORID_Widget({Key? key}) : super(key: key);

  @override
  State<TORID_Widget> createState() => _TORID_WidgetState();
}

class _TORID_WidgetState extends State<TORID_Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(R.imagesToridTixing,width: 20.w,height: 20.w,),
                    Padding(padding: EdgeInsets.only(left: 8.w)),
                    Text("TORID主题四大象限你知道吗？",style: TextStyle(fontSize: 16.sp,color: AppColors.TEXT_BLACK_COLOR),),
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: (){
                      BotToast.cleanAll();
                    },
                    child: Container(
                      width: 22.w,
                      height: 22.w,
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(R.imagesToridClose,width: 12.w,height: 12.w,),
                    ),
                  ))
            ],
          ),
          adsBanner
        ],
      ),
    );
  }


  Widget get adsBanner {
    return Container(
      width: 295.w,
      height: 285.w,
      child: Swiper(
          autoStart: false,
          circular: true,
          indicator: CustomSwiperIndicator(
            spacing: 4.w,
            // radius: 4.0,
            padding: EdgeInsets.only(bottom: 0.w),
            // itemColor: AppColors.c_FFC2BFC2,
            // itemActiveColor: AppColors.c_FF11CA9C
            normalHeight: 8.w,
            normalWidth: 8.w,
            noralBoxDecoration: BoxDecoration(
                color: AppColors.c_FFD9D9D9, shape: BoxShape.circle),
            selectHeight: 8.w,
            selectWidth: 8.w,
            selectBoxDecoration: BoxDecoration(
                color: AppColors.c_FFFFBC00, shape: BoxShape.circle),
          ),
          indicatorAlignment: AlignmentDirectional.bottomCenter,
          children: makeBanner()),
    );
  }

  ///banner条目适配器
  List<Widget> makeBanner() {
    List<Widget> items = [];
    items.add(makeTORID_FIST());
    items.add(makeTORID_SECOND());
    return items;
  }

  Widget makeTORID_FIST(){
    var oneEye = true.obs;
    var twoEye = true.obs;
    var threeEye = true.obs;
    var fourEye = true.obs;
    var fiveEye = true.obs;

    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Obx(() => GestureDetector(
                    onTap: (){
                      twoEye.value = !twoEye.value;
                    },
                    child: Image.asset(twoEye.value? R.imagesToridTwoHide:R.imagesToridTwoShow,width: 132.w,height: 81.w,),
                  )),
                  Container(
                    height: 30.w,
                    alignment: Alignment.topLeft,
                    child: Image.asset(R.imagesToridTop,width: 28.w,height: 17.w,),
                  ),
                  Obx(() => GestureDetector(
                    onTap: (){
                      threeEye.value = !threeEye.value;
                    },
                    child: Image.asset(threeEye.value? R.imagesToridThreeHide:R.imagesToridThreeShow,width: 132.w,height: 81.w,),
                  )),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 7.w)),
              Obx(() => GestureDetector(
                onTap: (){
                  oneEye.value = !oneEye.value;
                },
                child: Image.asset(oneEye.value? R.imagesToridOneHide:R.imagesToridOneShow,width: 144.w,height: 55.w,),
              )),
              Padding(padding: EdgeInsets.only(top: 7.w)),
              Row(
                children: [
                  Obx(() => GestureDetector(
                    onTap: (){
                      fiveEye.value = !fiveEye.value;
                    },
                    child: Image.asset(fiveEye.value? R.imagesToridFiveHide:R.imagesToridFiveShow,width: 132.w,height: 81.w,),
                  )),
                  Container(
                    height: 40.w,
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(R.imagesToridBottom,width: 28.w,height: 17.w,),
                  ),
                  Obx(() => GestureDetector(
                    onTap: (){
                      fourEye.value = !fourEye.value;
                    },
                    child: Image.asset(fourEye.value? R.imagesToridFourHide:R.imagesToridFourShow,width: 132.w,height: 81.w,),
                  )),
                ],
              ),
            ],
          ),
          Positioned(
            top: 70.w,
            left: 40.w,
            child: Image.asset(R.imagesToridLeft,width: 24.w,height: 43.w,),),
          Positioned(
            top: 70.w,
            right: 40.w,
            child: Image.asset(R.imagesToridRight,width: 14.w,height: 96.w,),),



        ],
      ),
    );
  }
  Widget makeTORID_SECOND(){
    return Container(
      child: Image.asset(R.imagesToridSecond),
    );
  }
}
