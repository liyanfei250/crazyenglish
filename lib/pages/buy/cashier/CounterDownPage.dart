import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterDownPage extends StatefulWidget {
  @override
  _CounterDownPageState createState() => _CounterDownPageState();
}

class _CounterDownPageState extends State<CounterDownPage> {
  // 用来在布局中显示相应的剩余时间
  String remainTimeStr = '';
  Timer? _timer;

  //倒计时
  void startCountDown(int time) {
    // 重新计时的时候要把之前的清除掉
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
        _timer = null;
      }
    }

    if (time <= 0) {
      return;
    }

    var countTime = time;
    const repeatPeriod = const Duration(seconds: 1);
    _timer = Timer.periodic(repeatPeriod, (timer) {
      if (countTime <= 0) {
        timer.cancel();
        //待付款倒计时结束，可以在这里做相应的操作
        return;
      }
      countTime--;

      //外面传进来的单位是秒，所以需要根据总秒数，计算小时，分钟，秒
      int hour = (countTime ~/ 3600) % 24;
      int minute = countTime % 3600 ~/ 60;
      int second = countTime % 60;

      var str = '';
      if (hour > 0) {
        str = str + hour.toString() + ':';
      }

      if (minute / 10 < 1) {
        //当只有个位数时，给前面加“0”，实现效果：“:01”,":02"
        str = str + '0' + minute.toString() + ":";
      } else {
        str = str + minute.toString() + ":";
      }

      if (second / 10 < 1) {
        str = str + '0' + second.toString();
      } else {
        str = str + second.toString();
      }

      setState(() {
        remainTimeStr = str;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //开始倒计时，这里传入的是秒数
    startCountDown(60);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
        _timer = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            remainTimeStr.length > 0 ? remainTimeStr : "--",
            style: TextStyle(
                fontSize: 18.sp,
                color: Color.fromRGBO(255, 111, 50, 1),
                fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  }
}
