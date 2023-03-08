import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../r.dart';

/// create by 张风捷特烈 on 2020/10/10
/// contact me by email 1981462002@qq.com
/// 说明:

class LeftLineWidget extends StatefulWidget {
  bool showTop;
  bool showBottom;
  bool isLight;

  LeftLineWidget({
    Key? key,
    required this.showTop,
    required this.showBottom,
    required this.isLight, //如果为true 只画虚线，不画圆
  }) : super(key: key);

  @override
  _DrawPictureState createState() => _DrawPictureState();
}

class _DrawPictureState extends State<LeftLineWidget> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets(R.imagesTimePointIcon);
    if (mounted) setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(Uint8List.fromList(bytes));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: 16,
      child: CustomPaint(
        painter: LeftLinePainter(
            widget.showTop, widget.showBottom, widget.isLight, _image),
      ),
    );
  }
}

class LeftLinePainter extends CustomPainter {
  static const double _topHeight = 16;
  static const Color _lightColor = Colors.deepPurpleAccent;
  static const Color _normalColor = Colors.white;

  final bool showTop;
  final bool showBottom;
  final bool isLight; //如果为true 只画虚线，不画圆
  ui.Image? _image;

  LeftLinePainter(this.showTop, this.showBottom, this.isLight, this._image);

  @override
  void paint(Canvas canvas, Size size) {
    if (!isLight) {
      double lineWidth = 2;
      double centerX = size.width / 2;
      Paint linePain = Paint();
      linePain.color = showTop ? Color(0xffd2d5dc) : Colors.transparent;
      linePain.strokeWidth = lineWidth;
      linePain.strokeCap = StrokeCap.square;
      // canvas.drawLine(Offset(centerX, 0), Offset(centerX, _topHeight), linePain);
      var dashHeightOne = 3;
      var dashSpaceOne = 3;
      double startYOne = 0;
      var maxOne = 10;
      final spaceOne = (dashSpaceOne + dashHeightOne);
      if (showTop) {
        while (startYOne < maxOne) {
          canvas.drawLine(Offset(centerX, startYOne),
              Offset(centerX, startYOne + dashHeightOne), linePain);
          startYOne += spaceOne;
        }
      }

      Paint circlePaint = Paint();
      circlePaint.color = _normalColor;
      circlePaint.style = PaintingStyle.fill;
      Paint circlePaintNew = Paint();
      circlePaintNew.color = Color(0xfffff6f2);
      circlePaintNew.style = PaintingStyle.fill;
      linePain.color = showBottom ? Color(0xffd2d5dc): Colors.transparent;
      // canvas.drawLine(
      //     Offset(centerX, _topHeight), Offset(centerX, size.height), linePain);

      var dashHeight = 2;
      var dashSpace = 4;
      double startY = _topHeight;
      var max = size.height;
      final space = (dashSpace + dashHeight);
      if (showBottom) {
        while (startY < max) {
          canvas.drawLine(Offset(centerX, startY),
              Offset(centerX, startY + dashHeight), linePain);
          startY += space;
        }
      }

      double centerXNew = size.width / 4;
      double centerXBad = size.width / 1.5;
      Paint newPaint = Paint();
      newPaint.strokeWidth = 1;
      newPaint.color = Color(0xffffbc00);

      canvas.drawCircle(Offset(centerX, _topHeight), centerXBad, circlePaintNew);
      canvas.drawCircle(Offset(centerX, _topHeight), centerX, circlePaint);
      canvas.drawCircle(Offset(centerX, _topHeight), centerXNew, newPaint);
    } else {
      double lineWidth = 2;
      double centerX = size.width / 2;
      Paint linePain = Paint();
      linePain.color = showTop ? Color(0xffd2d5dc): Colors.transparent;
      linePain.strokeWidth = lineWidth;
      linePain.strokeCap = StrokeCap.square;
      // canvas.drawLine(Offset(centerX, 0), Offset(centerX, _topHeight), linePain);
      var dashHeightOne = 3;
      var dashSpaceOne = 3;
      double startYOne = 0;
      var maxOne = size.height;
      final spaceOne = (dashSpaceOne + dashHeightOne);
      while (startYOne < maxOne) {
        canvas.drawLine(Offset(centerX, startYOne),
            Offset(centerX, startYOne + dashHeightOne), linePain);
        startYOne += spaceOne;
      }
    }

    // canvas.drawCircle(Offset(centerX, _topHeight), size.width, newPaint);
    // canvas.drawImage(_image!, Offset(centerX, 0), circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
