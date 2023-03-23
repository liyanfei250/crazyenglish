import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../r.dart';
import '../utils/colors.dart';
import 'ChoiceRadioItem.dart';

/**
 * Time: 2023/1/3 11:08
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class ChoiceImageItem extends StatelessWidget {

  String? labelValue;
  String? answerValue;
  String? img;
  double? width;
  double? height;

  ChoiceRadioItemType type = ChoiceRadioItemType.DEFAULT;




  ChoiceImageItem(
      this.type,
      this.answerValue,
      this.labelValue,
      this.img,
      this.width,
      this.height,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w,top: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelValue!,style: TextStyle(fontSize: 16.sp,color: AppColors.c_FF353E4D,fontWeight: FontWeight.w500),),
          Padding(padding: EdgeInsets.only(left: 7.w)),
          Container(
            decoration: getBorder(type),
            child: ExtendedImage.network(
              img??"",
              cacheRawData: true,
              width: this.width,
              height: this.height,
              fit: BoxFit.fill,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(13.w)),
              enableLoadState: true,
              loadStateChanged: (state){
                switch (state.extendedImageLoadState) {
                  case LoadState.completed:
                    return ExtendedRawImage(
                      image: state.extendedImageInfo?.image,
                      fit: BoxFit.cover,
                    );
                  default :
                    return Image.asset(
                      R.imagesReadingDefault,
                      fit: BoxFit.fill,
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration getBorder(ChoiceRadioItemType type){
    switch(type){
      case ChoiceRadioItemType.SELECTED:
        return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
          border: Border.all(
            color: AppColors.c_FF898A93,
            width: 2.w
          ),
        );
      default:
        return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13.w)),
          border: Border.all(
              color: Colors.transparent,
              width: 2.w
          ),
        );
    }
  }

}