import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(
        subscribeChatUseCase: Get.find(),
        listenToChatUseCase: Get.find(),
        getChatUseCase: Get.find(),
        sendMessageUseCase: Get.find(),
      ),
    );
  }
}
