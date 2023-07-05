import 'dart:math';

import 'package:crazyenglish/pages/chatgpt/components/markdown.dart';
import 'package:crazyenglish/pages/chatgpt/components/prompts.dart';
import 'package:crazyenglish/pages/chatgpt/controller/conversation.dart';
import 'package:crazyenglish/pages/chatgpt/controller/message.dart';
import 'package:crazyenglish/pages/chatgpt/controller/prompt.dart';
import 'package:crazyenglish/pages/chatgpt/repository/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class ChatWindow extends StatefulWidget {
  const ChatWindow({super.key});

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // 定义一个 GlobalKey
  final _scrollController = ScrollController();
  List<Message> messageList = <Message>[];
  MessageController? controllerMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerMessage = Get.find();
    controllerMessage!.addListenerId(ConversationController.ConversationMachine, () {
      setState(() {
        messageList.clear();
        messageList.addAll(controllerMessage!.messageList.value);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToNewMessage();
        });
      });
    });
    controllerMessage!.loadAndUpdateMessages(ConversationController.ConversationMachine);
    // Future.delayed(new Duration(milliseconds: 400),(){
    //   ConversationController controller = Get.find();
    //   controller.currentConversationUuid(ConversationController.ConversationMachine);
    //   MessageController controllerMessage = Get.find();
    //   controllerMessage.loadAndUpdateMessages(ConversationController.ConversationMachine);
    // });
  }


  @override
  void dispose() {
    if(controllerMessage!=null) {
      controllerMessage!.disposeId(ConversationController.ConversationMachine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messageList.length,
              itemBuilder: (context, index) {
                return _buildMessageCard(messageList[index]);
              },),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey, // 将 GlobalKey 赋值给 Form 组件的 key 属性
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: _handleKeyEvent,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "inputPrompt".tr,
                        hintText: "inputPromptTips".tr,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        _sendMessage();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _sendMessage() {
    String message = "";
    if(isEnglish(_controller.text)){
      message = "${_controller.text}";
    }else{
      message = "${_controller.text}${ConversationController.ReplyByEnglish}";
    }
    final MessageController messageController = Get.find();
    final ConversationController conversationController = Get.find();
    if (message.isNotEmpty) {
      var conversationUuid =
          conversationController.currentConversationUuid.value;
      if (conversationUuid.isEmpty) {
        // new conversation
        //message 的前10个字符，如果message不够10个字符，则全部
        conversationController.setCurrentConversationUuid(ConversationController.ConversationMachine);
      }
      final newMessage = Message(
        conversationId: conversationUuid,
        role: Role.user,
        text: message,
      );
      messageController.addMessage(newMessage);
      _formKey.currentState!.reset();
    }
  }

  bool isEnglish(String str){
    RegExp exp = RegExp(r"[\u4e00-\u9fa5]");
    if(exp.hasMatch(str)) {
      // 字符串中含有中文字符
      return false;
    } else {
      // 字符串中不含有中文字符
      return true;
    }
  }

  Widget _buildMessageCard(Message message) {
    if (message.role == Role.user) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // FaIcon(FontAwesomeIcons.person),
              SizedBox(
                width: 5,
              ),
              Text("User"),
              SizedBox(
                width: 10,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        message.text.replaceAll(ConversationController.ReplyByEnglish, ""),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              // const FaIcon(FontAwesomeIcons.robot),
              const SizedBox(
                width: 5,
              ),
              Text(message.role == Role.system ? "System" : "AI速答"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Markdown(text: message.text),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  void _handleKeyEvent(RawKeyEvent value) {
    if ((value.isKeyPressed(LogicalKeyboardKey.enter) &&
            value.isControlPressed) ||
        (value.isKeyPressed(LogicalKeyboardKey.enter) && value.isMetaPressed)) {
      _sendMessage();
    }
  }

  void _scrollToNewMessage() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
