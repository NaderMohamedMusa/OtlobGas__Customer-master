import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:otlobgas_driver/core/consts/enums.dart';
import 'package:otlobgas_driver/core/services/location_service.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/cancel_confirm_order_use_case.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/cancel_order_with_reason_use_case.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/check_available_order_use_case.dart';
import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../pusher_feature/domain/use_cases/listen_to_order_use_case.dart';
import '../../../../pusher_feature/domain/use_cases/subscribe_order_use_case.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/use_cases/assign_order_use_case.dart';
import '../../../domain/use_cases/cancel_order_use_case.dart';
import '../../../domain/use_cases/reject_order_use_case.dart';
import '../views/components/cancel_order.dart';

class CurrentOrderController extends GetxController {
  CheckAvailableOrderUseCase checkAvailableOrderUseCase;
  SubscribeOrderUseCase subscribeOrderUseCase;
  ListenToOrderUseCase listenToOrderUseCase;
  AssignOrderUseCase assignOrderUseCase;
  RejectOrderUseCase rejectOrderUseCase;
  CancelOrderUseCase cancelOrderUseCase;
  CancelConfirmOrderUseCase cancelConfirmOrderUseCase;
  CancelOrderWithReasonUseCase cancelOrderWithReasonUseCase;

  CurrentOrderController({
    required this.checkAvailableOrderUseCase,
    required this.subscribeOrderUseCase,
    required this.listenToOrderUseCase,
    required this.assignOrderUseCase,
    required this.rejectOrderUseCase,
    required this.cancelOrderUseCase,
    required this.cancelConfirmOrderUseCase,
    required this.cancelOrderWithReasonUseCase,
  });

  static CurrentOrderController get to => Get.find();

  TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Rx<bool> isLoading = Rx(false);
  Rx<int> currentIndex = Rx(0);
  Rx<int> quantity = Rx(1);
  Rx<Order?> order = Rx(null);
  Rx<int> timeCounter = Rx(25);
  Rx<bool> isCash = Rx(true);
  late Timer timer;
  Rx<double> totalPrice = Rx(0);

  Rx<String> get count =>
      Rx(NumberFormat("00").format(order.value!.quantity).toString());

  void changePaymentMethod() {
    isCash.value = !isCash.value;
    update();
  }

  void changeCount({required bool increase}) {
    if (increase) {
      quantity.value = quantity.value + 1;
    } else {
      if (quantity.value == 1) {
        return;
      }
      quantity.value = quantity.value - 1;
    }
    var num1;
    if (quantity.value == 1) {
      totalPrice.value = order.value!.totalPrice;
    } else {
      num1 = (quantity.value - 1) * order.value!.unitPrice;

      num1 = num1 + order.value!.delivery;

      var tax = (num1 * order.value!.tax) / 100;

      num1 = tax + num1;

      // num1 = num1 * order.value!.tax;
      // print(num1);
      // num1 = num1 / 100;
      // print(num1);
      // num1 = num1 + order.value!.delivery;
      // print(num1);

      totalPrice.value = num1;
    }
  }

  void listenToOrder() {
    debugPrint("realTimeOrder =======>>>>> start");
    listenToOrderUseCase().listen((Order realTimeOrder) async {
      debugPrint("realTimeOrder =======>>>>> ${realTimeOrder.status}");
      debugPrint("realTimeOrder =======>>>>> ${realTimeOrder.status}");
      debugPrint("realTimeOrder =======>>>>> ${realTimeOrder.status}");
      if (realTimeOrder.status == OrderStatus.create) {
        order.value = realTimeOrder;
      } else if (realTimeOrder.status == OrderStatus.noDriverFound) {
        Get.back();
        ToastManager.showError(LocaleKeys.noDriverFound.tr);
      } else if (realTimeOrder.status == OrderStatus.acceptDriver) {
        order.value = realTimeOrder;
        if (timer.isActive) {
          timer.cancel();
        }
        listenForDriverLocation();
      }
      else if (realTimeOrder.status == OrderStatus.delivered) {
        Get.offAndToNamed(Routes.rating);
        ToastManager.showSuccess(LocaleKeys.delivered.tr);
      } else if (realTimeOrder.status == OrderStatus.canceled) {
        Get.back();
        ToastManager.showError(LocaleKeys.driverCancelOrder.tr);
      }
    });
  }

