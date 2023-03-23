/**
 * Time: 2023/2/27 11:23
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';


class WDCustomTrackShape extends SfTrackShape {

  WDCustomTrackShape({this.addHeight = 0});
  //增加选中滑块的高度,系统默认+2·
  double addHeight;

  ///去掉默认边距
  Rect getPreferredRect(
      RenderBox parentBox, SfSliderThemeData themeData, Offset offset,
      {bool? isActive}) {
    final double trackHeight = themeData.activeTrackHeight??1;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }


}