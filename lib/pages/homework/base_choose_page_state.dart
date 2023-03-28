import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
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
abstract class BaseChoosePageState<T extends BasePage,N> extends BasePageState<T> {

  List<N>? dataList;

  Map<String,bool> isSelectedMap = {};

  String getDataId(N n);

  var hasSelectedAllFlag = false.obs;

  var hasSelectedNum = 0.obs;

  void addSelected(N n,bool isSelected){
    if(!isSelected){
      hasSelectedAllFlag.value = false;
    }
    isSelectedMap[getDataId(n)] = isSelected;
    hasSelectedNum.value = countSelectedNum();
  }

  int countSelectedNum(){
    int totalNum = 0;
    for(N n in dataList!){
      String id = getDataId(n);
      if(isSelectedMap.containsKey(id) && isSelectedMap[id]!){
        totalNum+1;
      }
    }
    return totalNum;
  }

  bool isDataSelected(N n){
    String id = getDataId(n);
    if(isSelectedMap.containsKey(id)){
      return isSelectedMap[id]??false;
    }else{
      return false;
    }
  }

  bool hasSelectedAll(){
    for(N n in dataList!){
      String id = getDataId(n);
      if(isSelectedMap.containsKey(id) && !isSelectedMap[id]!){
        hasSelectedAllFlag.value = false;
        return false;
      }
    }
    hasSelectedAllFlag.value = true;
    return true;
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
          Util.buildHomeworkNormalBtn(() { }, "完成")
        ],
      ),
    );
  }
}
