import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/features/rating_feature/presentation/orders_rating/controllers/orders_rating_controller.dart';

import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../auth_feature/presentation/profile/views/components/rating_card.dart';

class OrdersRatingView extends StatelessWidget {
  const OrdersRatingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersRatingController>(
      init: OrdersRatingController(getRatingUseCase: Get.find()),
      builder: (controller) {
        return Scaffold(
          body: controller.rating == null
              ? const LoadingWidget()
              : controller.rating!.data.isEmpty
                  ? Center(
                      child: CustomText(
                        LocaleKeys.thereAreNoReviewsCurrently.tr,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        controller.ratingList.clear();
                        controller.getRating(currentPage: '1');
                      },
                      child: ListView.separated(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 20 + kBottomNavigationBarHeight,
                        ),
                        itemCount: controller.ratingList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15.0),
                        itemBuilder: (_, index) {
                          return ReviewCard(
                            ratingContent: controller.ratingList[index],
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}
