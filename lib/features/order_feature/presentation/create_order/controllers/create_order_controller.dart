import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/features/location_feature/domain/entities/location.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/create_order_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/entities/order.dart';

class CreateOrderController extends GetxController {
  CreateOrderUseCase createOrderUseCase;

  CreateOrderController({
    required this.createOrderUseCase,
  });

  static CreateOrderController get to => Get.find();

  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController driverNotesController = TextEditingController();
  late Location location;
  bool isLoading = false;

  Order? order;

  int count = 0;

  void changeCount({required bool increase}) {
    if (increase) {
      count++;
    } else {
      if (count == 1) {
        return;
      }
      count--;
    }
    update();
  }

  createOrder() async {
    isLoading = true;
    update();

    final result = await createOrderUseCase(
      locationId: location.id.toString(),
      notes: driverNotesController.text,
    );

    debugPrint("failure =====>>> $result");
    result.fold((failure) {
      isLoading = false;
      update();
      debugPrint("failure =====>>> $failure");
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      order = result;

      debugPrint("result =====>>> $result");
      Get.offAndToNamed(
        Routes.currentOrder,
        arguments: result,
      );
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() {
    location = Get.arguments;
    buildingNumberController.text = location.buildingNum ?? '';
    titleController.text = location.title;
    floorNumberController.text = location.floorNum ?? '';

    super.onInit();
  }
}
