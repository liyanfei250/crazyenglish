import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import 'teacher_corrected_logic.dart';

//待批改列表
class TeacherCorrectedPage extends BasePage {
  const TeacherCorrectedPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<TeacherCorrectedPage> {
  final logic = Get.put(Teacher_correctedLogic());
  final state = Get.find<Teacher_correctedLogic>().state;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  final List<Map<String, dynamic>> _data = [
    {
      "classifyId": "1646439861824098314",
      "classifyName": "其它1",
      "catalogues": [
        {
          "journalCatalogueId": "1648138028814798850",
          "catalogueName": "测试01-03"
        },
        {
          "journalCatalogueId": "1648138028814798850",
          "catalogueName": "测试01-04"
        }
      ]
    },
    {
      "classifyId": "1646439861824098314",
      "classifyName": "其它2",
      "catalogues": [
        {
          "journalCatalogueId": "1648138028814798850",
          "catalogueName": "测试01-03"
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("待批改主观题"),
      backgroundColor: AppColors.theme_bg,
      body:Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 16, right: 16, top: 20.w, bottom: 20.w),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )
        ,child:SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                buildItem,
                childCount: _data.length,
              ),
            ),
          ],
        ),
      ) ),
    );
  }

  @override
  void onCreate() {

    //todo 接口没有呢，找曹伟
    logic.addListenerId(GetBuilderIds.getTeacherToCorrected, () {
      hideLoading();
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }
     /* if (state.myJournalDetail != null) {
        if (mounted && state.myJournalDetail!.obj != null) {
          myListDate = state.myJournalDetail!.obj!;
          setState(() {});
        }
      }*/
    });
   // _onRefresh();
    //todo 接口没有呢，找曹伟
    //showLoading("");
  }

  void _onRefresh() async {
    logic.getHomeListToCorrect();
  }

  void _onLoading() async {

  }
  @override
  void onDestroy() {

    _refreshController.dispose();
  }

  Widget? buildItem(BuildContext context, int index
      ) {
    return ExpansionTile(
      title: Text(_data[index]['classifyName'],
          style: TextStyle(fontSize: 14, color: AppColors.c_FF32374E)),
      children: _data[index]['catalogues']
          .map<Widget>((catalogue) => ListTile(
        title: Text(catalogue['catalogueName'],
            style: TextStyle(
                fontSize: 12, color: Color(0xff898a93))),
        onTap: () {},
      ))
          .toList(),
    );
  }
}
