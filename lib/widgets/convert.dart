
import 'enums.dart';

/// create by leixun on 2020-03-07
/// contact me by email leixun33@163.com
/// 说明:

class Convert {
  static WidgetFamily toFamily(int id) {
    switch (id) {
      case 0:
        return WidgetFamily.statelessWidget;
      case 1:
        return WidgetFamily.statefulWidget;
      case 2:
        return WidgetFamily.singleChildRenderObjectWidget;
      case 3:
        return WidgetFamily.multiChildRenderObjectWidget;
      case 4:
        return WidgetFamily.sliver;
      case 5:
        return WidgetFamily.proxyWidget;
      case 6:
        return WidgetFamily.other;
      default:
        return WidgetFamily.statelessWidget;
    }
  }

  static String convertFileSize(int size){
    double result = size / 1024.0;
    if(result<1024){
      return "${result.toStringAsFixed(2)} Kb";
    }else if(result>1024&&result<1024*1024){
      return "${(result/1024).toStringAsFixed(2)} Mb";
    }else{
      return "${(result/1024/1024).toStringAsFixed(2)} Gb";
    }
  }


}
