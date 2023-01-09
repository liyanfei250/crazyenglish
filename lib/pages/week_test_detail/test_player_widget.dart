import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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
class TestPlayerWidget extends StatefulWidget {
  AudioPlayer? player;
  final bool isBottomPlayer;
  String? voiceContent;
  String? playerName;

  TestPlayerWidget(this.player,this.isBottomPlayer,{Key? key,String ? voiceContent,String? playerName}) : super(key: key) {
    if(voiceContent!=null){
      this.voiceContent = voiceContent;
    }
    if(playerName!=null){
      this.playerName = playerName;
    }

  }

  @override
  State<TestPlayerWidget> createState() => _TestPlayerWidgetState();
}

class _TestPlayerWidgetState extends State<TestPlayerWidget> {
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
                  XfSocket.connect(widget.voiceContent!,widget.playerName!, onFilePath: (path) {
                    widget.player = AudioPlayer();
                    player!.setSourceDeviceFile(path);
                    _initStreams();
                    _play();
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
            _audioPlayerState = state;
          });
        });
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
}
