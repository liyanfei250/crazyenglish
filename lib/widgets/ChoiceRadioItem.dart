import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../r.dart';
import '../utils/colors.dart';

/**
 * Time: 2023/1/3 11:08
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 默认 未选中，作答选中，反显正确，反显错误
 */
enum ChoiceRadioItemType {DEFAULT,SELECTED,RIGHT_SELECTED,WRONG_SELECTED}

class ChoiceRadioItem extends StatelessWidget {

  String? labelValue;
  String? answerValue;
  String? contentValue;
  double? width;
  double? height;

  ChoiceRadioItemType type = ChoiceRadioItemType.DEFAULT;




  ChoiceRadioItem(
      this.type,
      this.answerValue,
      this.labelValue,
      this.contentValue,
      this.width,
      this.height,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width??100,
      height: this.height,
      decoration: BoxDecoration(
        color: getBgColor(type),
        borderRadius: BorderRadius.all(Radius.circular(7.w)),
        border: Border.all(
          color: getBorderColor(type),
            width: type == ChoiceRadioItemType.DEFAULT? 1.w:0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(left: 18.w)),
              // Text(labelValue??"",
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: TextStyle(fontSize: 16.sp,color: AppColors.TEXT_BLACK_COLOR,fontWeight: FontWeight.bold),),
              // Padding(padding: EdgeInsets.only(left: 19.w)),
              Container(
                width: 218.w,
                child: Text(contentValue??"",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp,color: AppColors.TEXT_BLACK_COLOR,fontWeight: FontWeight.normal),),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                  visible: type == ChoiceRadioItemType.WRONG_SELECTED || type == ChoiceRadioItemType.RIGHT_SELECTED,
                  child: Image.asset(type == ChoiceRadioItemType.RIGHT_SELECTED ? R.imagesChoiceCorrect:R.imagesChoiceError,width: 24.w,height: 24.w,)),
              Padding(padding: EdgeInsets.only(right: 22.w))
            ],
          )
        ],
      ),
    );
  }

  Color getBgColor(ChoiceRadioItemType type){
    switch(type){
      case ChoiceRadioItemType.SELECTED:
        return AppColors.c_FFF5F7FB;
      case ChoiceRadioItemType.WRONG_SELECTED:
        return AppColors.c_FFFCF0E2;
      case ChoiceRadioItemType.RIGHT_SELECTED:
        return AppColors.c_FFE5F9DE;
      default:
        return AppColors.c_FFFFFFFF;
    }
  }

  Color getBorderColor(ChoiceRadioItemType type){
    switch(type){
      case ChoiceRadioItemType.SELECTED:
        return AppColors.c_FFD2D5DC;
      case ChoiceRadioItemType.WRONG_SELECTED:
        return AppColors.c_FFFCF0E2;
      case ChoiceRadioItemType.RIGHT_SELECTED:
        return AppColors.c_FFE5F9DE;
      default:
        return AppColors.c_FFEBEBEB;
    }
  }
}