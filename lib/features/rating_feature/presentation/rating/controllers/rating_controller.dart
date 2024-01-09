import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/consts/toast_manager.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/use_cases/add_rating_use_case.dart';

class RatingController extends GetxController {
  AddRatingUseCase addRatingUseCase;

  RatingController({
    required this.addRatingUseCase,
  });

  static RatingController get to => Get.find();

  TextEditingController commentController = TextEditingController();
  List<String> allSelection = [
    LocaleKeys.badCylinder.tr,
    LocaleKeys.driverCameLate.tr,
    LocaleKeys.driverBehavedBadly.tr,
  ];
  List<String> selectionListName = [];
  bool isLoading = false;
  bool isBadRating = false;
  double rating = 5.0;

  set setRating(double value) {
    rating = value;
    if (rating <= 2.5) {
      isBadRating = true;
    } else {
      isBadRating = false;
    }
    update();
  }

  Future<void> addRating() async {
    FocusScope.of(Get.context!).unfocus();
    isLoading = true;
    update();
    print(selectionListName);
    if (selectionListName.isNotEmpty) {
      final string =
          selectionListName.reduce((value, element) => '$value / $element');
      print(string);
    }

    if (isBadRating && selectionListName.isEmpty) {
      ToastManager.showError(LocaleKeys.pleaseSelectReason.tr);
      isLoading = false;
      update();
    } else {
      if (selectionListName.isNotEmpty) {
        print(selectionListName.reduce((value, element) => '$value,$element'));
      }
      final result = await addRatingUseCase(
        comment: isBadRating
            ? selectionListName.reduce((value, element) => '$value,$element')
            : commentController.text,
        rating: rating.toInt(),
      );

      result.fold((failure) {
        isLoading = false;
        update();
        Get.back();
      }, (result) {
        isLoading = false;
        update();
        Get.back();
      });
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}