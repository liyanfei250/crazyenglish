import 'dart:collection';
import 'dart:io';

import 'package:get/get.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

///description:请求权限
// ignore: must_be_immutable
class RequestPermissionsDialog extends Dialog {
  String content;

  LinkedHashMap<String, String> items;

  ClickNextCallback? onNext;

  RequestPermissionsDialog(
      {required this.content, required this.items, this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 20.h),
        width: 280,
        // constraints: BoxConstraints(maxHeight: 400.h,minHeight: 302.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ///标题
            // Text(
            //   "权限申请",
            //   style: TextStyle(
            //       decoration: TextDecoration.none,
            //       fontSize: 16.sp,
            //       color: AppColors.c_FF32374E,
            //       fontWeight: FontWeight.bold),
            // ),

            ///中间图片条目
            Padding(
              padding: EdgeInsets.only(top:28.w,bottom: 20.h),
              child: Container(
                height: 84.h,
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    return Container(
                      padding: EdgeInsets.only(
                        left: i == 0 ? 0 : 20.w,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            items.values.toList()[i],
                            width: 70.w,
                            height: 70.w,
                          ),
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            ///文字描述
            Padding(
              padding: EdgeInsets.fromLTRB(0, 24.h, 0, 30.h),
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 16.sp,
                    decoration: TextDecoration.none,
                    color: AppColors.c_FF32374E),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 78.w,minHeight: 32.w),
                    child:Container(
                      alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffdfe2e9),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: Color(0xff353e4d),
                            fontSize: 16.sp,
                          ),
                        )
                    )
                    ,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    if (onNext != null) {
                      onNext!();
                    }
                  },
                  child:ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 78.w,minHeight: 32.w),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xfff19e59),
                                Color(0xffec5f2a),
                              ]),
                          color: AppColors.THEME_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(17))),
                      child: Center(
                        child: Text(
                          "去设置",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: AppColors.c_FFFFFFFF,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ) ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///下一步回掉
typedef ClickNextCallback = void Function();
