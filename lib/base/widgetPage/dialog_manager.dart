import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';
import 'package:crazyenglish/base/widgetPage/show_image_select_dialog.dart';
import 'package:crazyenglish/base/widgetPage/show_tips_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'show_alert_dialog.dart';

typedef HideDialogCallBack = Future Function();
typedef YesDialogCallBack = Future Function();

class DialogManager {
  static HideDialogCallBack showDialog(BuildContext context, String loadingText) {
    Completer completer = Completer();

    OverlayEntry? result = OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              color: Color(0x99f4f4f4),
              width: 150,
              height: 150,
              child: Center(
                child: Text(loadingText + ""),
              ),
            ),
          ),
        );
      },
    );

    completer.complete(() {
      if (result != null) {
        result!.remove();
        result = null;
      }
    });

    Overlay.of(context)!.insert(result!);

    return () async {
      var hide = await completer.future;
      hide();
    };
  }

  static void showCommonDialog(
      BuildContext context, String title, String content, YesDialogCallBack callBack) {
    Completer completer = Completer();

    OverlayEntry? result = OverlayEntry(
      maintainState: true,
      builder: (context) {
        return CupertinoAlertDialog(title: Text(title), content: Text(content), actions: <Widget>[
          CupertinoButton(
            child: Text("Yes, Delete"),
            onPressed: () {
              callBack();
            },
          ),
          CupertinoButton(
            child: Text("Cancle"),
            onPressed: () => Get.back(),
          ),
        ]);
      },
    );

    completer.complete(() {
      if (result != null) {
        result!.remove();
        result = null;
      }
    });

    Overlay.of(context)!.insert(result!);

    // return () async {
    //   var hide = await completer.future;
    //   hide();
    // };
  }

  static void showTipsDialog(BackButtonBehavior backButtonBehavior,
      {VoidCallback? confirm, VoidCallback? backgroundReturn}) {
    BotToast.showAnimationWidget(
        clickClose: false,
        allowClick: false,
        onlyOne: true,
        crossPage: true,
        backButtonBehavior: backButtonBehavior,
        wrapToastAnimation: (controller, cancel, child) => Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                cancel();
                backgroundReturn?.call();
              },
              //The DecoratedBox here is very important,he will fill the entire parent component
              child: AnimatedBuilder(
                builder: (_, child) => Opacity(
                  opacity: controller.value,
                  child: child,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black26),
                  child: SizedBox.expand(),
                ),
                animation: controller,
              ),
            ),
            child,
          ],
        ),
        toastBuilder: (cancelFunc) => ShowTipsDialog(
          content: "您当前的账户情况暂不满足自助注销条件，为了您的账户安全，请联系客服(400-690-5751)\n申请注销账户？",
          okTxt: "好的",
          okVoidCallback: () {
            cancelFunc();
            confirm?.call();
          },
        ),
        animationDuration: Duration(milliseconds: 300));
  }

  static void showNormalDialog(BackButtonBehavior backButtonBehavior,String title,
      {VoidCallback? cancel, VoidCallback? confirm, VoidCallback? backgroundReturn}) {
    BotToast.showAnimationWidget(
        clickClose: false,
        allowClick: false,
        onlyOne: true,
        crossPage: true,
        backButtonBehavior: backButtonBehavior,
        wrapToastAnimation: (controller, cancel, child) => Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                cancel();
                backgroundReturn?.call();
              },
              //The DecoratedBox here is very important,he will fill the entire parent component
              child: AnimatedBuilder(
                builder: (_, child) => Opacity(
                  opacity: controller.value,
                  child: child,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black26),
                  child: SizedBox.expand(),
                ),
                animation: controller,
              ),
            ),
            child,
          ],
        ),
        toastBuilder: (cancelFunc) => ShowAlertDialog(
          content: title,
          okTxt: "确定",
          cancelTxt: "取消",
          okVoidCallback: () {
            cancelFunc();
            confirm?.call();
          },
          cancelVoidCallback: () {
            cancelFunc();
            cancel?.call();
          },
        ),
        animationDuration: Duration(milliseconds: 300));
  }

  static void showSelectPickerDialog(BackButtonBehavior backButtonBehavior,
      {VoidCallback? takePhotoCallback,
      VoidCallback? fromAlbumCallback,
      VoidCallback? cancelCallback}) {
    BotToast.showAnimationWidget(
        clickClose: true,
        allowClick: true,
        onlyOne: true,
        crossPage: true,
        backButtonBehavior: backButtonBehavior,
        wrapToastAnimation: (controller, cancel, child) => Stack(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    cancel();
                  },
                  //The DecoratedBox here is very important,he will fill the entire parent component
                  child: AnimatedBuilder(
                    builder: (_, child) => Opacity(
                      opacity: controller.value,
                      child: child,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black26),
                      child: SizedBox.expand(),
                    ),
                    animation: controller,
                  ),
                ),
                child,
              ],
            ),
        toastBuilder: (cancelFunc) => ShowImageSelectDialog(
              takePhotoCallback: () {
                cancelFunc();
                takePhotoCallback!();
              },
              fromAlbumCallback: () {
                cancelFunc();
                fromAlbumCallback!();
              },
              cancelCallback: () {
                cancelFunc();
                cancelCallback!();
              },
            ),
        animationDuration: Duration(milliseconds: 300));
  }

  static void showAlertDialog(BackButtonBehavior backButtonBehavior, String content,
      {VoidCallback? cancel, VoidCallback? confirm, VoidCallback? backgroundReturn,TextAlign textAlign = TextAlign.start}) {
    BotToast.showAnimationWidget(
        clickClose: false,
        allowClick: false,
        onlyOne: true,
        crossPage: true,
        backButtonBehavior: backButtonBehavior,
        wrapToastAnimation: (controller, cancel, child) => Stack(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    cancel();
                    backgroundReturn?.call();
                  },
                  //The DecoratedBox here is very important,he will fill the entire parent component
                  child: AnimatedBuilder(
                    builder: (_, child) => Opacity(
                      opacity: controller.value,
                      child: child,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black26),
                      child: SizedBox.expand(),
                    ),
                    animation: controller,
                  ),
                ),
                child,
              ],
            ),
        toastBuilder: (cancelFunc) => ShowAlertDialog(
              content: content,
              okTxt: "确定",
              cancelTxt: "取消",
              textAlign: textAlign,
              okVoidCallback: () {
                cancelFunc();
                confirm?.call();
              },
              cancelVoidCallback: () {
                cancelFunc();
                cancel?.call();
              },
            ),
        animationDuration: Duration(milliseconds: 300));
  }

  ///显示预览图片大图
  static void showPreViewImageDialog(BackButtonBehavior backButtonBehavior, String imageUrl) {
    BotToast.showAnimationWidget(
        clickClose: false,
        allowClick: false,
        onlyOne: true,
        crossPage: true,
        backButtonBehavior: backButtonBehavior,
        wrapToastAnimation: (controller, cancel, child) => Stack(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    cancel();
                  },
                  //The DecoratedBox here is very important,he will fill the entire parent component
                  child: AnimatedBuilder(
                    builder: (_, child) => Opacity(
                      opacity: controller.value,
                      child: child,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black26),
                      child: SizedBox.expand(),
                    ),
                    animation: controller,
                  ),
                ),
                child,
              ],
            ),
        toastBuilder: (cancelFunc) => Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  cancelFunc();
                },
                child: ExtendedImage.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  //enableLoadState: false,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 3.0,
                      animationMaxScale: 3.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1.0,
                      initialAlignment: InitialAlignment.center,
                    );
                  },
                ),
              ),
            ),
        animationDuration: Duration(milliseconds: 300));
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController? controller;
  final Widget? child;

  const CustomOffsetAnimation({Key? key, this.controller, this.child}) : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;
  late Tween<double> tweenScale;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation = CurvedAnimation(parent: widget.controller!, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller!,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: ClipRect(
              child: Transform.scale(
                scale: tweenScale.evaluate(animation),
                child: Opacity(
                  child: child,
                  opacity: animation.value,
                ),
              ),
            ));
      },
    );
  }
}
