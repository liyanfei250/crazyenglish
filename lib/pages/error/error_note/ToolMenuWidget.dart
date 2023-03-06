import 'package:crazyenglish/pages/error/error_note/ToolMenuItemWidget.dart';
import 'package:flutter/material.dart';
/// @author 编程小龙
/// @创建时间：2022/3/8
/// 工具菜单
class ToolMenuWidget extends StatefulWidget {
  final List<String> titles;
  final ValueChanged<int> click; // 点击回调
  final double? width;
  final double? height;
  final int currentIndex; // 当前选中
  final bool isHorizontal; // 横向
  final Color? activeColor; // 点击后的颜色 没传取主题色
  final Color? backgroundColor; // 背景色
  final Color? borderColor; // 边框色
  final TextStyle? textStyle; // 文字样式
  final TextStyle? activeTextStyle; //  选中的文字样式
  const ToolMenuWidget(
      {Key? key,
        this.currentIndex = 0,
        required this.titles,
        required this.click,
        this.width,
        this.height,
        this.isHorizontal = false,
        this.activeColor,
        this.backgroundColor,
        this.borderColor,
        this.textStyle,
        this.activeTextStyle,
      })
      : super(key: key);
  @override
  State<ToolMenuWidget> createState() => _ToolMenuWidgetState();
}
class _ToolMenuWidgetState extends State<ToolMenuWidget> {
  int currentIndex = 0; // 当前选中
  bool isHorizontal = false; // 是否横向
  @override
  void initState() {
    // 初始化当前选中
    currentIndex = widget.currentIndex;
    isHorizontal = widget.isHorizontal;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int index = 0; // 用于遍历计数
    int size = widget.titles.length;
    double height = widget.height ?? (isHorizontal ? 50 : 200); //设置水平和竖直时的默认值
    double width = widget.width ?? (isHorizontal ? 400 : 100);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white30,
        border: Border.all(color: widget.borderColor ?? Colors.grey, width: 1),
      ),
      child: Wrap(
        children: widget.titles.map((title) {
          return ToolMenuItemWidget(
            title: title,
            index: index,
            isHorizontal: widget.isHorizontal,
            click: (index) {
              setState(() {
                currentIndex = index;
              });
              widget.click(index);
            },
            activeColor: widget.activeColor,
            backgroundColor: widget.backgroundColor,
            borderColor: widget.borderColor,
            textStyle: widget.textStyle,
            height: widget.isHorizontal ? height - 2 : height / size,
            // 竖直状态-2 是去掉边框所占像素
            isActive: index == currentIndex,
            width: widget.isHorizontal ? width / size - 1 : width,
            isEnd: index++ == size - 1,
          );
        }).toList(),
      ),
    );
  }
}
