import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otlobgas_driver/core/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../location_feature/presentation/locations/controllers/locations_controller.dart';
import '../../../../order_feature/domain/use_cases/check_available_order_use_case.dart';
import '../../../domain/entities/ads.dart';
import '../../../domain/use_cases/get_ads_use_case.dart';

class HomeController extends GetxController {
  GetAdsUseCase getAdsUseCase;
  CheckAvailableOrderUseCase checkAvailableOrderUseCase;

  HomeController({
    required this.getAdsUseCase,
    required this.checkAvailableOrderUseCase,
  });

  bool isLoading = false;
  bool isAdsLoading = false;

  List<Ads> adsList = [];

  Future<void> getAds() async {
    isAdsLoading = true;
    update();
    final result = await getAdsUseCase();

    result.fold((failure) {
      isAdsLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      adsList = result;

      isAdsLoading = false;
      update();
    });
  }

  Future<void> launchLink(String link) async {
    final Uri url = Uri.parse(link);
    launchUrl(url);
  }

  @override
  void onInit() async {
    await getAds();

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    LocationService.to.controller = Completer<GoogleMapController>();
    super.onClose();
  }

  checkAvailableOrder() async {
    isLoading = true;
    update();
    final result = await checkAvailableOrderUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      if (LocationsController.to.locations.isEmpty) {
        Get.toNamed(Routes.addLocation);
      } else {
        Get.toNamed(
          Routes.createOrder,
          arguments: LocationsController
              .to.locations[LocationsController.to.indexAddress],
        );
      }
    }, (result) {
      isLoading = false;
      update();

      Get.toNamed(
        Routes.currentOrder,
        arguments: result,
      );
    });
  }
}
