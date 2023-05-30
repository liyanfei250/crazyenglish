import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import '../../base/widgetPage/dialog_manager.dart';
import '../../r.dart';
import '../../utils/text_util.dart';

class WritDialog extends Dialog {
  final String htmlContent;

  _showTimer(context) {
    var timer;
    timer = Timer.periodic(Duration(seconds: 10), (t) {
      print("关闭");
      Navigator.pop(context);
      timer.cancel();
    });
  }

  WritDialog(this.htmlContent);

  @override
  Widget build(BuildContext context) {
    //_showTimer(context);
    return Dialog(
        // insetPadding: EdgeInsets.all(10), //距离
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        //形状
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        //强制裁剪
        elevation: 10,
        child: Container(
          //需要在内部限制下高度和宽度才能更好的显示
          width: double.infinity,
          height: 400.w,
          padding: EdgeInsets.all(18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    R.imagesWritingLookBotton,
                    width: 77.w,
                    height: 18.w,
                  ),
                  Expanded(child: Text('')),
                  InkWell(
                      onTap: () {
                        //RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        R.imagesToridClose,
                        width: 12.w,
                        height: 12.w,
                      ))
                ],
              ),
              Expanded(
                  child: Scrollbar(
                      child: SelectionArea(
                child: SingleChildScrollView(
                  child: Html(
                    data: htmlContent ?? "",
                    onImageTap: (
                      url,
                      context,
                      attributes,
                      element,
                    ) {
                      if (url != null && url!.startsWith('http')) {
                        DialogManager.showPreViewImageDialog(
                            BackButtonBehavior.close, url);
                      }
                    },
                    style: {
                      "p": Style(fontSize: FontSize.large),
                      "sentence": Style(
                          textDecorationStyle: TextDecorationStyle.dashed,
                          textDecorationColor: AppColors.THEME_COLOR),
                      "hr": Style(
                        margin: Margins.only(
                            left: 0, right: 0, top: 10.w, bottom: 10.w),
                        padding: EdgeInsets.all(0),
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      )
                    },
                    tagsList: Html.tags..addAll(['sentence']),
                  ),
                ),
              )))

              /*Text(title,
                  style: TextStyle(
                      color: Color(0xff353e4d),
                      fontSize: 18.sp,
                      wordSpacing: 2.0,
                      fontWeight: FontWeight.w600,
                      height: 2),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5),
              Text(content,
                  style: TextStyle(
                      color: Color(0xff353e4d),
                      fontSize: 14.sp,
                      wordSpacing: 2.0,
                      height: 1.5),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5)*/
              ,
            ],
          ),
        ));
  }
}
