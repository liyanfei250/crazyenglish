import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/class_list_response.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../../scan_class_message/class_message_view.dart';
import '../class_page_card/class_page_card_view.dart';
import 'my_class_list_logic.dart';

class MyClassListPage extends BasePage {
  const MyClassListPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<MyClassListPage>
    with TickerProviderStateMixin {
  final logic = Get.put(My_class_listLogic());
  final state = Get
      .find<My_class_listLogic>()
      .state;
  late TabController _tabController;
  List<Obj> tabs = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: Stack(
        children: [
          _buildBgView(context),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: Util.buildBackWidget(context),
                centerTitle: true,
                title: Text(
                  "我的班级",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Color(0xff353e4d)),
                ),
              ),
              Container(
                height: 30.w,
                margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 10.w),
                child: _buildTabBar(),
              ),
              Expanded(child: _buildTableBarView()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: tabs.length);
    logic.addListenerId(GetBuilderIds.getMyClassList, () {
      if (state.myClassList != null && state.myClassList!.obj!=null) {
        print("班级数据==="+state.myClassList!.obj![0]!.name!);

        tabs = state.myClassList!.obj!;
        setState(() {
          _tabController.dispose();
          _tabController = TabController(vsync: this, length: tabs.length);
        });
      }
    });
    //todo 真实数据
    logic.getMyClassList('1651539603655626753');
  }

  @override
  void onDestroy() {}

  Widget _buildBgView(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesReviewTopBg), fit: BoxFit.cover),
        ));
  }

  Widget _buildTabBar() =>
      TabBar(
        onTap: (tab) => print(tab),
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Color(0xfff19e59), Color(0xffee7d7a)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        isScrollable: true,
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xff898a93),
        tabs: tabs.map((e) => Tab(text: e.name)).toList(),
      );

  Widget _buildTableBarView() =>
      TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return ClassCard(isShowRank: true,className: e.name!,classImage: e.image!,studentSize: e.studentSize!.toString(),teacherName: SpUtil.getString(BaseConstant.TEACHER_NAME),teacherSex: SpUtil.getString(BaseConstant.TEACHER_SEX),teacherAge: SpUtil.getString(BaseConstant.TEACHER_AGE),teacherConnect: SpUtil.getString(BaseConstant.TEACHER_PHONE),);
          }).toList());

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<My_class_listLogic>();
    _tabController.dispose();
    super.dispose();
  }
}
