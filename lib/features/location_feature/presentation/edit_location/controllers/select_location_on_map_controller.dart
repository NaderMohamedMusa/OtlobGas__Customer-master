import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/services/location_service.dart';
import 'edit_location_controller.dart';

class SelectLocationOnMapController extends GetxController {
  static SelectLocationOnMapController get to => Get.find();

  final kGoogleApiKey = "AIzaSyAAOcn3r6DVavhuoPatQvNGg5kUuV1zAFo";
  late GoogleMapController controllerGoogleMap;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? latLng;

  getCurrentLocation() {
    latLng = LatLng(LocationService.to.customerLocation.value?.latitude ?? 0,
        LocationService.to.customerLocation.value?.longitude ?? 0);
    update();
    if (controller.isCompleted) {
      controllerGoogleMap.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            latLng!.latitude,
            latLng!.longitude,
          ),
          16,
        ),
      );
    }
  }

  getLocationFromSearch(place) {
    update();
    if (controller.isCompleted) {
      latLng = place.coordinates;
      controllerGoogleMap.animateCamera(
        CameraUpdate.newLatLngZoom(place.coordinates, 18),
      );
      controllerGoogleMap
          .animateCamera(CameraUpdate.newLatLngBounds(place.bounds, 0));
    }
  }

  changeMarker(LatLng latLong) async {
    LocationService.to.addCustomerMarkWithNearestDrivers(userLatLng: latLong);
    EditLocationController.to.latLng = latLong;
    EditLocationController.to.isLatLngEmpty = false;
    EditLocationController.to.update();
  }

  selectLocation() {
    EditLocationController.to.isLatLngEmpty = false;
    EditLocationController.to.update();
    Get.back();
  }

  @override
  void onReady() {
    if (Get.arguments != null) {
      LocationService.to.addCustomerMarkWithNearestDrivers(
        userLatLng: (Get.arguments as LatLng),
      );
      LocationService.to.centerCustomerLocation(
        location: (Get.arguments as LatLng),
      );
      update();
    }
    super.onReady();
  }
}
