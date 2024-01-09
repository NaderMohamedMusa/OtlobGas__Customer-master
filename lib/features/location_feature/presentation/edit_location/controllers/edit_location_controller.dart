import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/use_cases/edit_location_use_case.dart';
import '../../locations/controllers/locations_controller.dart';

class EditLocationController extends GetxController {
  EditLocationUseCase editLocationUseCase;

  EditLocationController({
    required this.editLocationUseCase,
  });

  static EditLocationController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  late LatLng latLng;
  bool isLoading = false;
  bool isLatLngEmpty = false;

  late Location location;

  Future<void> editLocation() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading = true;
    update();
    final result = await editLocationUseCase(
      id: location.id.toString(),
      title: titleController.text,
      buildingNum: buildingNumberController.text,
      floorNum: floorNumberController.text,
      lat: latLng.latitude,
      long: latLng.longitude,
    );

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      LocationService.to.centerCustomerLocation(
        location: latLng,
      );
      LocationsController.to.locations = result;
      LocationsController.to.update();
      Get.back();

      isLoading = false;
      update();
    });
  }

  selectLocation() {
    latLng = LatLng(
      LocationService.to.customerLocation.value!.latitude,
      LocationService.to.customerLocation.value!.longitude,
    );
    isLatLngEmpty = false;
    update();
    Get.back();
  }

  @override
  void onInit() {
    location = Get.arguments;
    buildingNumberController.text = location.buildingNum ?? '';
    titleController.text = location.title;
    floorNumberController.text = location.floorNum ?? '';
    latLng = LatLng(double.parse(location.lat), double.parse(location.long));

    update();
    super.onInit();
  }
}
