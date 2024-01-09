import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/delete_all_notifications_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/delete_notification_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/get_today_notifications_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/read_notification_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/entities/notification.dart' as nf;
import '../../../domain/entities/notification_content.dart';
import '../../../domain/use_cases/get_all_notifications_use_case.dart';

class NotificationsController extends GetxController {
  GetAllNotificationsUseCase getAllNotificationsUseCase;
  GetTodayNotificationsUseCase getTodayNotificationsUseCase;
  DeleteAllNotificationsUseCase deleteAllNotificationsUseCase;
  ReadAllNotificationsUseCase readAllNotificationsUseCase;
  DeleteNotificationUseCase deleteNotificationUseCase;

  NotificationsController({
    required this.getAllNotificationsUseCase,
    required this.getTodayNotificationsUseCase,
    required this.deleteAllNotificationsUseCase,
    required this.deleteNotificationUseCase,
    required this.readAllNotificationsUseCase,
  });

  ScrollController allNotificationsScroll = ScrollController();
  ScrollController todayNotificationsScroll = ScrollController();

  bool isLoading = false;
  bool isAllLoading = false;
  bool isTodayLoading = false;

  List<NotificationContent> allNotificationsContent = [];
  List<NotificationContent> todayNotificationsContent = [];

  nf.Notification? allNotifcation;
  nf.Notification? todayNotifcation;

  Future<void> getAllNotifications({required String currentPage}) async {
    isAllLoading = true;
    update();
    final result = await getAllNotificationsUseCase(currentPage: currentPage);

    result.fold((failure) {
      isAllLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      allNotifcation = result;
      allNotificationsContent.addAll(result.data);
      isAllLoading = false;
      update();
    });
  }

  Future<void> getTodayNotifications({required String currentPage}) async {
    isTodayLoading = true;
    update();
    final result = await getTodayNotificationsUseCase(currentPage: currentPage);

    result.fold((failure) {
      isTodayLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      todayNotifcation = result;
      todayNotificationsContent.addAll(result.data);
      isTodayLoading = false;
      update();
    });
  }

  Future<void> deleteAllNotifications() async {
    isLoading = true;
    update();

    if (Get.isDialogOpen!) {
      Get.back();
    }
    final result = await deleteAllNotificationsUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      allNotificationsContent = [];
      todayNotificationsContent = [];
      isLoading = false;
      update();
    });
  }

  Future<void> deleteNotification(
    int notificationID,
    bool isTodayNotification,
  ) async {
    isLoading = true;
    update();

    if (Get.isDialogOpen!) {
      Get.back();
    }
    final result = await deleteNotificationUseCase(
      notificationId: notificationID,
      isTodayNotification: isTodayNotification,
    );

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) async {
      if (isTodayNotification) {
        todayNotifcation = result;
        todayNotificationsContent = result.data;
        allNotificationsContent = [];
        await getAllNotifications(currentPage: '1');
      } else {
        allNotifcation = result;
        allNotificationsContent = result.data;
        todayNotificationsContent = [];
        await getTodayNotifications(currentPage: '1');
      }

      isLoading = false;
      update();
    });
  }

  Future<void> readNotification() async {
    update();
    final result = await readAllNotificationsUseCase();

    result.fold((failure) {
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      UserService.to.currentUser.value = result.data;
      update();
    });
  }

  @override
  void onInit() async {
    readNotification();
    await Future.wait([
      getAllNotifications(currentPage: '1'),
      getTodayNotifications(currentPage: '1'),
    ]);
    allNotificationsScroll.addListener(
      () {
        if (allNotificationsScroll.offset >=
                allNotificationsScroll.position.maxScrollExtent &&
            !allNotificationsScroll.position.outOfRange) {
          if (allNotifcation!.currentPage != allNotifcation!.lastPage) {
            getAllNotifications(
                currentPage: (allNotifcation!.currentPage + 1).toString());
          }
        }
      },
    );

    todayNotificationsScroll.addListener(
      () {
        if (todayNotificationsScroll.offset >=
                todayNotificationsScroll.position.maxScrollExtent &&
            !todayNotificationsScroll.position.outOfRange) {
          if (todayNotifcation!.currentPage != todayNotifcation!.lastPage) {
            getTodayNotifications(
                currentPage: (todayNotifcation!.currentPage + 1).toString());
          }
        }
      },
    );
    super.onInit();
  }
}
