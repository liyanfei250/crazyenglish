import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/assign_homework_request.dart';
import 'package:crazyenglish/entity/member_student_list.dart';
import 'package:crazyenglish/pages/homework/assign_homework/assign_homework_logic.dart';
import 'package:crazyenglish/pages/homework/choose_student/student_list/student_list_view.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/class_list_response.dart';
import '../../../../entity/member_student_list.dart' as student;
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../base_choose_page_state.dart';
import 'choose_student_logic.dart';

class ChooseStudentPage extends BasePage {
  const ChooseStudentPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ChooseStudentPageState();
}

class _ChooseStudentPageState
    extends BaseChoosePageState<ChooseStudentPage, Student>
    with TickerProviderStateMixin {
  final logic = Get.put(ChooseStudentLogic());
  final state = Get.find<ChooseStudentLogic>().state;
  late TabController _tabController;
  final assignLogic = Get.find<AssignHomeworkLogic>();
  List<Obj> tabs = [];

  @override
  String getDataId(String key, Student n) {
    assert(n.userId != null);
    return n.userId!.toString();
  }

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: tabs.length);

    logic.addListenerId(
        GetBuilderIds.getHomeClassTab +
            SpUtil.getInt(BaseConstant.USER_ID).toString(), () {
      if (state.myClassList != null && state.myClassList!.obj != null) {
        tabs = state.myClassList!.obj!;
        setState(() {
          _tabController.dispose();
          _tabController = TabController(vsync: this, length: tabs.length);
          currentKey.value = tabs[0].id.toString();
          _tabController.addListener(() {
            currentKey.value = tabs[_tabController!.index].id.toString();
          });
        });
      }
    });
    //todo 真实数据
    logic.getMyClassList(SpUtil.getInt(BaseConstant.USER_ID).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: [
          Image.asset(R.imagesTeacherClassTop, width: double.infinity),
          Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Util.buildWhiteWidget(context),
                    Text("学生选择"),
                  ],
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      left: 19.w, bottom: 19.w, top: 35.w, right: 19.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.w)),
                  ),
                  child: tabs.length > 0
                      ? NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return [
                              SliverToBoxAdapter(
                                child: _buildTabBar(),
                              )
                            ];
                          },
                          body: _buildTableBarView(),
                        )
                      : PlaceholderPage(
                          imageAsset: R.imagesCommenNoDate,
                          title: '暂无数据',
                          topMargin: 0.w,
                          subtitle: '快去创建班级吧'),
                ),
              ),
              buildBottomWidgetStudent()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
        onTap: (tab) => print(tab),
        controller: _tabController,
        indicatorColor: AppColors.TAB_COLOR2,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        indicatorWeight: 3,
        labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
        labelColor: AppColors.TEXT_COLOR,
        tabs: tabs.map((e) => Tab(text: e.name)).toList(),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return StudentListPage(chooseLogic: this, classId: e.id.toString());
      }).toList());

  @override
  void dispose() {
    Get.delete<ChooseStudentLogic>();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {}

  @override
  bool get wantKeepAlive => true;

  Widget buildBottomWidgetStudent() {
    return Container(
      margin: EdgeInsets.only(left: 53.w, bottom: 30.w, right: 58.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  selectAll(currentKey.value, !hasSelectedAllFlag.value);
                },
                child: Obx(() => Text(
                      hasSelectedAllFlag.value ? "取消全选" : "全选",
                      style: TextStyle(
                          color: AppColors.c_FFED702D,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              Padding(padding: EdgeInsets.only(left: 36.w)),
              Obx(() => Text(
                    "已选${hasSelectedNum.value}",
                    style: TextStyle(
                        color: AppColors.c_FFED702D,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
          Util.buildHomeworkNormalBtn(() {
            int totalNum = 0;
            List<Student> historys = [];
            List<num> studentsId = [];
            List<String> studentsName = [];
            dataList.forEach((key, value) {
              if (value != null) {
                for (Student n in value!) {
                  String id = getDataId(key, n);
                  if (isSelectedMap[key] != null &&
                      (isSelectedMap[key]![id] ?? false)) {
                    historys.add(n);
                    studentsId.add(n.userId!);
                    studentsName.add(n.actualname!);
                  }
                }
              }
            });
            if (historys.isNotEmpty) {
              //todo 班级id 的获取
              ClassInfos clsss = ClassInfos(
                  schoolClassId: '1655395694170124290',
                  studentUserIds: studentsId);
              assignLogic.updateAssignHomeworkRequest(
                  schoolClassInfos: [clsss],
                  schoolClassInfoDesc: '已选学生（' +
                      historys.length.toString() +
                      "）人\n已选班级" +
                      studentsName.toString());
            } else {
              assignLogic.updateAssignHomeworkRequest(
                paperType: -1,
              );
            }
            Get.back();
          }, "完成")
        ],
      ),
    );
  }
}
