import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/homework/choose_question/question_list/question_list_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../assign_homework/assign_homework_logic.dart';
import '../base_choose_page_state.dart';
import 'choose_question_logic.dart';
import 'question_list/question_list_view.dart';
import '../../../entity/home/HomeKingDate.dart';
import '../../../../entity/review/HomeSecondListDate.dart' as data;
import '../../../entity/home/HomeKingDate.dart' as choiceDate;
import '../../../base/common.dart' as common;

class ChooseQuestionPage extends BasePage {
  const ChooseQuestionPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ChooseQuestionPageState();
}

class _ChooseQuestionPageState
    extends BaseChoosePageState<ChooseQuestionPage, data.CatalogueRecordVoList>
    with TickerProviderStateMixin {
  final logic = Get.put(ChooseQuestionLogic());
  final state = Get.find<ChooseQuestionLogic>().state;

  late TabController _tabController;
  final assignLogic = Get.find<AssignHomeworkLogic>();
  List<choiceDate.Obj> choiceList = [];
  List<Obj> tabs = [];
  bool _isOpen = false;
  late List<String> items = [];

  @override
  String getDataId(String key, data.CatalogueRecordVoList n) {
    assert(n.catalogueId != null);
    return n.catalogueId!.toString();
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Util.buildWhiteWidget(context),
                        Text("习题选择"),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        //筛选
                        setState(() {
                          _isOpen = !_isOpen;
                        });
                      },
                      child: Container(
                        height: 27.w,
                        width: 27.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xfff19e59),
                                Color(0xffec5f2a),
                              ]),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.5.w)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffee754f).withOpacity(0.25),
                              // 阴影的颜色
                              offset: Offset(0.w, 4.w),
                              // 阴影与容器的距离
                              blurRadius: 8.w,
                              // 高斯的标准偏差与盒子的形状卷积。
                              spreadRadius: 0.w,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          R.imagesHomeWorkQuestionFilter,
                          width: 14.w,
                          height: 14.w,
                        ),
                      ),
                    )
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
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: _buildTabBar(),
                        )
                      ];
                    },
                    body: _buildTableBarView(),
                  ),
                ),
              ),
              buildBottomWidget()
            ],
          ),
          Visibility(
            child: InkWell(onTap: (){
              setState(() {
                _isOpen = !_isOpen;
              });
            },child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
            ),),
            visible: _isOpen,
          ),
          Visibility(
              visible: _isOpen,
              child: Container(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, top: 50.w, bottom: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.w),
                      bottomLeft: Radius.circular(10.w)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 3),
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25.w,
                          width: MediaQuery.of(context).size.width / 4,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 12.w, top: 18.w),
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            color: Color(0xfff5f6f9),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                state.selectedIndex = -1;
                                _isOpen = false;
                                state.choiceText.value ="全部";
                              });
                              state.affiliatedGrade = null;
                              logic.getQuestionList(
                                  SpUtil.getInt(BaseConstant.USER_ID),
                                  state.dictionaryId,
                                  state.affiliatedGrade,
                                  state.pageSize,
                                  state.pageStartIndex); //全部
                            },
                            child: Text(
                              '全部分类',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: state.selectedIndex == -1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 18.w,
                            runSpacing: 4.w,
                            children: List.generate(
                              items.length,
                                  (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    state.selectedIndex = index;
                                    _isOpen = false;
                                    state.choiceText.value = choiceList[index]!.name!;
                                  });
                                  state.affiliatedGrade =
                                      choiceList[index]!.id!.toInt();

                                  logic.getQuestionList(
                                      SpUtil.getInt(BaseConstant.USER_ID),
                                      state.dictionaryId.toString(),
                                      state.affiliatedGrade,
                                      state.pageSize,
                                      state.pageStartIndex);
                                },
                                child: Container(
                                  height: 25.w,
                                  width: MediaQuery.of(context).size.width / 4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff5f6f9),
                                    borderRadius: BorderRadius.circular(20.w),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 8.0,
                                  ),
                                  child: Text(
                                    items[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: state.selectedIndex == index
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget buildBottomWidget() {
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
            List<data.CatalogueRecordVoList> exercises = [];
            List<num> exercisesId = [];
            List<String> exercisesName = [];
            dataList.forEach((key, value) {
              if (value != null) {
                for (data.CatalogueRecordVoList n in value!) {
                  String id = getDataId(key, n);
                  if (isSelectedMap[key] != null &&
                      (isSelectedMap[key]![id] ?? false)) {
                    exercises.add(n);
                    exercisesId.add(n.catalogueId!);
                    exercisesName.add(n.catalogueName!);
                  }
                }
              }
            });
            if (exercises.isNotEmpty) {
              assignLogic.updateAssignHomeworkRequest(
                  paperType: common.PaperType.Questions,
                  journalCatalogueIds: exercisesId,
                  questionDesc: exercisesName.toString());
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
        return QuestionListPage(chooseLogic: this, tagId: e.id.toString());
      }).toList());

  @override
  void dispose() {
    Get.delete<ChooseQuestionLogic>();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: tabs.length);
    logic.addListenerId(GetBuilderIds.getHomeListChoiceDate, () {
      if (state.paperDetail != null) {
        if (state.paperDetail!.obj != null &&
            state.paperDetail!.obj!.length > 0) {
          choiceList = state.paperDetail!.obj!;
          items = choiceList.map((obj) => obj.name!).toList();
          setState(() {});
        }
      }
    });
    logic.getChoiceMap(DictionaryType.GradeType);

    //获取金刚区列表
    logic.addListenerId(GetBuilderIds.getHomeDateList, () {
      if (state.tabList != null) {
        if (state.tabList!.obj != null && state.tabList!.obj!.length > 0) {
          tabs = state.tabList!.obj!;
          setState(() {
            _tabController.dispose();
            _tabController = TabController(vsync: this, length: tabs.length);
            currentKey.value = tabs[0].id.toString();
            _tabController.addListener(() {
              currentKey.value = tabs[_tabController!.index].id.toString();
            });
          });
        }
      }
    });

    logic.getHomeList('classify_type');
  }

  @override
  void onDestroy() {}

  @override
  bool get wantKeepAlive => true;
}
