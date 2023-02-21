import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/entity/lrc_response.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Container();
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