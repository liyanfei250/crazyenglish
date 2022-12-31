import 'package:crazyenglish/entity/paper_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../entity/paper_detail.dart';
import '../../r.dart';
import '../../routes/getx_ids.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import '../../utils/text_util.dart';
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
  CustomRenderMatcher hrMatcher() => (context) => context.tree.element?.localName == 'hr';
  @override
  void initState(){
    super.initState();
    logic.addListenerId(GetBuilderIds.paperDetail,(){
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
        appBar: AppBar(
          backgroundColor: AppColors.c_FFFFFFFF,
          centerTitle: true,
          title: Text("英语周报",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
          leading: Util.buildBackWidget(context),
          // bottom: ,
          elevation: 0,
        ),
        backgroundColor: AppColors.c_FFFAF7F7,
      body: SingleChildScrollView(
        child: GetBuilder<Reading_detailLogic>(
            id: GetBuilderIds.paperDetail,
            builder: (logic){
              if(logic.state.paperDetail.data==null){
                return Container();
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 4.w,
                            height: 12.w,
                            margin: EdgeInsets.only(right: 7.w),
                            color: AppColors.c_FFFFBC00,
                          ),
                          Text(logic.state.paperDetail.data!.createTime??"",style: TextStyle(fontSize: 14.sp,color: AppColors.c_FF282828),)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(R.imagesWeeklyDeBrowse,width: 12.w,height: 12.w,),
                          Padding(padding: EdgeInsets.only(left: 2.w)),
                          Text("${logic.state.paperDetail.data!.viewsCount}",style: TextStyle(fontSize: 12.sp,color: AppColors.TEXT_GRAY_COLOR),)
                        ],
                      )
                    ],
                  ),
                  Html(
                    data: TextUtil.weekDetail.replaceFirst("###content###", logic.state.paperDetail.data!.content??""),
                    shrinkWrap: true,
                    onImageTap: (url,context,attributes,element,){

                    },
                    style: {
                      "p":Style(
                          fontSize:FontSize.large
                      ),
                      "hr":Style(
                        margin: Margins.only(left:0,right: 0,top: 10.w,bottom:10.w),
                        padding: EdgeInsets.all(0),
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      )
                    },
                    // customRenders: {
                    //   hrMatcher(): CustomRender.widget(widget: (context, buildChildren) => Container(
                    //     width: double.infinity,
                    //     color: AppColors.c_FF282828,
                    //   ),),
                    // },
                  )
                ],
              );
            }
        ),
      )
    );
  }

  @override
  void dispose() {
    Get.delete<Reading_detailLogic>();
    super.dispose();
  }
}