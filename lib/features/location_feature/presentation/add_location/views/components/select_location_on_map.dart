import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/services/location_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../controllers/select_location_on_map_controller.dart';

class SelectLocationOnMap extends StatelessWidget {
  const SelectLocationOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLocationOnMapController>(
      init: SelectLocationOnMapController(),
      builder: (selectController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    LocationService.to.customerLocation.value?.latitude ?? 0,
                    LocationService.to.customerLocation.value?.longitude ?? 0,
                  ),
                  zoom: 16,
                ),
                // set markers on google map
                onCameraIdle: () {},
                onCameraMove: (CameraPosition position) {
                  selectController.latLng = position.target;

                  // controller.changeMarker(LatLng(
                  //     position.target.latitude, position.target.longitude));
                },
                onMapCreated: (GoogleMapController controller) {
                  if (!selectController.controller.isCompleted) {
                    selectController.controller.complete(controller);
                    selectController.controllerGoogleMap = controller;
                  } else {
                    selectController.controllerGoogleMap = controller;
                  }
                },
                // on below line we have given map type
                mapType: MapType.normal,
                // onTap: controller.changeMarker,
                // disable zoom control
                zoomControlsEnabled: false,
                compassEnabled: false,

                // below line displays google map in our app
              ),
              Positioned(
                bottom: 30,
                left: 30,
                child: InkWell(
                  onTap: () {
                    selectController.getCurrentLocation();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      //    borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 30.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.location_searching_outlined),
                  ),
                ),
              ),
              Image.asset(
                Assets.locations,
                width: 100,
                height: 100,
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: InkWell(
                  onTap: () => selectController.selectLocation(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainApp,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: CustomText(
                      LocaleKeys.selectYourLocation.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 50,
                  child: SearchMapPlaceWidget(
                    apiKey: "AIzaSyAAOcn3r6DVavhuoPatQvNGg5kUuV1zAFo",
                    bgColor: Colors.white,
                    clearIcon: Icons.clear,
                    onSelected: (Place place) async {
                      final geolocation = await place.geolocation;
                      selectController.getLocationFromSearch(geolocation);
                    },
                    textColor: Colors.black,
                  )),
              Obx(
                () {
                  if (!LocationService.to.locationEnabled.value) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(Assets.locationSearch),
                            const SizedBox(height: 20.0),
                            CustomText(LocaleKeys.enableLocation.tr),
                            const SizedBox(height: 20.0),
                            CustomButton(
                              child: CustomText(
                                LocaleKeys.goToLocationSetting.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () => openAppSettings(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