  startResendTimerCountDown() {
    timeCounter.value = 25;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeCounter.value == 0) {
          timer.cancel();
          rejectOrder();
        } else {
          timeCounter.value--;
        }
        update();
      },
    );
  }

  checkAvailableOrder() async {
    final result = await checkAvailableOrderUseCase();

    result.fold((failure) {}, (result) {
      order.value = result;
      LocationService.to.positionCameraBetweenTwoCoords(
        LatLng(
          result.customerLat,
          result.customerLng,
        ),
        LatLng(
          result.driverLat,
          result.driverLng,
        ),
      );
    });
  }

  listenForDriverLocation() {
    checkAvailableOrder();
    timeCounter.value = 15;

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeCounter.value == 0) {
          timer.cancel();
          listenForDriverLocation();
        } else {
          timeCounter.value--;
        }
        update();
      },
    );
  }

  cancelOrder() async {
    final result = await cancelOrderUseCase();

    result.fold((failure) {}, (result) {
      Get.dialog(
        GetX<CurrentOrderController>(
          builder: (controller) {
            return Stack(
              children: [
                AlertDialog(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titlePadding: const EdgeInsets.all(20),
                  title: CancelOrder(result: result),
                ),
                if (controller.isLoading.value)
                  Container(
                    color: Colors.grey.withOpacity(.5),
                    child: Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: lottie.LottieBuilder.asset(Assets.loading),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        barrierDismissible: false,
      );
    });
  }

  cancelConfirmOrder() async {
    isLoading.value = true;

    final result = await cancelConfirmOrderUseCase();

    result.fold((failure) {
      isLoading.value = false;
    }, (result) {
      if (Get.isDialogOpen!) {
        Get.back();
      }

      Get.back();

      ToastManager.showSuccess(result);
    });
  }

  cancelOrderWithReasonConfirm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;

    final result =
        await cancelOrderWithReasonUseCase(reason: reasonController.text);

    result.fold((failure) {
      isLoading.value = false;
    }, (result) {
      isLoading.value = false;
      if (Get.isDialogOpen!) {
        Get.back();
      }
      Get.back();

      ToastManager.showSuccess(result);
    });
  }

  assignOrder() async {
    isLoading.value = true;

    final result = await assignOrderUseCase(
      paymentMethod: isCash.value ? 0 : 1,
      quantity: quantity.value,
    );

    result.fold((failure) {
      isLoading.value = false;

      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      order.value = result;

      if (result!.status == OrderStatus.noDriverFound) {
        Get.back();
        ToastManager.showError(LocaleKeys.noDriverFound.tr);
      } else if (order.value!.status == OrderStatus.sendToDriver) {
        startResendTimerCountDown();
      }

      isLoading.value = false;
      update();
    });
  }

  rejectOrder() async {
    isLoading.value = true;

    final result = await rejectOrderUseCase();

    result.fold((failure) {
      isLoading.value = false;
    }, (result) {
      order.value = result;
      isLoading.value = false;
      startResendTimerCountDown();
      if (result!.status == OrderStatus.noDriverFound) {
        if (timer.isActive) {
          timer.cancel();
        }
        Get.back();
        ToastManager.showError(LocaleKeys.noDriverFound.tr);
      }
    });
  }

  String get orderStatus {
    switch (order.value!.status) {
      case OrderStatus.acceptDriver:
        return LocaleKeys.currentOrder.tr;
      case OrderStatus.delivered:
        return LocaleKeys.orderDetails.tr;
      default:
        return LocaleKeys.askGasUnit.tr;
    }
  }

  @override
  void onInit() async {
    order.value = Get.arguments;

    if (order.value!.status == OrderStatus.sendToDriver) {
      startResendTimerCountDown();
    }
    if (order.value!.status == OrderStatus.acceptDriver) {
      listenForDriverLocation();
    }

    await subscribeOrderUseCase(
      driverId: UserService.to.currentUser.value!.id,
    );
    listenToOrder();

    super.onInit();
  }

  @override
  void onReady() {
    LocationService.to.centerCustomerLocation(
      location: LatLng(
        (Get.arguments as Order).customerLat,
        (Get.arguments as Order).customerLng,
      ),
    );
    super.onReady();
  }
}
