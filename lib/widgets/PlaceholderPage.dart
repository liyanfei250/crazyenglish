import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../r.dart';
//内容缺省页

class PlaceholderPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final double topMargin;
  final String subtitle;

  PlaceholderPage({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.topMargin,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16.0,top: topMargin,right: 16.0,bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            R.imagesCommenNoDate,
            height: 138.w,
            width: 138.w,
          ),
          SizedBox(height: 16.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff353E4D)
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xffd2d5dc),
            ),
          ),
        ],
      ),
    );
  }
}
