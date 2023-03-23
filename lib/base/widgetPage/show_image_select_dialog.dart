import 'dart:async';

import 'package:crazyenglish/base/widgetPage/show_alert_dialog.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';

import 'dialog_manager.dart';

class ShowImageSelectDialog extends StatefulWidget {
  final VoidCallback? takePhotoCallback;
  final VoidCallback? fromAlbumCallback;
  final VoidCallback? cancelCallback;

  ShowImageSelectDialog(
      {this.takePhotoCallback, this.fromAlbumCallback, this.cancelCallback});

  @override
  _ShowImageSelectDialogState createState() => _ShowImageSelectDialogState();
}

class _ShowImageSelectDialogState extends State<ShowImageSelectDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.takePhotoCallback!();
                      },
                      child: Container(
                          width: double.infinity,
                          height: 49,
                          margin: EdgeInsets.only(left: 16, top: 10, right: 16),
                          alignment: Alignment.center,
                          child: Text(
                            "拍照",
                            style: TextStyle(
                                fontSize: 16, color: AppColors.c_FF32374E),
                          )),
                    ),
                    Divider(
                      color: Color(0xffececec),
                      height: 0.5,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.fromAlbumCallback!();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 49,
                        margin: EdgeInsets.only(left: 16, top: 10, right: 16),
                        alignment: Alignment.center,
                        child: Text(
                          "从相册选取",
                          style: TextStyle(
                              fontSize: 16, color: AppColors.c_FF32374E),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  widget.cancelCallback!();
                },
                child: Container(
                  width: double.infinity,
                  height: 49,
                  margin:
                      EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xccfcfcfc),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "取消",
                    style: TextStyle(fontSize: 16, color: Color(0xff959ba0)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
