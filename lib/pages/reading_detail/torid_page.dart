import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Row(
            children: [
              Image.asset(R.imagesToridTixing,width: 20.w,height: 20.w,),
              Text("TORID主题四大象限你知道吗？",style: TextStyle(fontSize: 16.sp,color: AppColors.THEME_HALF_COLOR),),
            ],
          ),
        ],
      ),
    );
  }


  Widget get adsBanner {
    return Swiper(
        autoStart: true,
        circular: true,
        indicator: CustomSwiperIndicator(
          spacing: 4.w,
          // radius: 4.0,
          padding: EdgeInsets.only(bottom: 23.w),
          // itemColor: AppColors.c_FFC2BFC2,
          // itemActiveColor: AppColors.c_FF11CA9C
          normalHeight: 3.w,
          normalWidth: 3.w,
          noralBoxDecoration: BoxDecoration(
              color: AppColors.c_FFFFBC00, shape: BoxShape.circle),
          selectHeight: 3.w,
          selectWidth: 12.w,
          selectBoxDecoration: BoxDecoration(
              color: AppColors.THEME_COLOR,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                  Radius.circular(3.w))),
        ),
        indicatorAlignment: AlignmentDirectional.bottomCenter,
        children: makeBanner());
  }

  ///banner条目适配器
  List<Widget> makeBanner() {
    List<Widget> items = [];
    items.add(Container(

    ));
    return items;
  }

}
