import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/review/HomeSecondListDate.dart';
import '../../../entity/home/HomeKingNewDate.dart' as data;
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import 'MenuWidget.dart';
import 'listening_practice_logic.dart';

class ListeningPracticePage extends BasePage {
  data.Obj? type;

  ListeningPracticePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is data.Obj) {
      type = Get.arguments;
    }
  }

  @override
  BasePageState<BasePage> getState() => ToListeningPracticePageState();
}

class ToListeningPracticePageState extends BasePageState<ListeningPracticePage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(Listening_practiceLogic());
  final state = Get.find<Listening_practiceLogic>().state;
  late AnimationController _controller;
  pull.RefreshController _refreshController =
      pull.RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;
  List<Obj> homeSecondListDate = [];
  final int pageStartIndex = 1;
  List listDataOne = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
    {"title": "03.语篇理解", "type": 2},
    {"title": "04.听力填空", "type": 3},
  ];
  List listData = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
    {"title": "03.语篇理解", "type": 2},
    {"title": "04.听力填空", "type": 3},
  ];

  late var textTitle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    logic.getChoiceMap('');

    logic.addListenerId(GetBuilderIds.getHomeListChoiceDate, () {
      if (state.paperDetail != null) {
        /*paperDetail = state.paperDetail;
        if(mounted && _refreshController!=null){
          if(paperDetail!.data!=null
              && paperDetail!.data!.videoFile!=null
              && paperDetail!.data!.videoFile!.isNotEmpty){
          }
          if(paperDetail!.data!=null
              && paperDetail!.data!.audioFile!=null
              && paperDetail!.data!.audioFile!.isNotEmpty){

          }
          setState(() {
          });
        }*/

      }
    });

    logic.addListenerId(
        GetBuilderIds.getHomeSecondListDate + "2"/*widget.type!.id.toString()*/, () {
      hideLoading();
      if (state.homeSecondListDate != null &&
          state.homeSecondListDate != null) {
        if (state.pageNo == currentPageNo + 1) {
          homeSecondListDate = state.homeSecondListDate!;
          currentPageNo++;
          homeSecondListDate.addAll(state.homeSecondListDate!);
          if (mounted && _refreshController != null) {
            _refreshController.loadComplete();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        } else if (state.pageNo == pageStartIndex) {
          currentPageNo = pageStartIndex;
          homeSecondListDate.clear();
          homeSecondListDate.addAll(state!.homeSecondListDate!);
          if (mounted && _refreshController != null) {
            _refreshController.refreshCompleted();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        }
      }
    });
    _onRefresh();
    showLoading("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar(widget.type!.name!),
      backgroundColor: AppColors.theme_bg,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70.w),
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
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      buildItemTop,
                      childCount: homeSecondListDate.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          MenuWidget(
            title: '全部分类',
            items: ['选项1', '选项2', '选项3', '高中十一年级', '选项5', '选项6'],
            onSelected: (index) {
              print('选中了第${index + 1}项');
            },
          ),
        ],
      ),
    );
  }

  Widget buildItemTop(BuildContext context, int index) {
    return InkWell(
      onTap: () {},
      child: listitemBigBg(homeSecondListDate[index]),
    );
  }

  AppBar buildNormalAppBar(String text) {
    return AppBar(
      backgroundColor: AppColors.c_FFFFFFFF,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
      ),
      leading: Util.buildBackWidget(context),
      // bottom: ,
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  @override
  void onCreate() {
    // logic.getPracCords(1, 10);

    // logic.addListenerId(key, () { })
  }

  @override
  void onDestroy() {
    _controller.dispose();
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getList(SpUtil.getInt(BaseConstant.USER_ID), /*widget.type!.id*/ 2,
        pageSize, pageStartIndex);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getList(SpUtil.getInt(BaseConstant.USER_ID), /*widget.type!.id*/ 2,
        pageSize, currentPageNo);
  }

  @override
  void dispose() {
    Get.delete<Listening_practiceLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  Widget listitemBigBg(Obj obj) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: 18.w, right: 18.w, top: 8.w, bottom: 11.w),
                child: Text(
                  obj.journalName ?? '',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            InkWell(
              onTap: () {
                RouterUtil.toNamed(AppRoutes.ResultOverviewPage);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 11.w, right: 2.w),
                child: Text('期刊成绩',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff353e4d),
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 2.w,
                top: 9.w,
                bottom: 11.w,
                right: 18.w,
              ),
              child: Image.asset(
                R.imagesIconToNext,
                color: Color(0xff353e4d),
                fit: BoxFit.cover,
                width: 7.w,
                height: 11.w,
              ),
            ),
          ],
        ),
        Container(
          margin:
              EdgeInsets.only(top: 11.w, left: 18.w, right: 18.w, bottom: 10.w),
          // padding:
          //     EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 10.w),
          width: double.infinity,
          alignment: Alignment.topRight,
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
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return listitemBig(obj.catalogueMergeVo![index], index);
            },
            itemCount: obj.catalogueMergeVo!.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget listitemBig(CatalogueMergeVo value, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: index == 0
                ? BorderRadius.only(topLeft: Radius.circular(7.w))
                : BorderRadius.only(topLeft: Radius.circular(0.w)),
            gradient: LinearGradient(
              colors: [Color(0xfffcefd8), Color(0x0fcefd8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w, left: 17.w),
                  child: Text(
                    value.catalogueMergeName ?? "",
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xffed702d),
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                  child: Text(
                    '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff858aa0),
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                  child: Text(
                    '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xffed702d),
                        fontWeight: FontWeight.w500),
                  )),
              Expanded(child: Text('')),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 17.w, right: 17.w),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return listitem(value.catalogueRecordVoList![index], index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1, color: Color(0xffd2d5dc));
            },
            itemCount: value.catalogueRecordVoList!.length,
          ),
        ),
      ],
    );
  }

  Widget listitem(CatalogueRecordVoList data, int value) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(top: 20.w)),
          Row(
            children: [
              Text(
                data.catalogueName ?? "",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff353e4d)),
              ),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Image.asset(
                R.imagesListenigLastIcon,
                fit: BoxFit.cover,
                width: 26.w,
                height: 18.w,
              ),
              Expanded(child: Text('')),
              Text(
                '正确率' +
                    data.correctCount.toString() +
                    "/" +
                    data.questionCount.toString(),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff858aa0)),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20.w)),
        ],
      ),
    );
  }
}
