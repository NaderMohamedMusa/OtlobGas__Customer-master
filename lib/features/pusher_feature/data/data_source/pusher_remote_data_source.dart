import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/consts/k_strings.dart';
import 'package:otlobgas_driver/features/order_feature/data/models/order_model.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../auth_feature/data/models/user_model.dart';
import '../../../chat_feature/data/models/chat_model.dart';

abstract class BasePusherRemoteDataSource {
  /// subscribe to channels
  Future<Unit> subscribeToOrder({required int driverId});

  Future<Unit> subscribeToChat({required int orderId});

  /// listen to events
  Stream<OrderModel> listenToOrder();

  Stream<ChatModel> listenToChat();

  Stream<UserModel> listenToUser();

  /// init pusher
  Future<Unit> initPusher({required int driverId});

  /// disconnect pusher
  Future<Unit> disconnectPusher();
}

class PusherRemoteDataSource extends GetConnect
    implements BasePusherRemoteDataSource {
  PusherChannelsFlutter pusher;
  PusherRemoteDataSource({required this.pusher});
  StreamController<OrderModel>? _orderStreamController;
  StreamController<UserModel>? _userStreamController;
  StreamController<ChatModel>? _chatStreamController;

  @override
  Future<Unit> initPusher({required int driverId}) async {
    try {
      _userStreamController = StreamController();
      // init pusher
      await pusher.init(
        apiKey: Kstrings.pusherAppKey,
        cluster: Kstrings.pusherCluster,
      );
      await pusher.subscribe(
        channelName: Kstrings.getUserChannel(driverId: driverId),
        onEvent: (event) => listenToUserData(event),
      );

      // connect to channel
      await pusher.connect();

      return unit;
    } on SocketException {
      return Future.delayed(const Duration(seconds: 10), () async {
        return await initPusher(driverId: driverId);
      });
    } catch (error) {
      rethrow;
    }
  }

  // Bind to listen for events called "driver"
  listenToUserData(PusherEvent event) {
    final responseBody = jsonDecode(event.data);
    print("listenToUserData=============>$responseBody");
    if (responseBody['user'] != null) {
      _userStreamController!.add(UserModel.fromMap(responseBody['user']));
    }
  }

// Bind to listen for events called "driver"
  listenToOrders(PusherEvent event) {
    final responseBody = jsonDecode(event.data);

    if (responseBody['order'] != null) {
      _orderStreamController!.add(OrderModel.fromMap(responseBody['order']));
    }
  }

  // Disconnect from pusher service
  @override
  Future<Unit> disconnectPusher() async {
    try {
      pusher.disconnect();
      _orderStreamController!.close();
      _userStreamController!.close();
      _chatStreamController!.close();
      return unit;
    } on SocketException {
      return Future.delayed(const Duration(seconds: 10), () async {
        return await disconnectPusher();
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<OrderModel> listenToOrder() {
    return _orderStreamController!.stream;
  }

  @override
  Stream<UserModel> listenToUser() {
    return _userStreamController!.stream;
  }

  @override
  Future<Unit> subscribeToOrder({required int driverId}) async {
    _orderStreamController = StreamController();

    await pusher.subscribe(
      channelName: Kstrings.getOrderChannel(driverId: driverId),
      onEvent: (event) => listenToOrders(event),
    );

    return unit;
  }

  @override
  Future<Unit> subscribeToChat({required int orderId}) async {
    _chatStreamController = StreamController();

    await pusher.subscribe(
      channelName: Kstrings.getChatChannel(orderId: orderId),
      onEvent: (event) => listenToChats(event),
    );

    return unit;
  }

  listenToChats(PusherEvent event) {
    final responseBody = jsonDecode(event.data);

    if (responseBody['chat'] != null) {
      final ChatModel chatModel = ChatModel.fromMap(responseBody['chat']);
      _chatStreamController!.add(chatModel);
    }
  }

  @override
  Stream<ChatModel> listenToChat() {
    return _chatStreamController!.stream;
  }
}
