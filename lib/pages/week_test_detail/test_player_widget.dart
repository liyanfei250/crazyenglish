import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../r.dart';

/**
 * Time: 2023/1/4 14:00
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class TestPlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  const TestPlayerWidget({Key? key,required this.player}) : super(key: key);

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

  AudioPlayer get player => widget.player;

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
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.w,
      width: double.infinity,
      child: Stack(
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  _isPlaying ? null : _play();
                },
                child: Image.asset(R.imagesTestPaly,width: 32.w,height: 32.w,),
              ),
              Expanded(child: Slider(
                onChanged: (v) {
                  final duration = _duration;
                  if (duration == null) {
                    return;
                  }
                  final position = v * duration.inMilliseconds;
                  player.seek(Duration(milliseconds: position.round()));
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
            margin: EdgeInsets.only(left: 50.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position != null
                      ? '$_positionText / $_durationText'
                      : _duration != null
                      ? _durationText
                      : '',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text("1X",style: TextStyle(fontSize: 16.0,color: AppColors.TEXT_BLACK_COLOR)),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
          (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
          setState(() {
            _audioPlayerState = state;
          });
        });
  }

  Future<void> _play() async {
    final position = _position;
    if (position != null && position.inMilliseconds > 0) {
      await player.seek(position);
    }
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}
