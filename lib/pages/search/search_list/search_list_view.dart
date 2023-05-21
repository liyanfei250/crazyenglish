import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/pages/search/home_search/home_search_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;
import '../../../entity/home/HomeSearchListDate.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../entity/week_list_response.dart' as newData;

//？搜索？
class SearchListPage extends BasePage {
  int type; //第几个tab
  int typeTwo; //格式
  //搜索类型 1：期刊 2：商城 3：学生
  final int JOURNALS_FORMAT = 1;
  final int STUDENT_FORMAT = 3;

  SearchListPage(this.type, this.typeTwo, {Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToSearchListPageState();
}

class _ToSearchListPageState extends BasePageState<SearchListPage> {
  final searchLogic = Get.find<Home_searchLogic>();
  final state = Get.find<Home_searchLogic>().state;
  pull.RefreshController _refreshController =
      pull.RefreshController(initialRefresh: false);
  CancelFunc? _cancelLoading;
  List<Records> listJ = [];
  List<RecordsS> listS = [];

  @override
  void initState() {
    super.initState();

    //TODO 输入之后不能直接监听显示
    searchLogic.addListenerId(GetBuilderIds.getHomeSearchDate, () {
      hideLoading();
      if (widget.type == 4) {
        searchLogic.state.searchType = 3;
        if (state.listS != null) {
          if (state.pageNoS == state.currentPageNoS + 1) {
            state.currentPageNoS++;
            listS.addAll(state!.listS!);
            if (mounted && _refreshController != null) {
              _refreshController.loadComplete();
              if (!state!.hasMoreS) {
                _refreshController.loadNoData();
              } else {
                _refreshController.resetNoData();
              }
              setState(() {});
            }
          } else if (state.pageNoS == state.pageStartIndex) {
            state.currentPageNoS = state.pageStartIndex;
            listS.clear();
            listS.addAll(state.listS!);
            if (mounted && _refreshController != null) {
              _refreshController.refreshCompleted();
              if (!state!.hasMoreS) {
                _refreshController.loadNoData();
              } else {
                _refreshController.resetNoData();
              }
              setState(() {});
            }
          }
        }
      }
      if (widget.type == 1 || widget.type == 2 || widget.type == 3) {
        searchLogic.state.searchType = 1;
        if (state.listJ != null) {
          if (state.pageNoj == state.currentPageNoj + 1) {
            state.currentPageNoj++;
            listJ.addAll(state!.listJ!);
            if (mounted && _refreshController != null) {
              _refreshController.loadComplete();
              if (!state!.hasMorej) {
                _refreshController.loadNoData();
              } else {
                _refreshController.resetNoData();
              }
              setState(() {});
            }
          } else if (state.pageNoj == state.pageStartIndex) {
            state.currentPageNoj = state.pageStartIndex;
            listJ.clear();
            listJ.addAll(state.listJ!);
            if (mounted && _refreshController != null) {
              _refreshController.refreshCompleted();
              if (!state!.hasMorej) {
                _refreshController.loadNoData();
              } else {
                _refreshController.resetNoData();
              }
              setState(() {});
            }
          }
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: pull.SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: pull.WaterDropHeader(),
          footer: pull.CustomFooter(
            builder: (BuildContext context, pull.LoadStatus? mode) {
              Widget body;
              if (mode == pull.LoadStatus.idle) {
                body = Text("");
              } else if (mode == pull.LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == pull.LoadStatus.failed) {
                body = Text("");
              } else if (mode == pull.LoadStatus.canLoading) {
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
              getLayout(),
            ],
          ),
        ));
  }

  Widget listitemBigBg(BuildContext context, int index) {
    if (widget.typeTwo == widget.STUDENT_FORMAT) {
      return returnStudentLayout(listS[index]);
    } else if (widget.typeTwo == widget.JOURNALS_FORMAT) {
      return returnNormalLayout(listJ[index]);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget returnStudentLayout(RecordsS recordsS) {
    return buildItem(recordsS);
  }

  Widget buildItem(RecordsS recordsS) {
    return InkWell(
      onTap: () {
        RouterUtil.toNamed(AppRoutes.TEACHER_STUDENT,
            arguments: {'studentId': recordsS.userId});
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.w, left: 22.w, right: 22.w),
        padding: EdgeInsets.only(left: 16.w, top: 14.w, bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.center,
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1.0),
              child: Image.network(
                recordsS.avatar ??
                    "https://pics0.baidu.com/feed/0b55b319ebc4b74531587bda64b9f91c888215fb.jpeg@f_auto?token=c5e40b1e9aa7359c642904f84b564921",
                width: 72.w,
                height: 72.w,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(1.0),
                      child: Image(
                        image: AssetImage(R.imagesStudentHead),
                        width: 72.w,
                        height: 72.w,
                        fit: BoxFit.fill,
                      ));
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15.w)),
            Container(
              height: 72.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildItemClassStudent('姓名：', recordsS.actualname ?? ''),
                  buildItemClassStudent('班级：', recordsS.className ?? ''),
                  buildItemClassStudent(
                      '努力值：', (recordsS.effort ?? 0).toString()),
                  buildItemClassStudent(
                      '学习时长：', (recordsS.studyTime ?? 0).toString()),
                  buildItemClassStudent(
                      '答题总数：', (recordsS.totalSize ?? 0).toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemClassStudent(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
        Text(
          second,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
      ],
    );
  }

  Container returnShopLayout() {
    return Container(
      margin: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 0.w, top: 16.w),
      padding:
          EdgeInsets.only(left: 22.w, right: 22.w, top: 16.w, bottom: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            child: Image.asset(
              R.imagesShopImageLogoTest,
              width: 80.w,
              height: 80.w,
            ),
          ),
          Expanded(
            child: Container(
                height: 80.w,
                margin: EdgeInsets.only(left: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "英语周刊 年度订阅",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff3e454e)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "everyones heart have a hero",
                      style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff8a9098),
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "￥199.00",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff353e4d),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Container returnNormalLayout(Records records) {
    return Container(
      margin: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 0.w, top: 16.w),
      padding:
          EdgeInsets.only(left: 18.w, right: 18.w, top: 12.w, bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          newData.Obj updatedObj = updateObj(records);
          RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
              arguments: updatedObj);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(11)),
              child: Image.asset(
                R.imagesSearchPlaceIc,
                width: 52.w,
                height: 74.w,
              ),
            ),
            Expanded(
              child: Container(
                  height: 74.w,
                  margin: EdgeInsets.only(left: 14.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        records.name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff3e454e)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        records.createTime ?? "",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff898a93),
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${records.journalView}阅读",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff8b8f94),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    searchLogic.state.currentPageNoj = searchLogic.state.pageStartIndex;
    searchLogic.state.currentPageNoS = searchLogic.state.pageStartIndex;

    //搜索数据，之后数据更新
    searchLogic.getSearchList(
        searchLogic.state.searchText,
        searchLogic.state.searchType,
        SpUtil.getInt(BaseConstant.USER_ID),
        searchLogic.state.pageStartIndex,
        searchLogic.state.pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    searchLogic.getSearchList(
        searchLogic.state.searchText,
        searchLogic.state.searchType,
        SpUtil.getInt(BaseConstant.USER_ID),
        widget.type == 4
            ? searchLogic.state.currentPageNoS + 1
            : searchLogic.state.currentPageNoj + 1,
        searchLogic.state.pageSize);
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Widget getLayout() {
    if (widget.typeTwo == widget.JOURNALS_FORMAT) {
      return listJ.length > 0
          ? SliverList(
              delegate: SliverChildBuilderDelegate(
                listitemBigBg,
                childCount: listJ.length,
              ),
            )
          : SliverToBoxAdapter(
              child: PlaceholderPage(
                  imageAsset: R.imagesCommenNoDate,
                  title: '没有找到与"${searchLogic.state.searchText}"相关的结果',
                  topMargin: 50.w,
                  subtitle: ''),
            );
    }
    if (widget.typeTwo == widget.STUDENT_FORMAT) {
      return listS.length > 0
          ? SliverList(
              delegate: SliverChildBuilderDelegate(
                listitemBigBg,
                childCount: listS.length,
              ),
            )
          : SliverToBoxAdapter(
              child: PlaceholderPage(
                  imageAsset: R.imagesCommenNoDate,
                  title: '没有找到与"${searchLogic.state.searchText}"相关的结果',
                  topMargin: 50.w,
                  subtitle: ''),
            );
    }
    return Container();
  }

  newData.Obj updateObj(Records obj,
      {int? id,
      String? name,
      int? affiliatedGrade,
      int? schoolYear,
      int? periodsNum,
      bool? status,
      bool? isDelete,
      int? journalView,
      String? createTime,
      int? createUser}) {
    return newData.Obj(
      id: id ?? int.parse(obj.id!),
      name: name ?? obj.name,
      affiliatedGrade: affiliatedGrade ?? obj.affiliatedGrade,
      schoolYear: schoolYear ?? obj.schoolYear,
      periodsNum: periodsNum ?? obj.periodsNum,
      status: status ?? obj.status,
      isDelete: isDelete ?? obj.isDelete,
      journalView: journalView ?? obj.journalView,
      createTime: createTime ?? obj.createTime,
      createUser: createUser ?? obj.createUser,
    );
  }
}
