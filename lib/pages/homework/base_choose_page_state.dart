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

  // {key,List<N>} key是tab分类：班级、期刊等
  Map<String,List<N>?> dataList = {};

  // {key,{id,bool}}  key是tab分类：班级、期刊等；id 是学生、习题等id
  Map<String,Map<String,bool>> isSelectedMap = {};

  // key
  String getDataId(String key,N n);

  // 切换key时 需要更新此字段
  var hasSelectedAllFlag = false.obs;

  var hasSelectedNum = 0.obs;

  void addSelected(String key,N n,bool isSelected){
    if(!isSelected){
      hasSelectedAllFlag.value = false;
    }
    if(isSelectedMap[key]==null){
      isSelectedMap[key] = {};
    }
    isSelectedMap[key]![getDataId(key,n)] = isSelected;
    hasSelectedNum.value = countSelectedNum();
  }

  int countSelectedNum(){
    int totalNum = 0;
    dataList.forEach((key, value) {
      if(value!=null){
        for(N n in value!){
          String id = getDataId(key,n);
          if(isSelectedMap[key]!=null && (isSelectedMap[key]![id]??false)){
            totalNum+1;
          }
        }
      }
    });

    return totalNum;
  }

  bool isDataSelected(String key,N n){
    String id = getDataId(key,n);
    if(isSelectedMap.containsKey(key) && isSelectedMap[key]!.containsKey(id)){
      return isSelectedMap[key]![id]??false;
    }else{
      return false;
    }
  }

  bool hasSelectedAll(String key){
    if(dataList.containsKey(key)
        && dataList[key]!.length>0){
      List<N> datas = dataList[key]!;
      for(N n in datas!){
        String id = getDataId(key,n);
        if(!isSelectedMap.containsKey(key)
            || !isSelectedMap[key]!.containsKey(id)
            || (isSelectedMap[key]![id]??false)
        ){
          hasSelectedAllFlag.value = false;
          return false;
        }
      }
      hasSelectedAllFlag.value = true;
      return true;
    }else{
      return false;
    }

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
