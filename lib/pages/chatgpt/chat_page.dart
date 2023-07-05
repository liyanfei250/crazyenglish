import 'package:crazyenglish/pages/chatgpt/api/chat_api.dart';
import 'package:crazyenglish/pages/chatgpt/components/chat.dart';
import 'package:crazyenglish/pages/chatgpt/components/conversation.dart';
import 'package:crazyenglish/pages/chatgpt/controller/conversation.dart';
import 'package:crazyenglish/pages/chatgpt/controller/message.dart';
import 'package:crazyenglish/pages/chatgpt/controller/prompt.dart';
import 'package:crazyenglish/pages/chatgpt/controller/settings.dart';
import 'package:crazyenglish/pages/chatgpt/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.chatApi,
    super.key,
  });

  final ChatApi chatApi;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = <ChatMessage>[
    ChatMessage('Hello, how can I help?', false),
  ];
  var _awaitingResponse = false;


  @override
  void initState() {
    super.initState();
    Get.put(SettingsController());
    Get.put(ConversationController());
    Get.put(MessageController());
    Get.put(PromptController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      drawer: const ConversationWindow(),
      body: const ChatWindow(),
    );
  }

  @override
  void dispose() {
    Get.delete<SettingsController>();
    Get.delete<ConversationController>();
    Get.delete<MessageController>();
    Get.delete<PromptController>();
    super.dispose();

  }
}
