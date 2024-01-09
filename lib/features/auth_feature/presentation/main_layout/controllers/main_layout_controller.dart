import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/remove_account_use_case.dart';
import 'package:otlobgas_driver/features/pusher_feature/domain/use_cases/disconnect_pusher_order_use_case.dart';
import 'package:otlobgas_driver/features/pusher_feature/domain/use_cases/init_pusher_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../order_feature/domain/entities/driver.dart';
import '../../../../order_feature/presentation/orders_list/controllers/orders_list_controller.dart';
import '../../../../pusher_feature/domain/use_cases/listen_to_user_use_case.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/logout_use_case.dart';
import '../../account_balance/controllers/account_balance_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class MainLayoutController extends GetxController {
  InitPusherUseCase initPusherUseCase;
  ListenToUserUseCase listenToUserUseCase;
  LogoutUserUseCase logoutUserUseCase;
  RemoveAccountUseCase removeAccountUseCase;

  DisconnectPusherUseCase disconnectPusherUseCase;

  MainLayoutController({
    required this.initPusherUseCase,
    required this.listenToUserUseCase,
    required this.logoutUserUseCase,
    required this.disconnectPusherUseCase,
    required this.removeAccountUseCase
  });

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  static MainLayoutController get to => Get.find();

  int currentIndex = 1;

  set setIndex(int value) {
    if (value == 0) {
      ProfileController.to.getOrdersCount();
    }

    if (value == 2) {
      return;
    }
    if (value == 3) {
      OrdersListController.to.getAllOrders(currentPage: '1');
    }
    if (value == 4) {
      AccountBalanceController.to.getLastWeek();
    }
    if (value == 2) {
      return;
    }
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    }
    if (currentIndex != value) {
      currentIndex = value;
      update();
    }
  }

  Future<void> logOut() async {
    isLoading = true;
    update();
    final result = await logoutUserUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) async {
      isLoading = false;
      update();
      Get.offAllNamed(Routes.login);
      await disconnectPusherUseCase();
      UserService.to.currentUser.value = null;
    });
  }
  Future<void> removeAccount() async {
    isLoading = true;
    update();
    final result = await removeAccountUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) async {
      isLoading = false;
      update();
      Get.offAllNamed(Routes.login);
      await disconnectPusherUseCase();
      UserService.to.currentUser.value = null;
    });
  }

  void listenToUser() {
    listenToUserUseCase().listen((User realTimeUser) async {
      UserService.to.currentUser.value = realTimeUser;
      update();
    });
  }

  @override
  void onInit() async {
    await initPusherUseCase(driverId: UserService.to.currentUser.value!.id);
    listenToUser();

    super.onInit();
  }

  @override
  void onReady() async {
    await setupInteractedMessage();

    super.onReady();
  }

  @override
  void dispose() async {
    await disconnectPusherUseCase();
    super.dispose();
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.

    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      if (value != null) {
        _handleMessage(value);
      }
    });

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleMessage(event);
    });
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      var customer = jsonDecode(message.data['customer']);
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
          'address': message.data['address'],
        },
      );
    }
  }
}
