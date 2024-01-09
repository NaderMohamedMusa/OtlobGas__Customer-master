import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/entities/rating.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/entities/rating_content.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/use_cases/get_rating_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';

class OrdersRatingController extends GetxController {
  GetRatingUseCase getRatingUseCase;

  OrdersRatingController({
    required this.getRatingUseCase,
  });

  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  List<RatingContent> ratingList = [];
  Rating? rating;

  Future<void> getRating({required String currentPage}) async {
    isLoading = true;
    update();
    final result = await getRatingUseCase(currentPage: currentPage);

    result.fold((failure) {
      Get.back();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      rating = result;
      ratingList.addAll(result.data);
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() async {
    await getRating(currentPage: '1');
    scrollController.addListener(
      () {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (rating!.currentPage != rating!.lastPage) {
            getRating(currentPage: (rating!.currentPage + 1).toString());
          }
        }
      },
    );

    super.onInit();
  }
}
