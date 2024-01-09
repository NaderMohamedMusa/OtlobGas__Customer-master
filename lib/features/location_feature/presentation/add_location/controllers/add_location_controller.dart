import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/use_cases/add_location_use_case.dart';
import '../../locations/controllers/locations_controller.dart';

class AddLocationController extends GetxController {
  AddLocationUseCase addLocationUseCase;

  AddLocationController({
    required this.addLocationUseCase,
  });

  static AddLocationController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  LatLng? latLng;
  bool isLoading = false;
  bool isLatLngEmpty = false;

  Future<void> addLocation() async {
    if (!formKey.currentState!.validate()) {
      if (latLng == null) {
        isLatLngEmpty = true;
        update();
        return;
      }
      return;
    } else {
      if (latLng == null) {
        isLatLngEmpty = true;
        update();
        return;
      }
    }
    isLoading = true;
    update();
    final result = await addLocationUseCase(
      title: titleController.text,
      buildingNum: buildingNumberController.text,
      floorNum: floorNumberController.text,
      lat: latLng!.latitude,
      long: latLng!.longitude,
    );

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      LocationsController.to.locations = result;
      LocationsController.to.update();
      Get.back();

      isLoading = false;
      update();
    });
  }
}
