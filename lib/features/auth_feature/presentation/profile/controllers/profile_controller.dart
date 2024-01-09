import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/get_orders_count_use_case.dart';

import '../../../domain/entities/orders_count.dart';

class ProfileController extends GetxController {
  GetOrdersCountUseCase getOrdersCountUseCase;
  ProfileController({required this.getOrdersCountUseCase});
  static ProfileController get to => Get.find();
  List driverRatings = [];
  ScrollController scrollController = ScrollController();
  OrdersCount? ordersCount;

  bool isLoading = false;

  Future<void> getOrdersCount() async {
    isLoading = true;
    update();
    final result = await getOrdersCountUseCase();

    result.fold((failure) {}, (result) {
      ordersCount = result;
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() async {
    await getOrdersCount();
    super.onInit();
  }
}
