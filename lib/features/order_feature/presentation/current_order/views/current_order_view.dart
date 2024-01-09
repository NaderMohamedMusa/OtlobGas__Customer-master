import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/enums.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../core/theme/font_manager.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_cached_image.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/notification_button_widget.dart';
import '../controllers/current_order_controller.dart';
import 'components/create_order_options_slide_panel.dart';
import 'components/current_order_slide_panel.dart';

class CurrentOrderView extends StatelessWidget {
  const CurrentOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CurrentOrderController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: controller.isLoading.value
                ? CustomText(
                    LocaleKeys.askGasUnit.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 25),
                  )
                : CustomText(
                    controller.orderStatus,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 25),
                  ),
            leading: const SizedBox(),
            actions: [
              const NotificationButton(),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  if (!controller.isLoading.value)
                    Obx(() {
                      if (controller.order.value!.status ==
                          OrderStatus.create) {
                        return Stack(
                          children: [
                            Column(
                              children: [
                                Material(
                                  elevation: 5,
                                  child: Container(
                                    width: Get.width,
                                    color: Colors.white,
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              /// user image
                                              Container(
                                                height: 40,
                                                width: 40,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle),
                                                child: CustomCachedNetworkImage(
                                                  url: controller.order.value!
                                                      .driver.image,
                                                  boxFit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 5),

                                              /// user name
                                              Text(
                                                controller
                                                    .order.value!.driver.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeightManger
                                                              .regular,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),

                                          /// storehouse location
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.locationOutlinedIC,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                controller
                                                        .order.value?.address ??
                                                    "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                    thickness: 2,
                                    height: 2,
                                    color: Colors.grey[300]),

                                /// rating - arrive time - other data
                                Material(
                                  elevation: 5,
                                  child: Container(
                                    width: Get.width,
                                    color: Colors.white,
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// rating
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.starFilled,
                                                height: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                controller
                                                    .order.value!.driver.rate,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(fontSize: 18),
                                              )
                                            ],
                                          ),

                                          /// arrive time
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  Assets.clockGreyIC),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                controller.order.value?.time
                                                        .toString() ??
                                                    '0',
                                                // Intl.pluralLogic(

                                                //    controller.order.value.time,
                                                //   locale:
                                                //       Intl.canonicalizedLocale(
                                                //     LanguageService
                                                //         .to.savedLang.value,
                                                //   ),
                                                //   other:
                                                //       '${0} ${LocaleKeys.minutesToArrive.tr}',
                                                //   one:
                                                //       '${0} ${LocaleKeys.minuteToArrive.tr}',
                                                //   zero: LocaleKeys.arrived.tr,
                                                // ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(fontSize: 18),
                                              )
                                            ],
                                          ),

                                          /// other data
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.idCartIC,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                LocaleKeys.otherData.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }

                      return const SizedBox();
                    }),
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          controller.order.value!.customerLat,
                          controller.order.value!.customerLng,
                        ),
                        zoom: 20,
                      ),
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
                        if (!LocationService.to.controller.isCompleted) {
                          LocationService.to.controller.complete(controller);
                          LocationService.to.controllerGoogleMap = controller;
                        } else {
                          LocationService.to.controllerGoogleMap = controller;
                        }
                      },
                    ),
                  ),
                ],
              ),
              if (!controller.isLoading.value)
                Obx(
                  () {
                    if (controller.order.value!.status == OrderStatus.create) {
                      return const CreateOrderOptionsSlidePanel();
                    } else if (controller.order.value!.status ==
                        OrderStatus.sendToDriver) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: LoadingWidget(
                          description: LocaleKeys.waitingDriverAcceptance.tr,
                        ),
                      );
                    } else if (controller.order.value!.status ==
                            OrderStatus.acceptDriver ||
                        controller.order.value!.status ==
                            OrderStatus.delivered) {
                      return Stack(
                        children: [
                          Positioned(
                            top: 30,
                            right: 30,
                            child: InkWell(
                              onTap: () =>
                                  LocationService.to.centerCustomerLocation(
                                location: LatLng(
                                  controller.order.value!.customerLat,
                                  controller.order.value!.customerLng,
                                ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      color: Colors.black26,
                                    ),
                                  ],
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
                          CurrentOrderSlidePanel(
                              order: controller.order.value!),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              else
                const LoadingWidget()
            ],
          ),
        );
      },
    );
  }
}
