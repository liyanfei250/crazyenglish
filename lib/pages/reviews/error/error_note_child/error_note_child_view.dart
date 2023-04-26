import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/pages/reviews/error/error_note_child_list/error_note_child_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../entity/home/HomeKingDate.dart';
import '../../../../routes/getx_ids.dart';
import 'error_note_child_logic.dart';

class ErrorNoteChildPage extends StatefulWidget {
  static int WAIT_CORRECT = 0;
  static int HAS_CORRECTED = 1;
  List<Obj>? tablist;
  int type;

  ErrorNoteChildPage(this.type, {Key? key,List<Obj>? tablist}) : super(key: key){
    this.tablist = tablist;
  }

  @override
  _ErrorNoteChildPageState createState() => _ErrorNoteChildPageState();
}

class _ErrorNoteChildPageState extends State<ErrorNoteChildPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ErrorNoteChildLogic());
  final state = Get.find<ErrorNoteChildLogic>().state;
  late TabController _tabController;
  HomeKingDate? paperDetail;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tablist!.length);
    logic.addListenerId(GetBuilderIds.getPracticeRecordList, () {
      if (state.paperDetail != null) {
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


    //获取tab
    // logic.addListenerId(GetBuilderIds.getErrorNoteTab, () {});
    // //获取tab
    // logic.getErrorNoteTab(0);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildBg(), Expanded(child: _buildTableBarView())],
    );
  }

  @override
  void dispose() {
    Get.delete<ErrorNoteChildLogic>();
    super.dispose();
  }

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: widget.tablist!.map((e) {
        return ErrorNoteChildListPage(widget.type, e.value!.toInt());
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
          isScrollable: true,
          controller: _tabController,
          labelColor: Color(0xffffbc00),
          indicatorWeight: 2,
          // indicatorPadding: const EdgeInsets.symmetric(horizontal: 28),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffffbc00),
          tabs: widget.tablist!.map((e) => Tab(text: e.name)).toList(),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
