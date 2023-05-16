import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkJournalResponse.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../entity/week_list_response.dart' as Date;
import '../../../base/common.dart' as common;
import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../assign_homework/assign_homework_logic.dart';
import '../base_choose_page_state.dart';
import '../choose_logic.dart';
import 'choose_journal_logic.dart';

class ChooseJournalPage extends BasePage {
  const ChooseJournalPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ChooseJournalPageState();
}

class _ChooseJournalPageState
    extends BaseChoosePageState<ChooseJournalPage, Date.Obj> {
  final logic = Get.put(ChooseJournalLogic());
  final state = Get.find<ChooseJournalLogic>().state;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final assignLogic = Get.find<AssignHomeworkLogic>();
  final int pageSize = 20;
  int currentPageNo = 1;
  List<Date.Obj> journals = [];
  final int pageStartIndex = 1;

  @override
  String getDataId(String key, Date.Obj n) {
    assert(n.id != null);
    return n.id!.toString();
  }

  @override
  void onCreate() {
    currentKey.value = "0";
    logic.addListenerId(GetBuilderIds.getJournalList, () {
      hideLoading();
      if (state.list != null) {
        if ((assignLogic.state.assignHomeworkRequest.journalId ?? "")
            .isNotEmpty) {
          state.list.forEach((element) {
            if ("${element.id}" ==
                assignLogic.state.assignHomeworkRequest.journalId) {
              addSelected(currentKey.value, element, true);
            }
          });
        }
        if (state.pageNo == currentPageNo + 1) {
          journals.addAll(state!.list!);
          currentPageNo++;
          if (mounted && _refreshController != null) {
            _refreshController.loadComplete();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }

            addData(currentKey.value, state!.list!);
            setState(() {});
          }
        } else if (state.pageNo == pageStartIndex) {
          currentPageNo = pageStartIndex;
          journals.clear();
          journals.addAll(state.list!);
          if (mounted && _refreshController != null) {
            _refreshController.refreshCompleted();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            resetData(currentKey.value, state!.list!);
            setState(() {});
          }
        }
      }
    });
    _onRefresh();
    showLoading("加载中");
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
                    Text("期刊选择"),
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
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
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
                              childCount: journals.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 53.w, bottom: 30.w, right: 58.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                      List<Date.Obj> journals = [];
                      dataList.forEach((key, value) {
                        if (value != null) {
                          for (Date.Obj n in value!) {
                            String id = getDataId(key, n);
                            if (isSelectedMap[key] != null &&
                                (isSelectedMap[key]![id] ?? false)) {
                              journals.add(n);
                            }
                          }
                        }
                      });
                      if (journals.isNotEmpty) {
                        assignLogic.updateAssignHomeworkRequest(
                            paperType: common.PaperType.Journals,
                            journalId: journals[0]!.id!.toString(),
                            journalDesc: journals[0].name.toString());
                      } else {
                        assignLogic.updateAssignHomeworkRequest(
                          paperType: -1,
                        );
                      }
                      Get.back();
                    }, "完成")
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getJournalList(null, pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getJournalList(null, currentPageNo + 1, pageSize);
  }

  Widget buildItem(BuildContext context, int index) {
    Date.Obj student = journals[index];

    return Container(
      height: 80.w,
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
                journals[index].coverImg ?? "",
                cacheRawData: true,
                width: 54.w,
                height: 54.w,
                fit: BoxFit.fill,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6.w)),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${student.name}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff353e4d)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 6.w)),
                  Text(
                    student.createTime ?? '',
                    style: TextStyle(fontSize: 11.sp, color: Color(0xff898a93)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 4.w)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        R.imagesHomeworkJournalGrayBrowse,
                        width: 10.w,
                        height: 10.w,
                      ),
                      Padding(padding: EdgeInsets.only(left: 4.w)),
                      Text(
                        "${student.journalView}",
                        style:
                            TextStyle(fontSize: 8.sp, color: Color(0xff898a93)),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          GetBuilder<ChooseLogic>(
            id: GetBuilderIds.updateCheckBox + currentKey.value,
            builder: (logic) {
              return Util.buildCheckBox(() {
                selectSingle(currentKey.value,student);
              }, chooseEnable: isDataSelected(currentKey.value, student));
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ChooseJournalLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
