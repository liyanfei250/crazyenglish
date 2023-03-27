import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/colors.dart';

/**
 * Time: 2023/3/27 08:47
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 作业相关相似页面 复用UI组件
 */
abstract class BaseHomeworkPageState<T extends BasePage> extends BasePageState<T> {

  Widget buildTipsWidget(String text){
    return  Stack(
      children: [
        Container(
          height: 17.w,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.c_FFFCEFD8,width: 5.w,))
          ),
          child: Text("${text}",style: TextStyle(color: Colors.transparent)),
        ),
        Container(
          height: 17.w,
          child: Text("${text} :",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 12.sp,fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }

  Widget buildHomeworkNormalBtn(GestureTapCallback callback,String text,{bool enable = true}){
    return InkWell(
      onTap: (){
        callback??callback.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        height: 28.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                enable? Color(0xfff19e59):Color(0x80f19e59),
                enable? Color(0xffec5f2a):Color(0x80ec5f2a),
              ]),
          borderRadius: BorderRadius.all(Radius.circular(16.5.w)),
          boxShadow:[
            BoxShadow(
              color: Color(0xffee754f).withOpacity(0.25),		// 阴影的颜色
              offset: Offset(0.w, 4.w),						// 阴影与容器的距离
              blurRadius: 8.w,							// 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0.w,
            ),
          ],
        ),
        child: Text("$text",style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget buildCheckBox(GestureTapCallback callback,{bool chooseEnable = true}){
    return InkWell(
      onTap: () {
        callback.call();
      },
      child: Container(
        width: 16.w,
        height: 16.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff19e59),
                Color(0xffec5f2a),
              ]),
          borderRadius: BorderRadius.all(Radius.circular(6.w)),
          boxShadow:[
            BoxShadow(
              color: Color(0xffee754f).withOpacity(0.25),		// 阴影的颜色
              offset: Offset(0.w, 4.w),						// 阴影与容器的距离
              blurRadius: 6.w,							// 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0.w,
            ),
          ],
        ),
        child: Visibility(
          visible: chooseEnable,
          child: Image.asset(
            R.imagesIconChooseCenter,
            width: 12.w,
            height: 12.w,
          ),
        ),
      ),
    );
  }

  Widget buildBottomWidget(){
    return Container(
      margin: EdgeInsets.only(left: 53.w,bottom: 30.w,right: 58.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("全选",style: TextStyle(color: AppColors.c_FFED702D,fontSize: 12.sp,fontWeight: FontWeight.w500),),
              Padding(padding: EdgeInsets.only(left: 36.w)),
              Text("已选",style: TextStyle(color: AppColors.c_FFED702D,fontSize: 12.sp,fontWeight: FontWeight.w500),),
            ],
          ),
          buildHomeworkNormalBtn(() { }, "完成")
        ],
      ),
    );
  }
}
