import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BaseRoutesWidget.dart';
import 'ScreenWidget.dart';

/// @description 作用:人员查询
/// @date: 2021/8/16
/// @author:卢融霜
class PersonnelSearch extends StatefulWidget {
  const PersonnelSearch({Key? key}) : super(key: key);

  @override
  _PersonnelSearchState createState() => _PersonnelSearchState();
}

class _PersonnelSearchState extends State<PersonnelSearch>{
  ScreenController controller = ScreenController();
  List<String> option = [
    "总监",
    "监理工程师",
    "监理员",
    "造价工程师",
    "质量检测员",
    "建造师",
    "安全工程师",
    "造价员",
    "五大员",
    "三类人员",
    "其他执业人员"
  ];
  String indexTitle = "总监";
  int selectIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return
      BaseRoutesWidget(
        isSearchBar: true,
        search: (String searchTitle) {},
        child:
        ScreenWidget(
            screenOpen: () {
              _scrollController.animateTo(selectIndex * 30.r,
                  duration: const Duration(microseconds: 1), curve: Curves.ease);
            },
            topBarHeight: 45.r,
            controller: controller,
            titleWidget: Text(
              indexTitle,
              style: TextStyle(
                  fontSize: 15.r, color: const Color.fromRGBO(51, 51, 51, 1)),
            ),
            screenListWidget: Container(
              color: Colors.white,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: option.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          indexTitle = option[index];
                          selectIndex = index;
                          controller.close();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color.fromRGBO(230, 230, 230, 1),
                                    width: 0.4.r))),
                        child: Text(
                          option[index],
                          style: TextStyle(
                              color: selectIndex == index
                                  ? const Color.fromRGBO(41, 121, 255, 1)
                                  : const Color.fromRGBO(51, 51, 51, 1),
                              fontSize: 14.r),
                        ),
                        padding: EdgeInsets.all(10.r),
                      ),
                    );
                  }),
            ),
            child: ListView.builder(
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      child: Text("1111111"),
                    ),
                  );
                })),
      );
  }
}
