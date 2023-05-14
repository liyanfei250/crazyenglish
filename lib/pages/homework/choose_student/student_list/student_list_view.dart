import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkStudentResponse.dart';
import 'package:crazyenglish/pages/homework/assign_homework/assign_homework_logic.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../base/AppUtil.dart';
import '../../../../r.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../routes/routes_utils.dart';
import '../../choose_logic.dart';
import 'student_list_logic.dart';
import '../../../../entity/member_student_list.dart';

class StudentListPage extends BasePage {
  ChooseIntel chooseLogic;
  String classId;

  StudentListPage({required this.chooseLogic, required this.classId, Key? key})
      : super(key: key);

  @override
  BasePageState<BasePage> getState() => _StudentListPageState();
}

class _StudentListPageState extends BasePageState<StudentListPage> {
  final logic = Get.put(StudentListLogic());
  final state = Get
      .find<StudentListLogic>()
      .state;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  final assignLogic = Get.find<AssignHomeworkLogic>();

  final int pageSize = 20;
  int currentPageNo = 1;
  List<Student> studentList = [];
  final int pageStartIndex = 1;

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getStudentChoiceList + widget.classId,
            () {
          hideLoading();
          if (state.myStudentList != null) {
            if (assignLogic.state.assignHomeworkRequest.classInfos != null &&
                assignLogic.state.assignHomeworkRequest.classInfos!.length >
                    0) {
              if (assignLogic
                  .state.assignHomeworkRequest.classInfos![0].schoolClassId ==
                  widget.classId) {

              }
              state.myStudentList.forEach((element) {

                if(assignLogic.state.assignHomeworkRequest
                    .classInfos![0].studentUserIds!.contains(element.userId)){
                  widget.chooseLogic.addSelected(widget.classId, element, true);
                }
              });
            }
            if (state.pageNo == currentPageNo + 1) {
              studentList.addAll(state!.myStudentList!);
              currentPageNo++;
              if (mounted && _refreshController != null) {
                _refreshController.loadComplete();
                if (!state!.hasMore) {
                  _refreshController.loadNoData();
                } else {
                  _refreshController.resetNoData();
                }

                widget.chooseLogic.addData(
                    widget.classId, state!.myStudentList!);
                setState(() {});
              }
            } else if (state.pageNo == pageStartIndex) {
              currentPageNo = pageStartIndex;
              studentList.clear();
              studentList.addAll(state.myStudentList!);
              if (mounted && _refreshController != null) {
                _refreshController.refreshCompleted();
                if (!state!.hasMore) {
                  _refreshController.loadNoData();
                } else {
                  _refreshController.resetNoData();
                }
                widget.chooseLogic.resetData(
                    widget.classId, state!.myStudentList!);
                setState(() {});
              }
            }
          }
        });
    _onRefresh();
    showLoading("加载中");
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getStudentList(widget.classId);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getStudentList(widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
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
          SliverPadding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                buildItem,
                childCount: studentList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    Student student = studentList[index];

    return Container(
      height: 60.w,
      margin: EdgeInsets.only(left: 22.w, right: 22.w),
      padding: EdgeInsets.only(left: 16.w),
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExtendedImage.network(
                student.avatar ?? "",
                cacheRawData: true,
                width: 36.w,
                height: 36.w,
                fit: BoxFit.fill,
                shape: BoxShape.circle,
                enableLoadState: true,
                loadStateChanged: (state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.completed:
                      return ExtendedRawImage(
                        image: state.extendedImageInfo?.image,
                        fit: BoxFit.cover,
                      );
                    default:
                      return Image.asset(
                        R.imagesStudentHead,
                        fit: BoxFit.fill,
                      );
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(left: 30.w)),
              Text(
                "${student.actualname}",
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff353e4d)),
              ),
            ],
          ),
          GetBuilder<ChooseLogic>(
            id: GetBuilderIds.updateCheckBox + widget.classId,
            builder: (logic) {
              return Util.buildCheckBox(() {
                widget.chooseLogic.addSelected(
                    widget.classId,
                    student,
                    !widget.chooseLogic
                        .isDataSelected(widget.classId, student));
              },
                  chooseEnable: widget.chooseLogic
                      .isDataSelected(widget.classId, student));
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<StudentListLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
