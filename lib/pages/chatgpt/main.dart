import 'package:crazyenglish/pages/chatgpt/api/chat_api.dart';
import 'package:crazyenglish/pages/chatgpt/chat_page.dart';
import 'package:crazyenglish/pages/chatgpt/common/translations.dart';
import 'package:crazyenglish/pages/chatgpt/controller/conversation.dart';
import 'package:crazyenglish/pages/chatgpt/controller/message.dart';
import 'package:crazyenglish/pages/chatgpt/controller/prompt.dart';
import 'package:crazyenglish/pages/chatgpt/controller/settings.dart';
import 'package:crazyenglish/pages/mine/mine_setting/mine_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChatApp());
}


final routes = [
  GetPage(name: '/', page: () => ChatPage(chatApi: ChatApi())),
  GetPage(name: '/setting', page: () => SettingPage())
];

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    Get.put(ConversationController());
    Get.put(MessageController());
    Get.put(PromptController());
    // return MaterialApp(
    //   title: 'ChatGPT Client',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(
    //       seedColor: Colors.teal,
    //       secondary: Colors.lime,
    //     ),
    //   ),
    //   home: ChatPage(chatApi: chatApi),
    // );

    return GetMaterialApp(
      initialRoute: '/',
      getPages: routes,
      themeMode: ThemeMode.system,
      locale: const Locale('zh'),
      translations: MyTranslations(),
      debugShowCheckedModeBanner: false,
    );
  }
}
