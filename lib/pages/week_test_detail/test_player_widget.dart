import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../r.dart';
import '../../xfyy/utils/xf_socket.dart';

/**
 * Time: 2023/1/4 14:00
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

typedef AudioPlayerStateChanged = Function(PlayerState playerState);

class TestPlayerWidget extends BasePage {
  AudioPlayer? player;
  final bool isBottomPlayer;
  String? voiceContent;
  String? playerName;
  AudioPlayerStateChanged? stateChangeCallback;
  StreamController? playerManStreamController;

  TestPlayerWidget(this.player,this.isBottomPlayer,{Key? key,String ? voiceContent,String? playerName,AudioPlayerStateChanged? stateChangeCallback,StreamController? playerManStreamController}) : super(key: key) {
    if(voiceContent!=null){
      this.voiceContent = voiceContent;
    }
    if(playerName!=null){
      this.playerName = playerName;
    }
    if(stateChangeCallback!=null){
      this.stateChangeCallback = stateChangeCallback;
    }
    if(playerManStreamController!=null){
      this.playerManStreamController = playerManStreamController;
    }
  }

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _TestPlayerWidgetState();
  }
}

class _TestPlayerWidgetState extends BasePageState<TestPlayerWidget> {
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  StreamSubscription? _womanManStreamSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;
  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer? get player => widget.player;

  @override
  void initState() {
    super.initState();
    _initStreams();
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    _womanManStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isBottomPlayer){
      return Container(
        height: 79.w,
        width: double.infinity,
        color: AppColors.c_FFF2F2F2,
        padding: EdgeInsets.only(left: 14.w),
        child: Stack(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    _isPlaying ? _pause() : _play();
                  },
                  child: Image.asset(
                    _isPlaying? R.imagesTestPause : _isPaused? R.imagesTestPlay:R.imagesTestPlay,
                    width: 32.w,height: 32.w,),
                ),
                Expanded(child: Slider(
                  onChanged: (v) {
                    final duration = _duration;
                    if (duration == null) {
                      return;
                    }
                    final position = v * duration.inMilliseconds;
                    if(player!=null){
                      player!.seek(Duration(milliseconds: position.round()));
                    }

                  },
                  activeColor: AppColors.c_FFFFBC00,
                  inactiveColor: AppColors.c_FFE2E2E2,
                  value: (_position != null &&
                      _duration != null &&
                      _position!.inMilliseconds > 0 &&
                      _position!.inMilliseconds < _duration!.inMilliseconds)
                      ? _position!.inMilliseconds / _duration!.inMilliseconds
                      : 0.0,
                ),)
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(left: 50.w,right: 31.w,bottom: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("",style: TextStyle(fontSize: 12.sp,color: AppColors.TEXT_BLACK_COLOR)),
                  Text(
                    _position != null
                        ? '$_positionText / $_durationText'
                        : _duration != null
                        ? "0:00:00/"+_durationText
                        : '',
                    style: TextStyle(fontSize: 12.sp,color: AppColors.TEXT_GRAY_COLOR),
                  ),

                ],
              ),
            )
          ],
        ),
      );
    }else{
      return Container(
          width: 22.w,
          height: 22.w,
          child: InkWell(
            onTap: (){
              if(widget.voiceContent!=null
                  && widget.voiceContent!.isNotEmpty){
                if(player == null){
                  showLoading("");
                  XfSocket.connect(widget.voiceContent!,widget.playerName!, onFilePath: (path) {
                    widget.player = AudioPlayer();
                    print("onFilePath maked");
                    _initStreams();
                    _firstPlay(path);
                    hideLoading();
                  });
                }else{
                  _isPlaying ? _pause() : _play();
                }

              }else {
                Fluttertoast.showToast(msg: "暂无播放内容");
              }


            },
            child: Image.asset(
              _isPlaying!=null ? (_isPlaying? R.imagesArticleListenPause :
    _isPaused? R.imagesArticleListenPlay:R.imagesArticleListenPlay):R.imagesArticleListenPlay,
              width: 22.w,height: 22.w,),
          ),
        );
    }

  }

  void _initStreams() {
    if(player==null){
      return;
    }
    _womanManStreamSubscription = widget.playerManStreamController?.stream.listen((event) {
      if(event is bool){
        if(event){
          _pause();
        }
      }
    });
    _durationSubscription = player!.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player!.onPositionChanged.listen(
          (p) => setState(() => _position = p),
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
            if(widget.stateChangeCallback!=null){
              widget.stateChangeCallback!(_playerState);
            }
            _playerState = state;
          });
        });
  }

  Future<void> _play() async {
    final position = _position;
    print("position");
    if(player == null){
      print("player == null");
      return;
    }
    if (position != null && position.inMilliseconds > 0) {
      print("position != null");
      await player!.seek(position);
    }
    print("player resume");
    await player!.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _firstPlay(String source) async {
    final position = _position;
    print("position");
    if(player == null){
      print("player == null");
      return;
    }
    if (position != null && position.inMilliseconds > 0) {
      print("position != null");
      await player!.seek(position);
    }
    print("player resume");
    player!.play(DeviceFileSource(source));
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
    XfSocket.close();
    await player!.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
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
