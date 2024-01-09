import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/widgets/custom_text.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../auth_feature/presentation/main_layout/views/components/main_layout_app_bar.dart';
import '../controllers/orders_list_controller.dart';
import 'components/completed_order_card.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersListController>(
      init: OrdersListController(getAllOrdersUseCase: Get.find()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const MainLayoutAppBar(),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: SizedBox(
              width: double.infinity,
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.orders.clear();
                  await controller.getAllOrders(currentPage: '1');
                },
                child: controller.orders.isEmpty && !controller.isLoading
                    ? ListView(
                        children: [
                          const SizedBox(height: 100),
                          Center(
                            child: LottieBuilder.asset(
                              Assets.emptyList,
                              width: 300,
                              height: 300,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Center(
                            child: CustomText(
                              LocaleKeys.yourOrdersListIsEmpty.tr,
                            ),
                          )
                        ],
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: false,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          return CompletedOrderCard(
                            order: controller.orders[index],
                          );
                        },
                        padding: const EdgeInsets.only(
                            bottom: kBottomNavigationBarHeight),
                        itemCount: controller.orders.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 1,
                            height: 1,
                            color: Colors.grey[300],
                          );
                        },
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
