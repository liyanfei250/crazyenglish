import 'dart:core';
import 'package:flutter/material.dart';
/// @author 编程小龙
/// @创建时间：2022/3/8
/// 工具菜单子项
class ToolMenuItemWidget extends StatelessWidget {
  /// 显示的title
  final String title;
  /// 当前选中
  final int index;
  /// 点击回调
  final ValueChanged<int> click;
  final double width;
  final double height;
  final bool isActive;
  final bool isHorizontal; // 是否横向
  final bool isEnd; // 是否为末尾
  final Color? activeColor; // 点击后的颜色
  final Color? backgroundColor; // 背景色
  final Color? borderColor; // 边框色
  final TextStyle? textStyle; // 文字样式
  final TextStyle? activeTextStyle; //  选中的文字样式
  const ToolMenuItemWidget({
    Key? key,
    this.isActive = false,
    required this.title,
    required this.index,
    required this.click,
    this.activeColor,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.activeTextStyle,
    this.isHorizontal = false,
    this.width = 100,
    this.isEnd = false,
    this.height = 40,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var defaultTextStyle = TextStyle(
        fontSize: 16, color: isActive ? Colors.white : Colors.black87);
    return Material(
      child: Ink( // 点击右波纹效果
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: isActive
                ? activeColor ?? Theme.of(context).primaryColor
                : backgroundColor ?? Colors.white30,
            border: isHorizontal
                ? isEnd
                ? const Border()
                : Border(
                right: BorderSide(
                    width: 1, color: borderColor ?? Colors.grey))
                : Border(
                bottom: BorderSide(
                    width: 1, color: borderColor ?? Colors.grey))),
        child: InkWell(
            onTap: () {
              click(index);
            },
            child: Center(
              child: Text(title,
                  style: isActive
                      ? activeTextStyle ?? defaultTextStyle
                      : textStyle ?? defaultTextStyle),
            )),
      ),
    );
  }
}
