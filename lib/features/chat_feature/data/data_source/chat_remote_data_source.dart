import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/consts/k_strings.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/consts/api_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../models/chat_model.dart';

abstract class BaseChatRemoteDataSource {
  /// listen to stream of orders
  Stream<ChatModel> listenToChat();

  /// init stream
  Future<Unit> initPusherChat({required int orderId});

  /// disconnect stream
  Future<Unit> disconnectPusherChat();

  Future<ChatModel> sendMessage({
    required String message,
    required String token,
    required String currentLanguage,
  });

  Future<ChatModel> getChat({
    required String token,
    required String currentLanguage,
  });
}

class ChatRemoteDataSource extends GetConnect
    implements BaseChatRemoteDataSource {
  final PusherChannelsFlutter pusher;
  StreamController<ChatModel>? _streamController;

  ChatRemoteDataSource({
    required this.pusher,
  });

  @override
  Future<Unit> initPusherChat({required int orderId}) async {
    try {
      //init Stream
      _streamController = StreamController();
      // init pusher
      await pusher.init(
        apiKey: Kstrings.pusherAppKey,
        cluster: Kstrings.pusherCluster,
        onError: (message, code, error) {},
      );
      // subscribe to channel
      await pusher.subscribe(
        channelName: Kstrings.getChatChannel(orderId: orderId),
        onEvent: (event) => listenToChats(event),
      );
      // connect to channel
      await pusher.connect();
      return unit;
    } on SocketException {
      return Future.delayed(const Duration(seconds: 10), () async {
        return await initPusherChat(orderId: orderId);
      });
    } catch (error) {
      rethrow;
    }
  }

// Bind to listen for events called "driver"
  listenToChats(PusherEvent event) {
    final responseBody = jsonDecode(event.data);

    if (responseBody['chat'] != null) {
      final ChatModel chatModel = ChatModel.fromMap(responseBody['chat']);
      _streamController!.add(chatModel);
    }
  }

  // Disconnect from pusher service
  @override
  Future<Unit> disconnectPusherChat() async {
    try {
      pusher.disconnect();
      _streamController!.close();
      return unit;
    } on SocketException {
      return Future.delayed(const Duration(seconds: 10), () async {
        return await disconnectPusherChat();
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<ChatModel> listenToChat() {
    return _streamController!.stream;
  }

  @override
  Future<ChatModel> getChat({
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await get(
      '${ApiUrls.chats}?lang=$currentLanguage',
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return ChatModel.fromMap(response.body['data']);
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<ChatModel> sendMessage({
    required String message,
    required String token,
    required String currentLanguage,
  }) async {
    final form = FormData({
      if (message.endsWith('.m4a'))
        'audio': MultipartFile(
          File(message).readAsBytesSync(),
          filename: message,
        )
      else
        'message': message,
      'lang': currentLanguage,
    });
    Response response = await post(
      ApiUrls.sendMessage,
      form,
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return ChatModel.fromMap(response.body['data']);
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  // @override
  // Future<OrderModel> acceptOrder({
  //   required String currentLanguage,
  //   required String token,
  // }) async {
  //   Response response = await post(
  //     ApiUrls.acceptOrder,
  //     {
  //       'lang': currentLanguage,
  //     },
  //     headers: ApiUrls.getHeaders(token: token),
  //   );
  //   print('acceptOrder==>${response.body}');
  //   switch (response.statusCode) {
  //     case 200:
  //       return OrderModel.fromMap(response.body['data']);
  //     case 203:
  //       throw ExpiredPlanException(
  //           message: response.body['message'], result: null);
  //     case 401:
  //       throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
  //     case 403:
  //       if (response.body is String) {
  //         throw UnExpectedException();
  //       } else {
  //         throw UnVerifiedException(message: response.body['message']);
  //       }
  //     case 400:
  //     case 422:
  //       throw ValidationException(message: response.body['message']);
  //     default:
  //       throw ServerException();
  //   }
  // }
}
