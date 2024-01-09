import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/consts/assets.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/theme/app_colors.dart';
import 'package:otlobgas_driver/core/widgets/custom_app_bar.dart';
import 'package:otlobgas_driver/core/widgets/custom_button.dart';
import 'package:otlobgas_driver/core/widgets/custom_text.dart';
import 'package:otlobgas_driver/core/widgets/drawer_icon.dart';
import 'package:otlobgas_driver/core/widgets/loading_widget.dart';
import 'package:otlobgas_driver/core/widgets/notification_button_widget.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/home/controllers/home_controller.dart';
import 'package:otlobgas_driver/features/location_feature/presentation/locations/controllers/locations_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../location_feature/presentation/locations/views/select_location_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(
        getAdsUseCase: Get.find(),
        checkAvailableOrderUseCase: Get.find(),
      ),
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.notActive,
          appBar: CustomAppBar(
            title: CustomText(
              LocaleKeys.homePage.tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
            actions: const [
              NotificationButton(),
              SizedBox(
                width: 10,
              ),
              DrawerIcon(),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: controller.isAdsLoading
                          ? const LoadingWidget()
                          : controller.adsList.isEmpty
                              ? Center(
                                  child: CustomText(
                                    'bannersArea',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                )
                              : CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1,
                                  ),
                                  items: controller.adsList.map((i) {
                                    return GestureDetector(
                                      onTap: () =>
                                          controller.launchLink(i.link),
                                      child: CachedNetworkImage(
                                        imageUrl: i.image,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }).toList(),
                                ),
                    ),
                    DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              height: 100,
                              child: SelectLocationView(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                height: 43,
                                color: AppColors.mainApp,
                                onPressed: () =>
                                    controller.checkAvailableOrder(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.carBlueIC,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10.0),
                                    CustomText(
                                      LocaleKeys.askForGas.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              CustomButton(
                                  height: 43,
                                  onPressed: () =>
                                      Get.toNamed(Routes.addLocation),
                                  color: AppColors.secondaryButton,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.locationOutlinedIC,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 10.0),
                                      CustomText(
                                        LocaleKeys.selectYourLocation.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Obx(
                            () => GoogleMap(
                              initialCameraPosition:
                                  LocationService.to.initialDriverPosition,
                              // set markers on google map
                              markers: LocationService.to.markers.value,
                              // on below line we have given map type
                              mapType: MapType.normal,

                              // disable zoom control
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              polylines: LocationService.to.polyLines,
                              // below line displays google map in our app
                              onMapCreated: (GoogleMapController controller) {
                                if (!LocationService
                                    .to.controller.isCompleted) {
                                  LocationService.to.controller
                                      .complete(controller);
                                  LocationService.to.controllerGoogleMap =
                                      controller;
                                  print("locationsss===>>2dd2");
                                } else {
                                  LocationService.to.controllerGoogleMap =
                                      controller;
                                  print("locationsss===>>222");
                                }
                              },
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 30,
                            child: InkWell(
                              onTap: () =>
                                  LocationService.to.centerCustomerLocation(
                                location:
                                    LocationsController.to.locations.isEmpty
                                        ? LatLng(
                                            LocationService.to.customerLocation
                                                .value!.latitude,
                                            LocationService.to.customerLocation
                                                .value!.longitude,
                                          )
                                        : LatLng(
                                            double.parse(
                                              LocationsController
                                                  .to
                                                  .locations[LocationsController
                                                      .to.indexAddress]
                                                  .lat,
                                            ),
                                            double.parse(
                                              LocationsController
                                                  .to
                                                  .locations[LocationsController
                                                      .to.indexAddress]
                                                  .long,
                                            ),
                                          ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  //    borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                    Icons.location_searching_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
          ),
        );
      },
    );
  }
}
