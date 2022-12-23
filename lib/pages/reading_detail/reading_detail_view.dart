import 'package:crazyenglish/entity/paper_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../entity/paper_detail.dart';
import '../../routes/getx_ids.dart';
import 'reading_detail_logic.dart';
import '../../entity/paper_category.dart' as paper;

class Reading_detailPage extends StatefulWidget {
  paper.Data? data;
  Reading_detailPage({Key? key}) : super(key: key) {
    if(Get.arguments!=null &&
        Get.arguments is paper.Data){
      data = Get.arguments;
    }
  }

  @override
  _Reading_detailPageState createState() => _Reading_detailPageState();
}

class _Reading_detailPageState extends State<Reading_detailPage> {
  final logic = Get.put(Reading_detailLogic());
  final state = Get.find<Reading_detailLogic>().state;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  PaperDetail? paperDetail;
  @override
  void initState(){
    super.initState();
    logic.addListenerId(GetBuilderIds.weekList,(){
      if(state.paperDetail!=null){
          paperDetail = state.paperDetail;
          if(mounted && _refreshController!=null){
            _refreshController.refreshCompleted();
            setState(() {
            });
          }

      }
    });
    logic.getPagerDetail("${widget.data!.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Reading_detailLogic>(
        id: GetBuilderIds.paperDetail,
        builder: (logic){
          return Container();
      }
    ));
  }

  @override
  void dispose() {
    Get.delete<Reading_detailLogic>();
    super.dispose();
  }
}