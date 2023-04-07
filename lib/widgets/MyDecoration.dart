import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MyBoxPainter(this);
  }
}

class _MyBoxPainter extends BoxPainter {
  final MyDecoration testDecoration;
  final Paint painter;

  _MyBoxPainter(this.testDecoration)
      : painter = Paint()
    ..color = Color(0xffd2d5dc)
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var size = configuration.size;
    Offset leftTop = offset;
    Offset rightTop = leftTop.translate(size!.width, 0);

    Paint painterBottom = Paint()
      ..color = Color(0xffd2d5dc)
      ..strokeWidth = 0.5.w;
    Offset leftBottom = leftTop.translate(0+10, size!.height - 10);
    Offset rightBottom = leftTop.translate(size.width-16, size.height - 10);

    // canvas.drawLine(leftTop, leftBottom, painter);
    //绘制底部的分割线
    // canvas.drawLine(leftBottom, rightBottom, painterBottom);

    var dashHeightOne = 3;
    var dashSpaceOne = 3;
    var startX = leftTop.dx;
    double startYOne = leftTop.dy;
    var maxOne = size!.height-40;
    final spaceOne = (dashSpaceOne + dashHeightOne);
    while (startYOne < maxOne + leftTop.dy) {
      canvas.drawLine(Offset(startX, startYOne),
          Offset(startX, startYOne + dashHeightOne), painter);
      startYOne += spaceOne;
    }
  }
}
