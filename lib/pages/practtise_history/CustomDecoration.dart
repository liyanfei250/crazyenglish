import 'package:flutter/material.dart';

class CustomDecoration extends Decoration {
  final double marginLeft;//顶角离左边的距离
  final Color lineColor;
  final double height;//顶角高度
  final double radius;//边框圆角大小
  CustomDecoration(
      {required this.marginLeft,
        this.radius = 8,
        this.lineColor = Colors.red,
        this.height = 16});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CustomPainter(this, marginLeft, lineColor, radius, height);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomDecoration customDecoration;
  Paint? painter;
  final double marginLeft;
  final Color lineColor;
  final double height;
  final double radius;

  _CustomPainter(this.customDecoration, this.marginLeft, this.lineColor,
      this.radius, this.height)
      : painter = Paint()
    ..color = lineColor
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var size = configuration.size;
    Offset leftTop = offset;
    Offset rightTop = leftTop.translate(size!.width, 0);
    Offset leftBottom = leftTop.translate(0, size.height);
    Offset rightBottom = leftTop.translate(size.width, size.height);

    final leftStart = leftTop.translate(radius, 0); //点1
    final leftPoint = leftTop.translate(marginLeft, 0); //点2
    final topPoint = leftPoint.translate(height, -height); // 点3
    final rightPoint = leftPoint.translate(height*2, 0); // 点4
    final top5 = rightTop.translate(-radius, 0);
    final top6 = rightTop.translate(0, radius);
    final bottom7 = rightBottom.translate(0, -radius);
    final bottom8 = rightBottom.translate(-radius, 0);
    final bottom9 = leftBottom.translate(radius, 0);
    final bottom10 = leftBottom.translate(0, -radius);
    final top11 = leftTop.translate(0, radius);

    final path = Path()
      ..moveTo(leftStart.dx, leftStart.dy)
      ..lineTo(leftPoint.dx, leftPoint.dy)
      ..lineTo(topPoint.dx, topPoint.dy)
      ..lineTo(rightPoint.dx, rightPoint.dy)
      ..lineTo(top5.dx, top5.dy)
      ..arcToPoint(top6, radius: Radius.circular(radius))
      ..lineTo(bottom7.dx, bottom7.dy)
      ..arcToPoint(bottom8, radius: Radius.circular(radius))
      ..lineTo(bottom9.dx, bottom9.dy)
      ..arcToPoint(bottom10, radius: Radius.circular(radius))
      ..lineTo(top11.dx, top11.dy)
      ..arcToPoint(leftStart, radius: Radius.circular(radius));


    canvas.drawPath(path, painter!..style = PaintingStyle.stroke);
  }
}