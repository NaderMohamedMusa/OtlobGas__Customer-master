import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/features/location_feature/domain/use_cases/delete_location_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/use_cases/get_all_locations_use_case.dart';

class LocationsController extends GetxController {
  GetAllLocationUseCase getAllLocationUseCase;
  DeleteLocationUseCase deleteLocationUseCase;

  LocationsController({
    required this.getAllLocationUseCase,
    required this.deleteLocationUseCase,
  });

  static LocationsController get to => Get.find();

  bool isLoading = false;
  int indexAddress = 0;
  List<Location> locations = [];

  setIndexAddress(int indexAddress) async {
    if (indexAddress == this.indexAddress) {
      return;
    }
    // isLoading = true;
    // update();

    this.indexAddress = indexAddress;
    LocationService.to.getNearestDrivers(true);
    LocationService.to.centerCustomerLocation(
      location: LatLng(
        double.parse(locations[indexAddress].lat),
        double.parse(locations[indexAddress].long),
      ),
    );
    LocationService.to.addCustomerMarkWithNearestDrivers(
      userLatLng: LatLng(
        double.parse(locations[indexAddress].lat),
        double.parse(locations[indexAddress].long),
      ),
    );

    // isLoading = false;
    update();
  }

  Future<void> deleteLocation({required String locationID}) async {
    isLoading = true;
    update();
    final result = await deleteLocationUseCase(id: locationID);

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      locations = result;
      if (Get.isDialogOpen!) {
        Get.back();
      }
      isLoading = false;
      update();
    });
  }

  Future<void> getAllLocations() async {
    isLoading = true;
    update();
    final result = await getAllLocationUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnVerifiedFailure) {
        Get.offAllNamed(Routes.login);
      }
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      locations = result;
      if (result.isNotEmpty) {
        LocationService.to.centerCustomerLocation(
          location: LatLng(
            double.parse(result.first.lat),
            double.parse(result.first.long),
          ),
        );
        LocationService.to.addCustomerMarkWithNearestDrivers(
          userLatLng: LatLng(
            double.parse(result.first.lat),
            double.parse(result.first.long),
          ),
        );
      }
      LocationService.to.getNearestDrivers(false);
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() async {
    await getAllLocations();

    super.onInit();
  }
}
