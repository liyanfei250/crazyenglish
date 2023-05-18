
import 'dart:io';

import 'package:crazyenglish/r.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

/**
 * Time: 2022/10/24 09:12
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class ImagePickerUtils{
  static Widget imagePicker(
      bool isHeadImg,
      String formKey,
      ValueChanged<String> onTapped, {
        File? imageFile,
        String? imageUrl,
        String? imageQcloudUrl,
        bool? isUploading,
        bool? isUploaded,
        double width = 90.0,
        double height = 90.0,

      }) {
    return GestureDetector(
      child: isHeadImg? ClipOval(
        child: _getImageWidget(imageFile,imageUrl,imageQcloudUrl,isUploading,isUploaded, width, height),
      ):Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(width: 0.5, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        width: width,
        height: height,
        child: _getImageWidget(imageFile,imageUrl,imageQcloudUrl,isUploading,isUploaded, width, height),
      ),
      onTap: () {
        onTapped("");
      },
    );
  }

  static Widget _getImageWidget(File? imageFile,String? imageUrl,
      String? imageQcloudUrl,bool? isUploading,bool? isUploaded, double width, double height) {
    //
    if (imageFile != null) {

      return Stack(
        children: [
          ExtendedImage.file(
            imageFile,
            fit:BoxFit.fill,
            width: width,
            height: height,),
          Offstage(
            offstage: (isUploaded??false)&& !(isUploading??true),
            child: Container(
              color: Colors.black38,
              alignment: Alignment.center,
              width: width,
              height: height,
              child: Text(
                (isUploading??true)? "上传中": (isUploaded??false)? "逻辑错误":"上传失败",
                style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 13.sp),),
            ),
          )
        ],
      );
    }

    if (imageUrl != null) {
      return ExtendedImage.network(
        loadStateChanged:(ExtendedImageState state){
          if(state.extendedImageLoadState == LoadState.failed) {
            return const Icon(Icons.add_photo_alternate);
          }
        },
        fit:BoxFit.fill,
        imageUrl?? "",
        width: width,
        height: height,);
    }

    return Image.asset(
      R.imagesIconHomeMeDefaultHead,
      fit: BoxFit.fill,
    );
  }
}