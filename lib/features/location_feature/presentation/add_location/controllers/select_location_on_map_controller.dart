import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
// import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:otlobgas_driver/core/consts/toast_manager.dart';
import 'package:otlobgas_driver/features/location_feature/presentation/add_location/controllers/add_location_controller.dart';

import '../../../../../core/services/location_service.dart';

class SelectLocationOnMapController extends GetxController {
  static SelectLocationOnMapController get to => Get.find();
  final kGoogleApiKey = "AIzaSyAAOcn3r6DVavhuoPatQvNGg5kUuV1zAFo";
  late GoogleMapController controllerGoogleMap;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? latLng;

  selectLocation() {
    AddLocationController.to.latLng = latLng;
    print("===============>$latLng");
    AddLocationController.to.isLatLngEmpty = false;
    AddLocationController.to.update();
    Get.back();
  }

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

  @override
  void onInit() async {
    latLng = LatLng(LocationService.to.customerLocation.value?.latitude ?? 0,
        LocationService.to.customerLocation.value?.longitude ?? 0);
    super.onInit();
  }
}
