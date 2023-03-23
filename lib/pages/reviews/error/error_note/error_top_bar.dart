import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * Time: 2023/3/6 10:33
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class ErrorTopBar extends StatelessWidget implements PreferredSizeWidget{

  Widget childWidget;

  ErrorTopBar(this.childWidget,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.childWidget;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40.w);
}
