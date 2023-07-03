import 'package:crazyenglish/pages/chatgpt/repository/conversation.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  final conversationList = <Conversation>[].obs;

  final currentConversationUuid = "".obs;

  static String ConversationMachine = "machinePersonConversation" ;
  static String ConversationTranslate = "translate" ;

  static String ReplyByEnglish = ",请用英语回复我";
  static String TranslateByEnglish = ",请用英语翻译";


  static ConversationController get to => Get.find();
  @override
  void onInit() async {
    conversationList.value = await ConversationRepository().getConversations();
    super.onInit();
  }

  void setCurrentConversationUuid(String uuid) async {
    bool hasConversation = false;
    if(conversationList.value!=null && conversationList.value.length>0){
      conversationList.value.forEach((element) {
        if(element.uuid == uuid){
          hasConversation = true;
        }
      });
    }
    if(!hasConversation){
      var conversation;
      if(uuid == ConversationTranslate){
        conversation = Conversation(
          name: "翻译",
          description: "翻译",
          uuid: ConversationTranslate,
        );

      }else{
        conversation = Conversation(
          name: "人机对话",
          description: "人机对话",
          uuid: ConversationMachine,
        );
      }
      addConversation(conversation);
    }
    currentConversationUuid.value = uuid;
    update();
  }

  void deleteConversation(int index) async {
    Conversation conversation = conversationList[index];
    await ConversationRepository().deleteConversation(conversation.uuid);
    conversationList.value = await ConversationRepository().getConversations();
    update();
  }

  void renameConversation(Conversation conversation) async {
    await ConversationRepository().updateConversation(conversation);
    conversationList.value = await ConversationRepository().getConversations();
    update();
  }

  void addConversation(Conversation conversation) async {
    await ConversationRepository().addConversation(conversation);
    conversationList.value = await ConversationRepository().getConversations();
    update();
  }
}
