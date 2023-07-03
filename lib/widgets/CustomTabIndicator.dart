import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter();
  }
}

class _CustomPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..color = Color(0xffffbc00)
      ..style = PaintingStyle.fill;

    final rect = Offset(offset.dx, configuration.size!.height - 2) & Size(configuration.size!.width, 2);
    canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft:Radius.circular(2.w),topRight:Radius.circular(2.w) ), paint);
  }
}
