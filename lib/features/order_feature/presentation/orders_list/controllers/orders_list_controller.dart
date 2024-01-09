import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/orders_pagenation.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/get_all_orders_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';

class OrdersListController extends GetxController {
  GetAllOrdersUseCase getAllOrdersUseCase;
  OrdersListController({required this.getAllOrdersUseCase});

  static OrdersListController get to => Get.find();

  late ScrollController scrollController = ScrollController();
  List<Order> orders = [];

  OrdersPagenation? ordersPagenation;

  bool isLoading = false;

  Future<void> getAllOrders({required String currentPage}) async {
    isLoading = true;
    update();
    final result = await getAllOrdersUseCase(currentPage: currentPage);

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      ordersPagenation = result;

      if (currentPage == '1') {
        orders = result.data;
      } else {
        orders.addAll(result.data);
      }
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() async {
    await getAllOrders(currentPage: '1');
    scrollController.addListener(
      () {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (ordersPagenation!.currentPage != ordersPagenation!.lastPage) {
            getAllOrders(
                currentPage: (ordersPagenation!.currentPage + 1).toString());
          }
        }
      },
    );
    super.onInit();
  }
}
