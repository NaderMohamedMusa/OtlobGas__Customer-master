import 'dart:core';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/chat_feature/domain/entities/chat.dart';
import 'package:otlobgas_driver/features/chat_feature/domain/use_cases/get_chat_use_case.dart';
import 'package:otlobgas_driver/features/chat_feature/domain/use_cases/send_message_use_case.dart';
import 'package:otlobgas_driver/features/pusher_feature/domain/use_cases/subscribe_chat_use_case.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../pusher_feature/domain/use_cases/listen_to_chat_use_case.dart';

class ChatController extends GetxController {
  GetChatUseCase getChatUseCase;
  SendMessageUseCase sendMessageUseCase;
  SubscribeChatUseCase subscribeChatUseCase;
  ListenToChatUseCase listenToChatUseCase;

  ChatController({
    required this.subscribeChatUseCase,
    required this.listenToChatUseCase,
    required this.getChatUseCase,
    required this.sendMessageUseCase,
  });

  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  final Record record = Record();

  bool isLoading = false;
  bool isRecording = false;
  bool emojiShowing = false;

  File? voiceFile;
  Chat? chat;

  set setEmojiShowing(bool value) {
    if (value != emojiShowing) {
      emojiShowing = value;
      update();
    }
  }

  bool isTyping = false;

  onChangeText() {
    if (messageController.text.isNotEmpty) {
      isTyping = true;
    } else {
      isTyping = false;
    }
    update();
  }

  deleteRecord() async {
    await record.stop();
    isRecording = false;
    voiceFile = null;
    update();
  }

  Future<void> toggleRecorder() async {
    if (isRecording) {
      stopRecorder();
    } else {
      startRecord();
    }
  }

  void startRecord() async {
    await openTheRecorder();
    String uniqueKey = const Uuid().v4() +
        DateTime.now().toIso8601String().replaceAll('.', '-');
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    voiceFile = File('$tempPath/$uniqueKey.m4a');

    record.start(path: voiceFile!.path).then((value) {
      isRecording = true;
      update();
    }).onError((error, stackTrace) {
      isRecording = false;
    });
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted && await record.hasPermission()) {
        throw Exception('Microphone permission not granted');
      }
    } else {
      throw Exception(
          'communication_provider.dart =====> openTheRecorder error =======> Microphone permission not available for web');
    }
  }

  Future<void> stopRecorder() async {
    await record.stop();
    isRecording = false;
    update();
    sendMessage();
  }

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty && voiceFile == null) {
      return;
    }
    isLoading = true;
    update();
    //set message type to 1 if text and 0 if voice

    //set voice file path to message

    final result = await sendMessageUseCase(
      message: voiceFile != null ? voiceFile!.path : messageController.text,
    );
    isLoading = false;

    messageController.clear();

    result.fold((failure) {
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      chat = result;
      voiceFile = null;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 200,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      isTyping = false;

      isLoading = false;
      update();
    });
  }

  Future<void> getChat() async {
    isLoading = true;
    update();
    final result = await getChatUseCase();

    result.fold((failure) {
      Get.back();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) async {
      chat = result;
      isLoading = false;
      scrollController.animateTo(
        (chat?.messages != null ? chat!.messages.length : 1) * Get.height,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      update();

      await subscribeChatUseCase(orderId: result.orderId);
      listenToChat();
    });
  }

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();

  Future<void> listenToChat() async {
    listenToChatUseCase().listen((Chat realTimeChat) async {
      audioPlayer.play();

      chat = realTimeChat;
      scrollController.animateTo(
        (chat?.messages != null ? chat!.messages.length : 1) * Get.height,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      update();
    });
  }

  @override
  void onReady() async {
    await getChat();
    audioPlayer.open(
      Audio("assets/audios/chat.mp3"),
      autoStart: false,
      showNotification: false,
    );
    super.onReady();
  }
}
