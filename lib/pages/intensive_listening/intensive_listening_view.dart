import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/entity/lrc_response.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../r.dart';
import '../../base/AppUtil.dart';
import 'intensive_listening_logic.dart';
import 'intensive_player.dart';

class IntensiveListeningPage extends StatefulWidget {
  const IntensiveListeningPage({Key? key}) : super(key: key);

  @override
  _IntensiveListeningPageState createState() => _IntensiveListeningPageState();
}

class _IntensiveListeningPageState extends State<IntensiveListeningPage> {
  final logic = Get.put(IntensiveListeningLogic());
  final state = Get.find<IntensiveListeningLogic>().state;

  PlayerState? _audioPlayerState;
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;
  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';


  List<LrcResponse> randomList = [];
  late AutoScrollController controller;
  var showTranslate = true.obs;
  var playPosition = 0.obs;
  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),

        axis: Axis.vertical,

    );
    initJson();

    player.setSourceAsset("test_lrc.mp3");

    _initStreams();
  }

  initJson() async{
    String json = await rootBundle.loadString("images/test_lrc_json.json");

    dynamic list = jsonDecode(json);
    list.forEach((v) {
      randomList.add(LrcResponse.fromJson(v));
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text("精听",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,
      ),
      backgroundColor: AppColors.theme_bg,
      body: Column(
        children: [
          Visibility(
              visible: randomList.length>0,
              child: Obx(()=>Text("第${playPosition.value+1}/${randomList.length}句"))),
          Visibility(
            visible: randomList.length>0,
            child: Container(
                height: 500.w,
                child: ListView(
              scrollDirection: Axis.vertical,
              controller: controller,
              children: randomList.map<Widget>((data) {
                final index = data.id??0;
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: controller,
                  index: index,
                  highlightColor: Colors.black.withOpacity(0.1),
                  child: GestureDetector(
                    onTap: (){
                      int length = randomList.length;
                      for(int i = 0;i<length;i++){
                        if(randomList[i].id == index){
                          playPosition.value = i;
                          player.seek(Duration(milliseconds: randomList![playPosition.value].start!));
                        }
                      }
                    },
                    onDoubleTap: (){
                      Fluttertoast.showToast(msg: "收藏句子");
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 4.w,bottom: 4.w),
                      child: Obx(()=>Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SelectionArea(child: Text(data.entext??"",style: TextStyle(fontSize: 16.sp,
                              color: randomList[playPosition.value].id == index? AppColors.c_FF424966:AppColors.c_FF848BA2,
                              fontWeight: randomList[playPosition.value].id == index? FontWeight.bold:FontWeight.normal
                          ),),),
                          Obx(()=>Visibility(visible:showTranslate.value,child: Text(data.cntext??"",style: TextStyle(fontSize: 15.sp,
                              color: randomList[playPosition.value].id == index? AppColors.c_FF424966:AppColors.c_FF848BA2,
                              fontWeight: randomList[playPosition.value].id == index? FontWeight.bold:FontWeight.normal
                          )),)),
                        ],
                      )),
                    ),
                  ),
                );
              }).toList(),
            )),),
          Container(
            margin: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IntensivePlayer(audioPlayer:player),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        if(_isPlaying){
                          if(playPosition.value <= 0){
                            Fluttertoast.showToast(msg: "已经是第一句了");
                          }else{
                            playPosition.value = playPosition.value-1;
                            player.seek(Duration(milliseconds: randomList![playPosition.value].start!));
                          }
                        }
                      },
                      child: Image.asset(R.imagesIconPlayerBeforPlay,width: 18.w,height: 16.w,),

                    ),
                    InkWell(
                      onTap: (){
                        _isPlaying ? _pause() : _play();
                      },
                      child: Image.asset(_isPlaying? R.imagesIconPlayerPause : _isPaused? R.imagesIconPlayerPlay:R.imagesIconPlayerPlay,width: 49.w,height: 49.w,),
                    ),
                    InkWell(
                      onTap: (){
                        if(_isPlaying){
                          if(playPosition.value >= randomList.length-1){
                            Fluttertoast.showToast(msg: "已经是最后一句了");
                          }else{
                            playPosition.value = playPosition.value+1;
                            player.seek(Duration(milliseconds: randomList![playPosition.value].start!));
                          }
                        }
                      },
                      child: Image.asset(R.imagesIconPlayerAfterPlay,width: 18.w,height: 16.w,),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.c_FFF5F6F9,
                      borderRadius: BorderRadius.all(Radius.circular(10.w))
                  ),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){

                        },
                        child: Image.asset(R.imagesIconTransmissionSpeed10,width: 24.w,height: 24.w,),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Image.asset(R.imagesIconIntensiveListeningShowWordNo,width: 24.w,height: 24.w,),
                      ),
                      InkWell(
                        onTap: (){
                          showTranslate.value = !showTranslate.value;
                        },
                        child: Obx(()=>Image.asset(showTranslate.value? R.imagesIconIntensiveListeningTranslateYes:R.imagesIconIntensiveListeningTranslateNo,width: 24.w,height: 24.w,)),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Image.asset(R.imagesIconIntensiveListeningLoopYes,width: 24.w,height: 24.w,),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _initStreams() {
    if(player==null){
      return;
    }

    _positionSubscription = player!.onPositionChanged.listen(
          (p) {
            _position = p;
            if(_position!=null){
              int length = randomList.length;
              for(int i = 0;i<length;i++){
                  if(_position!.inMilliseconds!> randomList[i].start!
                      && _position!.inMilliseconds!< randomList[i].end!){
                    if(playPosition.value != i){
                      playPosition.value = i;
                      // _scrollToCounter(playPosition.value);
                    }
                  }
              }
            }
          },
    );



    _playerCompleteSubscription = player!.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player!.onPlayerStateChanged.listen((state) {
          setState(() {
            _audioPlayerState = state;
          });
        });
  }

  Future _scrollToCounter(int counter) async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.begin);
  }

  Future<void> _play() async {
    final position = _position;
    if(player == null){
      return;
    }
    if (position != null && position.inMilliseconds > 0) {

      await player!.seek(position);
    }
    await player!.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    if(player == null){
      return;
    }
    await player!.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    if(player == null){
      return;
    }
    await player!.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  @override
  void dispose() {
    Get.delete<IntensiveListeningLogic>();
    _stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }
}