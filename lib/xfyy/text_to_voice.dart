import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

import '../r.dart';
import '../utils/Util.dart';
import '../utils/colors.dart';
import 'utils/xf_socket.dart';

/// 作者： lixp
/// 创建时间： 2022/6/17 10:21
/// 类介绍：文本转语音
class TextToVoice extends StatefulWidget {
  const TextToVoice({Key? key}) : super(key: key);

  @override
  _TextToVoiceState createState() => _TextToVoiceState();
}

class _TextToVoiceState extends State<TextToVoice> {



  final FlutterSoundPlayer playerModule = FlutterSoundPlayer();


  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _editingController2 = TextEditingController();


  var englishTxt = "".obs;
  var vcnTxt = "Laura".obs;

  @override
  void initState() {
    super.initState();

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
        title: Text("语音合成",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "输入需要转换的语音文本"),
              controller: _editingController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "输入需要更改的发言人"),
              controller: _editingController2,
              onChanged: (text){
                vcnTxt.value = text;
              },
            ),
            Obx(() => ElevatedButton(
                onPressed: () {
                  var text = _editingController.text;
                  XfSocket.connect(text,vcnTxt.value, onFilePath: (path) {
                    _play(path);
                  });
                },
                child: Text("采用${vcnTxt.value}播放"))),
            Padding(padding: EdgeInsets.only(top: 20.w)),
            Image.asset(R.imagesXunfei),
            Image.asset(R.imagesXunfeiEnglish)
          ],
        ),
      ),
    );
  }


  void _play(String path) async {
    await playerModule.startPlayer(fromURI: path);
  }
}
