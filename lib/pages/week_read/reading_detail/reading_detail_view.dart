import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/entity/paper_category.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/config.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';

import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/paper_detail.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../base/AppUtil.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_util.dart';
import '../../week_test/week_test_detail/test_player_widget.dart';
import 'reading_detail_logic.dart';
import '../../../entity/paper_category.dart' as paper;
import 'torid_page.dart';
import 'package:collection/collection.dart';

class Reading_detailPage extends BasePage {
  paper.Data? data;
  Reading_detailPage({Key? key}) : super(key: key) {
    if(Get.arguments!=null &&
        Get.arguments is paper.Data){
      data = Get.arguments;
    }
  }

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _Reading_detailPageState();
  }
}

class _Reading_detailPageState extends BasePageState<Reading_detailPage> with WidgetsBindingObserver{
  final logic = Get.put(Reading_detailLogic());
  final state = Get.find<Reading_detailLogic>().state;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  PaperDetail? paperDetail;

  audio.AudioPlayer? audioPlayer;
  var hasAudioFile = false.obs;
  StreamController<bool> playerManStreamController = StreamController.broadcast();

  CustomRenderMatcher hrMatcher() => (context) => context.tree.element?.localName == 'hr';
  CustomRenderMatcher pMatcher() => (context) {

    if(context.tree.element!.localName == 'p'){
      if (context.tree.element?.attributes == null ||
          _textIndent(context.tree.element!.attributes.cast()) == null) {
        return false;
      }else{
        if(_textIndent(context.tree.element!.attributes.cast())!.contains("text-indent")){
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }

  };

  CustomRenderMatcher sentenceMatcher() => (context) {

    if(context.tree.element!.localName == 'sentence'){
      String key = context.tree.element!.attributes["value"]??"unknown";
      try {
        int num = int.parse(key);
        if(num>0){
          return true;
        }
      } catch (e) {
        e.printError();
      }
      return false;
    } else {
      return false;
    }

  };

  String? _textIndent(Map<String, String> attributes) {
    return attributes["style"];
  }

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  VideoPlayerController? videoController;
  CustomRenderMatcher videoMatcher() => (context) => context.tree.element?.localName == 'video';
  var playMan = "henry".obs;
  String man = "henry";
  String woman = "catherine";

  // VideoPlayerController? get controller => videoController;
  
  AudioPlayerStateChanged? audioPlayerStateChanged;
  audio.PlayerState playerState = audio.PlayerState.stopped;
  var isVideoPlaying = false.obs;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    logic.addListenerId(GetBuilderIds.paperDetail,(){
      hideLoading();
      if(state.paperDetail!=null){
          paperDetail = state.paperDetail;
          if(mounted && _refreshController!=null){
            if(paperDetail!.data!=null
                && paperDetail!.data!.videoFile!=null
                && paperDetail!.data!.videoFile!.isNotEmpty){
              videoController = VideoPlayerController.network(
                  paperDetail!.data!.videoFile!)
                ..initialize().then((_) {
                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                  setState(() {});
                });
              videoController!.addListener(() {
                if(videoController!.value.isPlaying){
                  isVideoPlaying.value = true;
                }else{
                  isVideoPlaying.value = false;
                }
              });
              // _controller.setLooping(true);
            }
            if(paperDetail!.data!=null
                && paperDetail!.data!.audioFile!=null
                && paperDetail!.data!.audioFile!.isNotEmpty){
              hasAudioFile.value = true;
              audioPlayer = audio.AudioPlayer();
              audioPlayer!.setSourceUrl(paperDetail!.data!.audioFile!);
            }
            // audioPlayer = AudioPlayer();
            // audioPlayer!.setSourceUrl("https://ps-1252082677.cos.ap-beijing.myqcloud.com/test.mp3");
            _refreshController.refreshCompleted();
            setState(() {
            });
          }

      }
    });
    logic.getPagerDetail("${widget.data!.id}");
    showLoading("");
    audioPlayerStateChanged = (playerState){
      this.playerState = playerState;
      if (playerState == audio.PlayerState.playing && videoController!=null) {
        if(videoController!.value.isPlaying){
          videoController!.pause();
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.c_FFFFFFFF,
          centerTitle: true,
          title: Text("",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
          leading: Util.buildBackWidget(context),
          // bottom: ,
          elevation: 0,
          actions: [
            Obx(()=>Visibility(
                visible: !hasAudioFile.value,
                child: Obx(()=>TestPlayerWidget(audioPlayer,TestPlayerWidget.READ_TOP_TYPE,voiceContent: paperDetail!=null ? paperDetail!.data!.voiceContent:"",playerName: playMan.value,stateChangeCallback:audioPlayerStateChanged,playerManStreamController: playerManStreamController)))),
            Container(
              width: 22.w,
              height: 22.w,
              margin: EdgeInsets.only(left:17.w,right: 22.w),
              child: InkWell(
                onTap: (){
                  RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                },
                child: Image.asset(R.imagesArticleCollectDefault),
              ),
            ),
            Obx(()=>Visibility(
                visible: !hasAudioFile.value,
                child: Container(
              width: 22.w,
              height: 22.w,
              margin: EdgeInsets.only(right: 12.w),
              child: InkWell(
                onTap: (){
                  if(playMan.value == man){
                    playMan.value = woman;
                    Util.toast("已切换为女生");
                    playerManStreamController.add(true);
                  }else{
                    playMan.value = man;
                    Util.toast("已切换为男生");
                    playerManStreamController.add(true);
                  }
                  _stopPlay();
                },
                child: Obx(()=>Image.asset(
                    playMan.value == man ?
                    R.imagesArticleManPlay : R.imagesArticleWomanPlay)),
              ),
            )),)
          ],
        ),
        backgroundColor: AppColors.theme_bg,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: GetBuilder<Reading_detailLogic>(
                    id: GetBuilderIds.paperDetail,
                    builder: (logic){
                      if(logic.state.paperDetail.data==null){
                        return Container();
                      }
                      String htmlContent = logic.state.paperDetail.data!.content!;
                      bool hasLargeFile = false;
                      bool hasVideoFile = false;
                      if(logic.state.paperDetail.data!=null && logic.state.paperDetail.data!.largeFile!=null && logic.state.paperDetail.data!.largeFile!.isNotEmpty){
                        htmlContent = "<img src=\"${logic.state.paperDetail.data!.largeFile!}\"/>${logic.state.paperDetail.data!.content!}";
                        hasLargeFile = true;
                      }
                      if(logic.state.paperDetail.data!=null && logic.state.paperDetail.data!.videoFile!=null && logic.state.paperDetail.data!.videoFile!.isNotEmpty){
                        htmlContent = "<video src=\"${logic.state.paperDetail.data!.videoFile!}\"/>${logic.state.paperDetail.data!.content!}";
                        hasVideoFile = true;
                      }
                      // htmlContent = htmlContent.replaceAll('\\"', '"');

                      return Container(
                        padding: EdgeInsets.only(left: 8.w,right: 8.w),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 40.w,
                                  margin: EdgeInsets.only(left: 8.w,right: 8.w,top: 20.w),
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
                                          Image.asset(R.imagesWeeklyDeBrowse,width: 14.w,height: 14.w,),
                                          Padding(padding: EdgeInsets.only(left: 2.w)),
                                          Text("${logic.state.paperDetail.data!.viewsCount}",style: TextStyle(fontSize: 12.sp,color: AppColors.TEXT_GRAY_COLOR),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Visibility(
                                    visible: hasLargeFile|| hasVideoFile,
                                    child: Container(
                                      height: 40.w,
                                      margin: EdgeInsets.only(left: 8.w,right: 8.w,top: 8.w),
                                    )),
                                Padding(padding: EdgeInsets.only(top: 24.w)),
                                SelectionArea(child: Html(
                                  data: TextUtil.weekDetail.replaceFirst("###content###", htmlContent??""),
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
                                    "sentence":Style(
                                        textDecorationStyle: TextDecorationStyle.dashed,
                                        textDecorationColor: AppColors.THEME_COLOR
                                    ),

                                    "hr":Style(
                                      margin: Margins.only(left:0,right: 0,top: 10.w,bottom:10.w),
                                      padding: EdgeInsets.all(0),
                                      border: Border(bottom: BorderSide(color: Colors.grey)),
                                    )
                                  },
                                  tagsList: Html.tags..addAll(['sentence']),
                                  customRenders: {
                                    videoMatcher(): CustomRender.widget(widget: (context, buildChildren){
                                      if(videoController==null){
                                        return SizedBox.shrink();
                                      }
                                      return AspectRatio(
                                        aspectRatio: videoController!.value.isInitialized? videoController!.value.aspectRatio:(16/9),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: <Widget>[
                                            VideoPlayer(videoController!),
                                            Stack(
                                              children: <Widget>[
                                                Obx(()=> isVideoPlaying.value
                                                    ? const SizedBox.shrink(): Container(
                                                  color: Colors.black26,
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 100.0,
                                                      semanticLabel: 'Play',
                                                    ),
                                                  ),
                                                )),
                                                GestureDetector(
                                                  onTap: () {
                                                    if(videoController!=null){
                                                      if(videoController!.value.isPlaying){
                                                        videoController!.pause();
                                                      } else {
                                                        if(playerState == audio.PlayerState.playing && audioPlayer!=null){
                                                          audioPlayer!.pause().then((value) => Future.delayed(Duration(milliseconds: 150),(){
                                                            videoController!.play();
                                                          }));
                                                        }else{
                                                          videoController!.play();
                                                        }
                                                      }
                                                    }

                                                  },
                                                ),
                                              ],
                                            ),
                                            VideoProgressIndicator(videoController!, allowScrubbing: true),
                                          ],
                                        ),
                                      );
                                    }),
                                    tagMatcher("sentence"):CustomRender.inlineSpan(inlineSpan: (context, buildChildren){
                                      context.tree.style.textDecorationColor = AppColors.THEME_COLOR;
                                      context.style.textDecorationColor = AppColors.THEME_COLOR;
                                      context.tree.style.textDecorationStyle = TextDecorationStyle.dashed;
                                      context.style.textDecorationStyle = TextDecorationStyle.dashed;
                                      if (context.parser.selectable) {
                                        return TextSpan(
                                          style: context.style.generateTextStyle(),
                                          children:
                                          context.tree.children
                                              .expandIndexed((i, childTree) => [
                                            context.parser.parseTree(context, childTree),
                                          ])
                                              .toList(),
                                        );
                                      }
                                      return WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: CssBoxWidget.withInlineSpanChildren(
                                          key: context.key,
                                          style: context.tree.style,
                                          shrinkWrap: context.parser.shrinkWrap,
                                          children:
                                          context.tree.children
                                              .expandIndexed((i, childTree) => [
                                            context.parser.parseTree(context, childTree),
                                          ])
                                              .toList(),
                                        ),
                                      );
                                    })
                                    // pMatcher():CustomRender.inlineSpan(inlineSpan: (context, parsedChild) {
                                    //   if (_textIndent(context.tree.element!.attributes.cast()) != null) {
                                    //     // final style = context.tree.element?.styles
                                    //     //     .where((style) => style.property == 'text-indent')
                                    //     //     .first;
                                    //     // print(style?.value?.span);
                                    //     return TextSpan(
                                    //       children: [
                                    //         const WidgetSpan(child: SizedBox(width: 100.0)),
                                    //         WidgetSpan(child: CssBoxWidget.withInlineSpanChildren(
                                    //           children: parsedChild.call(),
                                    //           style: context.style,
                                    //         )),
                                    //       ],
                                    //     );
                                    //   }else{
                                    //     return TextSpan();
                                    //   }
                                    // })
                                  },
                                ),),
                                Visibility(
                                    visible: audioPlayer!=null,
                                    child: SizedBox(
                                      height: 52.w,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),),

              audioPlayer!=null?
              Visibility(
                  visible: audioPlayer!=null,
                  child: TestPlayerWidget(audioPlayer!,TestPlayerWidget.READ_BOTTOM_TYPE,stateChangeCallback:audioPlayerStateChanged)):Container(),
            ],
          ),
          Positioned(child: Container(
            height: 24.w,
            margin: EdgeInsets.only(top: 8.w,right: 8.w),
            alignment: Alignment.topRight,
            child: Builder(builder:(context){
              return InkWell(
                onTap: (){
                  BotToast.showAttachedWidget(attachedBuilder: (_)=>Container(
                    width: double.infinity,
                    height: 370.w,
                    margin: EdgeInsets.only(left: 24.w,right: 24.w),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Image.asset(R.imagesArticleToridNotice,width: 24.w,height: 24.w,),
                        Container(
                          width: double.infinity,
                          height: 341.w,
                          margin: EdgeInsets.only(top: 5.w),
                          decoration: BoxDecoration(
                              color: AppColors.c_FFFFFFFF,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.w),
                                bottomRight: Radius.circular(12.w),
                                topLeft: Radius.circular(12.w),
                              )
                          ),
                          child: TORID_Widget(),
                        )
                      ],
                    ),
                  ),
                    targetContext: context,
                    backgroundColor:AppColors.c_80000000,
                    preferDirection: PreferDirection.bottomRight,
                  );
                },

                child: Image.asset(R.imagesArticleToridNotice,width: 24.w,height: 24.w,),
              );
            }),
          ),)
        ],
      )
    );
  }


  void _stopPlay() {
    // playerModule.stopPlayer();
    if(audioPlayer!=null){
      audioPlayer!.stop();
    }
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
      //  应用程序处于闲置状态并且没有收到用户的输入事件。
      //注意这个状态，在切换到后台时候会触发，所以流程应该是先冻结窗口，然后停止UI
        print('YM----->AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
//      应用程序处于不可见状态
        if(audioPlayer!=null){
          audioPlayer!.pause();
        }
        if(videoController!=null){
          if(videoController!.value.isPlaying){
            videoController!.pause();
          }
        }
        if(playerManStreamController!=null){
          playerManStreamController.add(true);
        }
        break;
      case AppLifecycleState.resumed:
        print('YM----->AppLifecycleState.resumed');
        break;
      case AppLifecycleState.detached:
      //当前页面即将退出
        print('YM----->AppLifecycleState.detached');
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Get.delete<Reading_detailLogic>();
    if(audioPlayer!=null){
      audioPlayer!.release();
    }
    if(videoController!=null){
      videoController!.dispose();
    }
    if(playerManStreamController!=null){
      playerManStreamController.add(true);
    }
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

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? Container()
              : Container(
            color: Colors.black26,
            child: const Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(controller.value.isPlaying){
              controller.pause();
            } else {

              controller.play();
            }
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}