import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/config.dart';
import 'package:crazyenglish/entity/login/login_util.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tencent_cos/tencent_cos.dart';

import '../../base/widgetPage/dialog_manager.dart';
import '../../utils/permissions/permissions_util.dart';
import 'image_get_widget_state.dart';

class ImageGetWidgetLogic extends GetxController {
  final ImageGetWidgetState state = ImageGetWidgetState();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  void showSelectImageDialog(BuildContext context,String key, bool is4x1Picture) async{
    DialogManager.showSelectPickerDialog(
        BackButtonBehavior.close,
        takePhotoCallback: () {
          PermissionsUtil.checkPermissions(
              context,
              "相册没有权限，请在设置-数字英语中打开相册",
              [RequestPermissionsTag.CAMERA], () {
            ImagePicker _picker = ImagePicker();
            // Pick an image
            _picker
                .pickImage(source: ImageSource.camera)
                .then((xFile) async {
              if (xFile != null) {
                // _cancelLoading = BotToast.showLoading();
                // updateHeadImage(xFile);
                String pickPath = xFile.path;
                CroppedFile? croppedFile = await Util.crop(pickPath,is4x1Picture);
                if(croppedFile==null){
                  Util.toast("裁剪图片错误");
                  return;
                }
                String path = croppedFile.path;
                state.imageFile.addAll({key:path});
                state.imageIsUploading.addAll({key:true});
                update([key]);
                var name = path.substring(path.lastIndexOf("/") + 1, path.length);
                String cosPath =
                    "${SnsLoginUtil.QCloud_path}${SpUtil.getString(BaseConstant.userId)}/$key$name";
                String? response = await COSClient(COSConfig(
                  SnsLoginUtil.QCloud_secretId,
                  SnsLoginUtil.QCloud_secretKey,
                  Config.bucket_NAME,
                  SnsLoginUtil.QCloud_region,
                )).putObject(
                    cosPath,
                  croppedFile.path,);
                if(response == cosPath){
                  state.imageQcloudUrl.addAll({key:cosPath});
                  state.imageIsUploading.addAll({key:false});
                  state.imageIsUploaded.addAll({key:true});
                }else{
                  state.imageIsUploading.addAll({key:false});
                  state.imageIsUploaded.addAll({key:false});
                }
                update([key]);
                // BlocProvider.of<UserInfoBloc>(context)
                //     .add(new ModifyHeadImageEvent(
                //         imageFile: xFile));
              }
            });
          });
        }, fromAlbumCallback: () {
      PermissionsUtil.checkPermissions(
          context,
          "为了正常访问相册，需要您授权以下权限",
          [RequestPermissionsTag.PHOTOS], () {
        ImagePicker _picker = ImagePicker();
        // Pick an image
        _picker
            .pickImage(source: ImageSource.gallery)
            .then((xFile) async {
          if (xFile != null) {
            String pickPath = xFile.path;
            CroppedFile? croppedFile = await Util.crop(pickPath,is4x1Picture);
            if(croppedFile==null){
              Util.toast("裁剪图片错误");
              return;
            }
            String path = croppedFile.path;
            state.imageFile.addAll({key:path});
            state.imageIsUploading.addAll({key:true});
            update([key]);
            var name = path.substring(path.lastIndexOf("/") + 1, path.length);
            String cosPath =
                "${SnsLoginUtil.QCloud_path}${SpUtil.getInt(BaseConstant.USER_ID)}/$key$name";
            String? response;
            try{
              response = await COSClient(COSConfig(
                SnsLoginUtil.QCloud_secretId,
                SnsLoginUtil.QCloud_secretKey,
                Config.bucket_NAME,
                SnsLoginUtil.QCloud_region,
              )).putObject(
                cosPath,
                croppedFile.path,);
            }catch(e){
              print(e);
            }
            state.imageIsUploading.addAll({key:false});
            if(response == cosPath){
              state.imageQcloudUrl.addAll({key:cosPath});
              state.imageIsUploaded.addAll({key:true});
            }else{
              state.imageIsUploaded.addAll({key:false});
            }
            update([key]);
          }
        });
      });
    }, cancelCallback: () {
      BotToast.showText(text: "取消");
    });
  }
}
