import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description 作用:列表筛选组件
/// @date: 2021/8/16
/// @author:卢融霜
class ScreenWidget extends StatefulWidget {
  //筛选视图高度
  double? topBarHeight;
  //显示标题
  late Widget? titleWidget;
  //筛选组件
  late Widget? screenListWidget;
  //子组件
  late Widget? child;
  //控制器，开关
  ScreenController? controller;
  //打开监听
  Function? screenOpen;
  //关闭监听
  Function? screenClose;

  ScreenWidget(
      {Key? key,
        this.controller,
        this.topBarHeight = 0,
        this.screenOpen,
        this.screenClose,
        @required this.titleWidget,
        @required this.screenListWidget,
        @required this.child})
      : super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

late AnimationController raController;
late Animation<double> _raAnimation;
late Animation<double> _heAnimation;
double viewHegin = 0;

class _ScreenWidgetState extends State<ScreenWidget>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    raController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.topBarHeight == null || widget.topBarHeight == 0) {
      widget.topBarHeight = 45.r;
    }

    raController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _raAnimation = Tween(begin: .0, end: .5).animate(raController);
    _heAnimation = Tween(begin: .0, end: 0.1).animate(raController);
    Future.delayed(Duration.zero, () {
      _heAnimation =
      Tween(begin: .0, end: MediaQuery.of(context).size.height / 2.5)
          .animate(raController)
        ..addListener(() {
          setState(() {
            viewHegin = _heAnimation.value;
          });
          if (raController.isCompleted) {
            if (widget.screenOpen != null) {
              widget.screenOpen!();
            }
          } else if (raController.isDismissed) {
            if (widget.screenClose != null) {
              widget.screenClose!();
            }
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Container(
              height: widget.topBarHeight,
              alignment: Alignment.center,
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  if (raController.isCompleted) {
                    raController?.reverse();
                  } else {
                    raController?.forward();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.titleWidget!,
                    RotationTransition(
                      turns: _raAnimation,
                      child: Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30.r,
                      ),
                    )
                  ],
                ),
              ),
            )),
        Stack(
          children: [
            Align(
                child: Container(
                  margin: EdgeInsets.only(top: widget.topBarHeight!),
                  width: MediaQuery.of(context).size.width,
                  height: double.maxFinite,
                  child: Column(
                    children: [Expanded(child: widget.child!)],
                  ),
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height:
                  (viewHegin > 0) ? MediaQuery.of(context).size.height : 0,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border(
                          top: BorderSide(
                              color: const Color.fromRGBO(230, 230, 230, 1),
                              width: 0.4.r))),
                  margin: EdgeInsets.only(top: widget.topBarHeight!),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: viewHegin,
                        child: widget.screenListWidget,
                      )
                    ],
                  ),
                ))
          ],
        )
      ],
    );
  }
}

class ScreenController {
  //打开
  void open() {
    raController?.forward();
  }

  //关闭
  void close() {
    raController?.reverse();
  }
}
