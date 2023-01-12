import 'package:crazyenglish/utils/Util.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../r.dart';
import '../../widgets/images_anim.dart';

class LoadingWidget extends StatefulWidget {

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;      // 动画控制器
  late Animation<double> animation;      // 动画

  // 补间(动画）
  static final leftScaleTween = new Tween<double>(begin: 12.0, end: 6.0);   // 左边小球的大小变化区间
  static final rightScaleTween = new Tween<double>(begin: 6.0, end: 12.0);  // 右边小球的大小变化区间
  static final  alignmentTween = new Tween<double>(begin: 10, end: 30);     // 位置变化区间
  late VoidCallback callback;
  late AnimationStatusListener animationStatusListener;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    callback = (){
      setState(() {

      });
    };
    animation.addListener(callback);
    animationStatusListener = (status) {
      if (status == AnimationStatus.completed) {
        // 动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }

    };
    animation.addStatusListener(animationStatusListener);
    controller.forward();
  }

  @override
  void dispose() {
    if(callback!=null){
      animation.removeListener(callback);
    }
    if(animationStatusListener!=null){
      animation.removeStatusListener(animationStatusListener);
    }
    if(controller!=null){
      controller.clearListeners();
      controller.clearStatusListeners();
      controller.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.c_66000000,
          borderRadius: BorderRadius.all(Radius.circular(14.w))
      ),
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 20,
        child: Stack(
          alignment:Alignment.center ,
          children: <Widget>[
            Positioned(
              left: alignmentTween.evaluate(animation),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color(0XffFF4D35)
                ),
                width: leftScaleTween.evaluate(animation),
                height: leftScaleTween.evaluate(animation),
              ),
            ),

            Positioned(
              right: alignmentTween.evaluate(animation),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color(0XffFFBC00)
                ),
                width: rightScaleTween.evaluate(animation),
                height: rightScaleTween.evaluate(animation),
              ),
            )
          ],
        ),

      ),
    );
  }
}