import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import '/injector.dart' as di;
import '../../features/order_feature/domain/entities/driver.dart';
import '../../firebase_options.dart';

class NotificationService extends GetxService {
  static NotificationService get to => Get.find();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;
  Map<String, dynamic>? data;

  /// init
  Future<NotificationService> init() async {
    if (!kIsWeb) {
      print("*************** init Notification ******************");
      await setupFlutterNotifications();
    }
    FirebaseMessaging.onMessage.listen(showNotification);
    // FirebaseMessaging.onMessageOpenedApp.listen(showNotification);
    FirebaseMessaging.onBackgroundMessage(_messagingBackgroundHandler);
    return this;
  }

  /// setup Notifications
  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('launcher_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  /// show Notification
  void showNotification(RemoteMessage message) {
    data = message.data;
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }
}

/// messaging Background Handler
Future<void> _messagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
}

/// notification Tap Background
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (NotificationService.to.data != null) {
    if (NotificationService.to.data!['type'] == 'chat') {
      var customer = jsonDecode(NotificationService.to.data!['customer']);
      Get.toNamed(
        Routes.chat,
        arguments: {
          'customer': Driver(
            name: customer['name'],
            mobile: customer['mobile'],
            image: customer['image_for_web'],
            rate: '0',
            vehicleNumber: '0',
            vehicleType: '0',
          ),
          'address': NotificationService.to.data!['address'],
        },
      );
    }
  }
}
