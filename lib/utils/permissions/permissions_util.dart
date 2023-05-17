import 'dart:collection';
import 'dart:io';

import 'package:crazyenglish/utils/permissions/request_prermissions_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../r.dart';



class PermissionsUtil {
  // static const String PERMISSIONS_KEY_STORE = "permissions_key_store";
  //
  // ///录音
  // static const String PERMISSIONS_KEY_RECORD = "permissions_key_record";
  //
  // ///照相机
  // static const String PERMISSIONS_KEY_CAMERA = "permissions_key_camera";

  static checkPermissions(
     BuildContext context, String content, List<RequestPermissionsTag> list,PermissionGrantedCallback grantedCallback
  ) async {
    if(Platform.isAndroid){
      bool needShow = false;
      for(RequestPermissionsTag tag in list){
        Permission permission = getRealPermission(tag);
        PermissionStatus status = await permission.status;
        if(!status.isGranted){
          //有一项不允许就弹窗
          needShow = true;
        }
        break;
      }
      if(needShow){
        //
        showUpdateDialog(context, content, list);
      }else{
        grantedCallback();
      }
    }else{
      grantedCallback();
    }



  }

  static showUpdateDialog(
      BuildContext context, String content, List<RequestPermissionsTag> tagList) {
    LinkedHashMap<String,String> iconMap = new LinkedHashMap();
    tagList.forEach((p) {
      var key = getNameText(p);
      var value = getImageUrl(p);
      iconMap[key] = value;
    });
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              child: RequestPermissionsDialog(
                content: content,
                items: iconMap,
                onNext: (){
                  if(tagList.length>0){
                    tagList.forEach((element) async {
                      ///循环请求权限
                      Permission p = getRealPermission(element);
                      PermissionStatus status = await p.request();
                      if(status.isGranted){

                      }
                    });
                  }
                },
              ),
              onWillPop: () async => true);
        });
  }

  static checkPermissionCell(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      //权限通过
    } else if (status.isDenied) {
      //权限拒绝， 需要区分IOS和Android，二者不一样
      // requestPermission(permission);
    } else if (status.isPermanentlyDenied) {
      //权限永久拒绝，且不在提示，需要进入设置界面，IOS和Android不同
      openAppSettings();
    } else if (status.isRestricted) {
      //活动限制（例如，设置了家长///控件，仅在iOS以上受支持。
      openAppSettings();
    } else {
      //第一次申请
      // requestPermission(permission);
    }
  }

  static String getImageUrl(RequestPermissionsTag permissionsTag) {

    switch (permissionsTag) {
    case RequestPermissionsTag.PHOTOS:
      return R.imagesIconPermissionsStore;
    case RequestPermissionsTag.RECORD_AUDIO:
      return R.imagesIconPermissionsRecord;
    case RequestPermissionsTag.CAMERA:
      return R.imagesIconPermissionsCamera;
      default:
        return "";
    }
  }
  static String getNameText(RequestPermissionsTag permissionsTag) {
    switch (permissionsTag) {
      case RequestPermissionsTag.PHOTOS:
        return "存储";
      case RequestPermissionsTag.RECORD_AUDIO:
        return "录音";
      case RequestPermissionsTag.CAMERA:
        return "照相机";
      default:
    return "";
    }
  }

  static Permission getRealPermission(RequestPermissionsTag tag){

    if (Platform.isAndroid) {
      switch (tag){
        case RequestPermissionsTag.PHOTOS:
          return Permission.storage;
         case RequestPermissionsTag.CAMERA:
          return Permission.camera;
         case RequestPermissionsTag.RECORD_AUDIO:
          return Permission.microphone;

      }
    }else if (Platform.isIOS){
      switch (tag){
        case RequestPermissionsTag.PHOTOS:
          return Permission.photos;
        case RequestPermissionsTag.CAMERA:
          return Permission.camera;
        case RequestPermissionsTag.RECORD_AUDIO:
          return Permission.microphone;

      }
    }



    return Permission.photos;
  }

}
typedef PermissionGrantedCallback = void Function();

enum RequestPermissionsTag {
  ///相册
  ///Android:照片与文件
  ///IOS:相册
  PHOTOS,

  ///录音
  ///Android:录音
  ///IOS:录音
  RECORD_AUDIO,

  ///照相机
  ///Android:照相机
  ///IOS:照相机
  CAMERA,
}