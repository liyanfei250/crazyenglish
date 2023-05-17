import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/entity/login/login_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tencent_cos/tencent_cos.dart';

import '../../base/common.dart';
import '../../base/widgetPage/dialog_manager.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/sp_util.dart';
import '../../widgets/image_picker.dart';
import 'image_get_widget_logic.dart';

class ImageGetWidgetPage extends StatefulWidget {
  String imageKey;
  String? imageUrl;
  Function(String imgUrl) callback;
  bool Function() isEditCallback;
  bool is4x1Picture  = false;
  ImageGetWidgetPage(this.imageKey,this.imageUrl,this.callback,this.isEditCallback,{Key? key}) : super(key: key);

  @override
  _ImageGetWidgetPageState createState() => _ImageGetWidgetPageState();
}

class _ImageGetWidgetPageState extends State<ImageGetWidgetPage> {
  final logic = Get.put(ImageGetWidgetLogic());
  final state = Get.find<ImageGetWidgetLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageGetWidgetLogic>(
      id:widget.imageKey,
      builder: (logic){
        if(state.imageQcloudUrl[widget.imageKey]!=null){
          if(state.imageQcloudUrl[widget.imageKey]!.startsWith(SnsLoginUtil.QCloud_domain)){
            String imageUrl = state.imageQcloudUrl[widget.imageKey]!;
            widget.callback(imageUrl);
          }else{
            String imageUrl = SnsLoginUtil.QCloud_domain+state.imageQcloudUrl[widget.imageKey]!;
            widget.callback(imageUrl);
          }
        }
        return ImagePickerUtils.imagePicker(
          width: widget.is4x1Picture? 360.w:90.w,
          height: widget.is4x1Picture? 90.w:90.w,
            widget.imageKey,
            (value) {
              if(widget.isEditCallback.call()){
                logic.showSelectImageDialog(context, widget.imageKey,widget.is4x1Picture);
              }else{
                if(state.imageQcloudUrl[widget.imageKey]!=null){
                  DialogManager.showPreViewImageDialog(
                      BackButtonBehavior.close,
                      (state.imageQcloudUrl[widget.imageKey]!.startsWith(SnsLoginUtil.QCloud_path)?
                      (SnsLoginUtil.QCloud_domain+state.imageQcloudUrl[widget.imageKey]!)
                          :state.imageQcloudUrl[widget.imageKey]!)
                  );
                }else if(widget.imageUrl!=null){
                  DialogManager.showPreViewImageDialog(
                      BackButtonBehavior.close, widget.imageUrl!);
                }
              }

            },
            imageUrl: widget.imageUrl,
            imageQcloudUrl: state.imageQcloudUrl[widget.imageKey],
            isUploading: state.imageIsUploading[widget.imageKey],
            isUploaded: state.imageIsUploaded[widget.imageKey],
            imageFile: (state.imageFile[widget.imageKey]) !=null
                && (state.imageFile[widget.imageKey]!).isNotEmpty ?
                    File(state.imageFile[widget.imageKey]!):null);
      },
    );
  }

  @override
  void dispose() {
    Get.delete<ImageGetWidgetLogic>();
    super.dispose();
  }


}