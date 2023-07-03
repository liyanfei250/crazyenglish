import 'package:crazyenglish/pages/chatgpt/data/llm.dart';
import 'package:crazyenglish/pages/chatgpt/repository/conversation.dart';
import 'package:flutter/foundation.dart';

class ChatIF extends LLM {
  @override
  getResponse(
      List<Message> messages,
      ValueChanged<Message> onResponse,
      ValueChanged<Message> errorCallback,
      ValueChanged<Message> onSuccess) async {
    // TODO: implement getResponse
    throw UnimplementedError();
  }
}
