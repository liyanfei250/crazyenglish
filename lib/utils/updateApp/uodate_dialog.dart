// import 'dart:io';
//
// import 'package:crazyenglish/bling/blingabc_router.dart';
// import 'package:crazyenglish/bling/route/bling_router.dart';
// import 'package:crazyenglish/page/setting/check_update_resp.dart';
// import 'package:crazyenglish/utils/Util.dart';
// import 'package:crazyenglish/utils/channel/kooielts_channel.dart';
// import 'package:crazyenglish/utils/colors.dart';
// import 'package:crazyenglish/utils/date_util.dart';
// import 'package:flutter/material.dart';
//
// ///description:版本更新提示弹窗
// class UpdateDialog extends Dialog {
//   final CheckUpdateResp upDateEntry;
//   final bool? isForce;
//
//   UpdateDialog({required this.upDateEntry, this.isForce});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 285,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               // width: 285,
//               height: 156,
//               child: Stack(
//                 children: [
//                   Image.asset(
//                     'images/bg_update_top.png',
//                     height: Util.setHeight(156) as double?,
//                     fit: BoxFit.cover,
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 22, top: 47.5),
//                     child: Text(
//                       '发现新版本',
//                       style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.white,
//                           decoration: TextDecoration.none),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 21.5, top: 86),
//                     child: Text(
//                       '新东方雅思',
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                           decoration: TextDecoration.none),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(color: Colors.white),
//               // width: 285,
//               height: 200,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 18, right: 18),
//                   child: Text(
//                     getUpdateContent(upDateEntry),
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black,
//                         decoration: TextDecoration.none),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               height: 46,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(8),
//                       bottomRight: Radius.circular(8))),
//               child: Row(
//                 children: [
//                   Expanded(
//                       flex: 1,
//                       child: Center(
//                         child: GestureDetector(
//                           behavior: HitTestBehavior.opaque,
//                           onTap: () {
//                             BlingabcRouter.pop(context);
//                           },
//                           child: Center(
//                             child: Text(
//                               "下次再说",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                   decoration: TextDecoration.none),
//                             ),
//                           ),
//                         ),
//                       )),
//                   VerticalDivider(
//                     width: Util.setWidth(0.5) as double?,
//                     color: AppColors.c_FFECECEC,
//                   ),
//                   Expanded(
//                       flex: 1,
//                       child: Center(
//                         child: GestureDetector(
//                           behavior: HitTestBehavior.opaque,
//                           onTap: () {
//                             BlingabcRouter.pop(context);
//                             if (Platform.isIOS) {
//                               KooIeltsChannel.instance.goAppStore();
//                             } else {
//                               // Util.toast("下载升级");
//                               KooIeltsChannel.instance.goAndroidUpdateApp(upDateEntry.appVersion!.lastVersion!, upDateEntry.appVersion!.downloadPath!);
//                             }
//                           },
//                           child: Center(
//                             child: Text(
//                               "立即更新",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: AppColors.c_FF11CA9C,
//                                   decoration: TextDecoration.none),
//                             ),
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 37,
//             ),
//             Center(
//               child: GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () {
//                   BlingabcRouter.pop(context);
//                 },
//                 child: Container(
//                   height: 34,
//                   width: 34,
//                   child: Image.asset(
//                     'images/icon_close_round_black.png',
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   static showUpdateDialog(
//       BuildContext context, CheckUpdateResp resp, bool mIsForce) {
//     return showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return WillPopScope(
//               child: UpdateDialog(
//                   upDateEntry:resp, isForce: mIsForce),
//               onWillPop: () async => false);
//         });
//   }
//
//   String getUpdateContent(CheckUpdateResp resp){
//       String updateContent = "";
//       updateContent += "版本号 ：" + resp.appVersion!.appVersionName!;
//       updateContent +=
//           "\n更新时间 ：" + DateUtil.formatDateMs(resp.appVersion!.publishDate);
//       updateContent += "\n更新说明 ：\n";
//       updateContent += resp.appVersion!.description!;
//       return updateContent;
//   }
// }
