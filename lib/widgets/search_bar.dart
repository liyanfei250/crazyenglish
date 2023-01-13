import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../r.dart';

/**
 * Time: 2023/1/3 20:29
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class SearchBar extends StatelessWidget {
  String? hintContent = "请输入关键词搜索";
  double height;
  double width;
  SearchBar({Key? key,this.hintContent="请输入关键词搜索",required this.width,required  this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFFFF,
        borderRadius: BorderRadius.all(Radius.circular(6.w))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(left: 7.w)),
          Image.asset(R.imagesHomeSearch,width: 18.w,height: 18.w,),
          Padding(padding: EdgeInsets.only(left: 6.w)),
          Text(hintContent??"",style: TextStyle(fontSize: 14.sp,color: AppColors.TEXT_GRAY_COLOR),)
        ],
      ),
    );
  }
}
