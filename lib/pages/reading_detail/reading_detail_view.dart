import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/entity/paper_category.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/widgetPage/dialog_manager.dart';
import '../../entity/paper_detail.dart';
import '../../r.dart';
import '../../routes/getx_ids.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import '../../utils/text_util.dart';
import '../../xfyy/utils/xf_socket.dart';
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

  final FlutterSoundPlayer playerModule = FlutterSoundPlayer();

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
    initPlay();
  }




  /// 初始化播放
  initPlay() async {
    await playerModule.closePlayer();
    await playerModule.openPlayer();
    await playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));
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
          actions: [
            Container(
              width: 22.w,
              height: 22.w,
              margin: EdgeInsets.only(right: 22.w),
              child: InkWell(
                onTap: (){
                  if(paperDetail!=null
                      && paperDetail!.data!=null){
                    if(paperDetail!.data!.voiceContent!=null
                        && paperDetail!.data!.voiceContent!.isNotEmpty){
                      XfSocket.connect(paperDetail!.data!.voiceContent!,"John", onFilePath: (path) {
                        _play(path);
                      });
                    }else if(paperDetail!.data!.titleEn!=null){
                      XfSocket.connect(paperDetail!.data!.titleEn!,"John", onFilePath: (path) {
                        _play(path);
                      });
                    }

                  }

                },
                child: Image.asset(R.imagesArticleListenDerfault),
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              margin: EdgeInsets.only(right: 22.w),
              child: InkWell(
                onTap: (){

                },
                child: Image.asset(R.imagesArticleCollectDefault),
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              margin: EdgeInsets.only(right: 12.w),
              child: InkWell(
                onTap: (){

                },
                child: Image.asset(R.imagesArticleShare),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.c_FFFAF7F7,
      body: SingleChildScrollView(
        child: GetBuilder<Reading_detailLogic>(
            id: GetBuilderIds.paperDetail,
            builder: (logic){
              if(logic.state.paperDetail.data==null){
                return Container();
              }
              String htmlContent = logic.state.paperDetail.data!.content!;
              bool hasLargeFile = false;
              if(logic.state.paperDetail.data!=null && logic.state.paperDetail.data!.largeFile!=null && logic.state.paperDetail.data!.largeFile!.isNotEmpty){
                htmlContent = "<img src=\"${logic.state.paperDetail.data!.largeFile!}\"/>${logic.state.paperDetail.data!.content!}";
                hasLargeFile = true;
              }
              return Container(
                padding: EdgeInsets.only(left: 8.w,right: 8.w),
                child: Stack(
                  children: [
                    Container(
                      height: 40.w,
                      margin: EdgeInsets.only(left: 8.w,right: 8.w,top: 8.w),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                    ),
                    Column(
                      children: [
                        Visibility(
                            visible: hasLargeFile,
                            child: Container(
                              height: 40.w,
                              margin: EdgeInsets.only(left: 8.w,right: 8.w,top: 8.w),
                            )),
                        Html(
                          data: TextUtil.weekDetail.replaceFirst("###content###", htmlContent??""),
                          shrinkWrap: true,
                          onImageTap: (url,context,attributes,element,){
                            if(url!=null && url!.startsWith('http')){
                              DialogManager.showPreViewImageDialog(
                                  BackButtonBehavior.close, url);
                            }
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
                        )
                      ],
                    )

                  ],
                ),
              );
            }
        ),
      )
    );
  }

  void _play(String path) async {
    await playerModule.startPlayer(fromURI: path);
  }

  @override
  void dispose() {
    Get.delete<Reading_detailLogic>();
    super.dispose();
  }
}