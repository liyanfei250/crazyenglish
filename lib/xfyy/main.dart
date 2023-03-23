import 'package:flutter/material.dart';

import 'text_to_voice.dart';
import 'voice_to_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return const TextToVoice();
                    }));
                  },
                  child: const Text("语音合成")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return const VoiceText();
                    }));
                  },
                  child: const Text("语音识别")),
            ],
          ),
        ));
  }
}
