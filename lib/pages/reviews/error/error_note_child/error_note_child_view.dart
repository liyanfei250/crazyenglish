import 'package:crazyenglish/pages/reviews/error/error_note_child_list/error_note_child_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../entity/review/ErrorNoteTabDate.dart';
import '../../../../r.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/colors.dart';
import 'error_note_child_logic.dart';

class ErrorNoteChildPage extends StatefulWidget {
  static int WAIT_CORRECT = 0;
  static int HAS_CORRECTED = 1;

  int type;

  ErrorNoteChildPage(this.type, {Key? key}) : super(key: key);

  @override
  _ErrorNoteChildPageState createState() => _ErrorNoteChildPageState();
}

class _ErrorNoteChildPageState extends State<ErrorNoteChildPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ErrorNoteChildLogic());
  final state = Get.find<ErrorNoteChildLogic>().state;
  late TabController _tabController;
  ErrorNoteTabDate? paperDetail;
  //默认1。1听力，2阅读，3语言综合训练，4写作
  List tabs = [
    {"title": "听力", "type": 1},
    {"title": "阅读", "type": 2},
    {"title": "写作", "type": 3},
    {"title": "语法", "type": 4},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    logic.addListenerId(GetBuilderIds.getPracticeRecordList,(){
      if(state.paperDetail!=null){
        paperDetail = state.paperDetail;
        /*if(mounted && _refreshController!=null){
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
    logic.addListenerId(GetBuilderIds.getErrorNoteTabDate,(){

    });
    logic.getTabArrays(1,1,2);


    //获取tab
    logic.addListenerId(GetBuilderIds.getErrorNoteTab,(){

    });
    //获取tab
    logic.getErrorNoteTab(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildBg(),
        Expanded(child: _buildTableBarView())
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<ErrorNoteChildLogic>();
    super.dispose();
  }

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return ErrorNoteChildListPage(widget.type,e['type']);
      }).toList());

  Widget buildBg() => Container(
        margin:
            EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
        width: double.infinity,
        height: 38.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            /*boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(2, 4), // 阴影与容器的距离
              )
            ],*/
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
            color: Color(0xfff2f5fc)),
        child: TabBar(
          onTap: (tab) => print(tab),
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          isScrollable: false,
          controller: _tabController,
          labelColor: Color(0xffffbc00),
          indicatorWeight: 2,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 28),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffffbc00),
          tabs: tabs.map((e) => Tab(text: e['title'])).toList(),
        ),
      );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
