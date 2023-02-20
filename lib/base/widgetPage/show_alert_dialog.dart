import 'dart:async';

import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';

import '../AppUtil.dart';
import 'dialog_manager.dart';

class ShowAlertDialog extends StatefulWidget {
  // 内容区域布局
  TextAlign contentAlign;

  String? title;

  String? content;
  // 点击返回index 0 1
  // OkDialogCallBack onOkTap;
  // CancelDialogCallBack onCancelTap;

  String? cancelTxt;
  String? okTxt;
  VoidCallback? okVoidCallback;
  VoidCallback? cancelVoidCallback;
  TextAlign textAlign;

  ShowAlertDialog({
    this.contentAlign = TextAlign.left,
    this.content,
    this.title,
    this.cancelTxt,
    this.okTxt,
    this.okVoidCallback,
    this.cancelVoidCallback,
    this.textAlign = TextAlign.start,
  });

  @override
  _ShowAlertDialogState createState() => _ShowAlertDialogState();
}

class _ShowAlertDialogState extends State<ShowAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        // ClipRRect 创建圆角矩形 要不然发现下边button不是圆角
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: AppColors.c_FFFFFFFF,
            width: Util.setWidth(260) as double?,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: Util.setWidth(10) as double?),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    widget.content!,
                    textAlign:widget.textAlign,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Util.setSP(14) as double?,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.c_FFEEEEEE,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
      behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.cancelVoidCallback!();
                        },
                        child: Container(
                          height: Util.setWidth(44) as double?,
                          alignment: Alignment.center,
                          child: Text(
                            widget.cancelTxt!,
                            style: TextStyle(
                                color: AppColors.c_FF959BA0,
                                fontSize: Util.setSP(15) as double?),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: AppColors.c_FFEEEEEE,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
      behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.okVoidCallback!();
                        },
                        child: Container(
                          height: Util.setWidth(44) as double?,
                          alignment: Alignment.center,
                          child: Text(
                            widget.okTxt!,
                            style: TextStyle(
                                color: AppColors.THEME_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: Util.setSP(15) as double?),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: AppColors.c_FFEEEEEE,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}