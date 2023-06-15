import 'dart:async';

import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/blocs/update_class_bloc.dart';
import 'package:crazyenglish/blocs/update_class_state.dart';
import 'package:crazyenglish/pages/classes/create_class/create_class_view.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../entity/class_list_response.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../utils/colors.dart';
import 'class_home/class_home_view.dart';
import 'class_logic.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

//首页班级模块
class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> with TickerProviderStateMixin {
  final logic = Get.put(ClassLogic());
  final state = Get.find<ClassLogic>().state;
  late TabController _tabController;
  Offset _offset = Offset(310.w, 70.w);
  bool _showAddClass = false;
  var extend = false;
  List<Obj> tabs = [];
  StreamSubscription? refrehUserInfoStreamSubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);

    setListner();
    refrehUserInfoStreamSubscription =
        BlocProvider.of<UpdateClassBloc>(context).stream.listen((event) {
      print("Class ========== bef event");
      if (event is ClassChangeSuccess) {
        print("Class ========== event");
        if (logic != null && SpUtil.getInt(BaseConstant.USER_ID) > 0) {
          logic.disposeId(GetBuilderIds.getHomeClassTab +
              SpUtil.getInt(BaseConstant.USER_ID).toString());
          setListner();
        }
      }
    });
  }

  void setListner() {
    logic.addListenerId(
        GetBuilderIds.getHomeClassTab +
            SpUtil.getInt(BaseConstant.USER_ID).toString(), () {
      if (mounted &&
          state.myClassList != null &&
          state.myClassList!.obj != null) {
        print("班级数据===" + state.myClassList!.obj![0]!.name!);
        tabs = state.myClassList!.obj!;
        setState(() {
          _tabController.dispose();
          _tabController = TabController(vsync: this, length: tabs.length);
        });
      }
    });

    logic.getMyClassList(SpUtil.getInt(BaseConstant.USER_ID).toString(),
        isCash: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: Stack(
        children: [
          Image.asset(R.imagesTeacherClassTop, width: double.infinity),
          tabs.length <= 0
              ? Container(
                  margin: EdgeInsets.only(top: 116.w, left: 20.w, right: 20.w),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                          offset: Offset(10, 20), // 阴影与容器的距离
                          blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                          spreadRadius: 10.0,
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: AppColors.c_FFFFFFFF),
                  child: PlaceholderPage(
                      imageAsset: R.imagesCommenNoDate,
                      title: '暂无数据',
                      topMargin: 0.w,
                      subtitle: '快去创建班级吧'),
                )
              : Column(
                  children: [
                    AppBar(
                      automaticallyImplyLeading: false,
                      title: _buildTabBar(),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(child: _buildTableBarView()),
                  ],
                ),
          Positioned(
            left: _offset.dx,
            top: _offset.dy,
            child: Draggable(
              child: buildContainer(),
              feedback: buildContainer(),
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                setState(() {
                  _offset = offset;
                });
              },
              childWhenDragging: Container(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      height: 38.w,
      padding: EdgeInsets.only(left: 4.w, right: extend ? 12.w : 6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Color(0xfff3b144),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            extend = !extend;
          });
        },
        child: Row(
          children: [
            Image.asset(
              R.imagesTeachClassAdd,
              width: 28.w,
              height: 28.w,
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: GestureDetector(
                onTap: () async {
                  //RouterUtil.toNamed(AppRoutes.Teacher_Class_Create);

                  var result = await Get.to(() => Create_classPage());
                  if (result != null && 'add_success' == result) {
                    setListner();
                  }
                },
                child: Container(
                  width: extend ? 44.w : 0.w,
                  child: Center(
                    child: Text(
                      '新建班级',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xffed702d),
                          fontSize: 10.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
        onTap: (tab) => print(tab),
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 14),
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        indicatorWeight: 3,
        labelStyle: TextStyle(
            fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
        labelColor: Colors.white,
        tabs: tabs.map((e) => Tab(text: e.name)).toList(),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return ClassHomePage(e.id!.toInt());
      }).toList());

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<ClassLogic>();
    _tabController.dispose();
    if (refrehUserInfoStreamSubscription != null) {
      refrehUserInfoStreamSubscription?.cancel();
    }
    super.dispose();
  }
}
