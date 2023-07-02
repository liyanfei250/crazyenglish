import 'package:crazyenglish/pages/chatgpt/controller/settings.dart';
import 'package:crazyenglish/pages/chatgpt/data/glm.dart';
import 'package:crazyenglish/pages/chatgpt/data/if.dart';
import 'package:crazyenglish/pages/chatgpt/data/llm.dart';
import 'package:crazyenglish/pages/chatgpt/repository/conversation.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class MessageRepository {
  static final MessageRepository _instance = MessageRepository._internal();

  factory MessageRepository() {
    return _instance;
  }

  MessageRepository._internal() {
    init();
  }

  void postMessage(Message message, ValueChanged<Message> onResponse,
      ValueChanged<Message> onError, ValueChanged<Message> onSuccess) async {
    List<Message> messages = await ConversationRepository()
        .getMessagesByConversationUUid(message.conversationId);
    _getResponseFromGpt(messages, onResponse, onError, onSuccess);
  }

  void init() {
    OpenAI.apiKey = GetStorage().read('openAiKey') ?? "sk-xx";
    OpenAI.baseUrl = GetStorage().read('openAiBaseUrl') ?? "sk-xx";
  }

  void _getResponseFromGpt(
      List<Message> messages,
      ValueChanged<Message> onResponse,
      ValueChanged<Message> errorCallback,
      ValueChanged<Message> onSuccess) async {
    String llm = SettingsController.to.llm.value;

    switch (llm.toUpperCase()) {
      case "OPENAI":
        ChatGpt().getResponse(messages, onResponse, errorCallback, onSuccess);
        break;
      case "CHATGLM":
        ChatGlM().getResponse(messages, onResponse, errorCallback, onSuccess);
        break;
      case "IF":
        ChatIF().getResponse(messages, onResponse, errorCallback, onSuccess);
        break;
      default:
        ChatGpt().getResponse(messages, onResponse, errorCallback, onSuccess);
    }
  }

  deleteMessage(int messageId) {
    ConversationRepository().deleteMessage(messageId);
  }
}
