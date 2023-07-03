
import 'package:crazyenglish/pages/chatgpt/models/chat_message.dart';
import 'package:dart_openai/dart_openai.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = "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";
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
