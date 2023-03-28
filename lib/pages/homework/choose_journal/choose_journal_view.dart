import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkJournalResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../base_choose_page_state.dart';
import 'choose_journal_logic.dart';

class ChooseJournalPage extends BasePage {
  const ChooseJournalPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ChooseJournalPageState();
}

class _ChooseJournalPageState extends BaseChoosePageState<ChooseJournalPage,HomeworkJournalResponse> {
  final logic = Get.put(ChooseJournalLogic());
  final state = Get.find<ChooseJournalLogic>().state;

  @override
  String getDataId(String key,HomeworkJournalResponse n) {
    assert(n.id !=null);
    return n.id!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: [
          Image.asset(R.imagesTeacherClassTop,width: double.infinity),
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
                  margin: EdgeInsets.only(left: 19.w,bottom:19.w,top:35.w,right: 19.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.w)),
                  ),
                  child: Column(
                    children: [

                    ],
                  ),
                ),
              ),
              buildBottomWidget()
            ],
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
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}