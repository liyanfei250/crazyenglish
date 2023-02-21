import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description 作用:封装导航栏
/// @date: 2021/7/14
/// @author:卢融霜
class BaseRoutesWidget extends StatefulWidget {
  //标题
  String? title;
  double titleFontSize = 14.r;
  double toolBarHeight = 40.r;
  List<Widget>? actions;
  Widget? child;
  PreferredSizeWidget? titleBottom;
  Color? titleBgColor;
  bool showAppBar = true;
  bool isSearchBar = false;
  late Function(String searchText)? search;
  FloatingActionButton? floatingActionButton;

  BaseRoutesWidget(
      {Key? key,
        this.title,
        this.actions,
        this.child,
        this.titleBottom,
        this.titleBgColor,
        this.showAppBar = true,
        this.isSearchBar = false,
        this.search,
        this.floatingActionButton})
      : super(key: key);

  @override
  _BaseRoutesWidgetState createState() => _BaseRoutesWidgetState();
}

class _BaseRoutesWidgetState extends State<BaseRoutesWidget> {
  TextEditingController? controller;

  @override
  void initState() {
    if (widget.isSearchBar) {
      controller = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      resizeToAvoidBottomInset: false,
      appBar: widget.showAppBar
          ? (widget.isSearchBar
          ? AppBar(
        leadingWidth: 30.r,
        toolbarHeight: widget.toolBarHeight,
        centerTitle: true,
        actions: widget.actions,
        bottom: widget.titleBottom,
        title: Row(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10.r),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.r)),
                      color: const Color.fromRGBO(242, 242, 242, 1)),
                  padding: EdgeInsets.only(
                      left: 10.r, right: 10.r, top: 4.r, bottom: 4.r),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: controller,
                    style: TextStyle(fontSize: 13.r),
                    onEditingComplete: () {
                      widget.search!(controller!.text);
                    },
                    decoration: InputDecoration(
                      hintText: "请输入关键字",
                      hintStyle: TextStyle(fontSize: 13.r),
                      border: InputBorder.none,
                      isCollapsed: true,
                      icon: Icon(
                        Icons.search_outlined,
                        size: 18.r,
                      ),
                    ),
                  ),
                )),
            InkWell(
              splashColor: Colors.transparent,
              child: Text(
                "搜索",
                style: TextStyle(fontSize: 14.r),
              ),
              onTap: () {
                widget.search!(controller!.text);
              },
            )
          ],
        ),
      )
          : AppBar(
        toolbarHeight: widget.toolBarHeight,
        centerTitle: true,
        actions: widget.actions,
        bottom: widget.titleBottom,
        title: Text("sdfsdfsdf",
            style: TextStyle(fontSize: widget.titleFontSize)),
      ))
          : null,
      body: widget.child,
    );
  }
}
