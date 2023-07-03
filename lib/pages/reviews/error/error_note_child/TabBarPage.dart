import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarPage extends StatefulWidget {
  late TabController _controller;
  List<String> tabs;

  TabBarPage(this._controller, this.tabs, {Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {
  List _tabs = [
    "听力",
    "阅读",
    "写作",
    "语法",
  ];
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    widget._controller.addListener(() {
      setState(() {
        _tabIndex = widget._controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 26.w,left: 18.w,right: 18.w,bottom: 0.w),
          color: Color(0xfff2f5fc),
          child: TabBar(
            controller: widget._controller,
            isScrollable: true,
            //设置为true则TabBar居中
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            // indicator: const BoxDecoration(),//不设置下划线
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Color(0xffffbc00), width: 3),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            tabs: _getItem(_tabIndex),
          ),
        ),
        /*Flexible(
              child: TabBarView(controller: _controller, children: [
            Text("全部"),
            Text("进行中"),
            Text("已完成"),
          ]))*/
      ],
    );
  }

  _getItem(int index) {
    print("getItem$index");
    BoxDecoration decoration = BoxDecoration(
      color: Color(0xfff2f5fc),
      borderRadius: BorderRadius.all(Radius.circular(8.w)),
    );
    List<Widget> list = [];
    for (var i = 0; i < _tabs.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(bottom: 4.w),
        padding:
            EdgeInsets.only(bottom: 4.w, top: 4.w, right: 18.w, left: 18.w),
        decoration: index == i
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white)
            : decoration,
        child: Text(
          _tabs[i],
          style: TextStyle(color: Colors.yellow),
        ),
      ));
    }
    return list;
  }
}
