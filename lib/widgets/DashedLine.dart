import 'dart:ui' as ui;
import 'package:flutter/material.dart';
//虚线
class DashedLine extends StatelessWidget {
  final Axis axis;
  final double dashedWidth;
  final double dashedHeight;
  final Color color;

  DashedLine({
    this.axis = Axis.horizontal,
    this.dashedWidth = 4,
    this.dashedHeight = 2,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = axis == Axis.horizontal ? constraints.constrainWidth() : dashedHeight;
        final boxHeight = axis == Axis.horizontal ? dashedHeight : constraints.constrainHeight();
        final dashCount = (axis == Axis.horizontal ? boxWidth : boxHeight) ~/ dashedWidth;
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: axis,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashedWidth,
              height: dashedHeight,
              child: CustomPaint(
                painter: _DashedLinePainter(color, dashedWidth, dashedHeight),
              ),
            );
          }),
        );
      },
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashedWidth;
  final double dashedHeight;

  _DashedLinePainter(this.color, this.dashedWidth, this.dashedHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = dashedHeight
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.miter
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        [color.withOpacity(0), color, color.withOpacity(0)],
        [0, 0.5, 1],
      );
    final double dashWidth = 5;
    final double dashSpace = 5;
    double startX = 0;
    List<Offset> points = [];
    while (startX < size.width) {
      points.add(Offset(startX, 0));
      points.add(Offset(startX + dashWidth, 0));
      startX += dashWidth + dashSpace;
    }
    canvas.drawPoints(ui.PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
