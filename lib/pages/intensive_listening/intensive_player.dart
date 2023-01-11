import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

/**
 * Time: 2023/1/10 14:37
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class IntensivePlayer extends StatefulWidget {
  AudioPlayer audioPlayer;
  IntensivePlayer({Key? key,required this.audioPlayer}) : super(key: key);

  @override
  State<IntensivePlayer> createState() => _IntensivePlayerState();
}

class _IntensivePlayerState extends State<IntensivePlayer> {

  AudioPlayer? get player => widget.audioPlayer;
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initStreams();
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
        _position = Duration.zero;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
    );
  }
}
