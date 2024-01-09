import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/consts/assets.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/core/theme/app_colors.dart';
import 'package:otlobgas_driver/core/widgets/custom_button.dart';
import 'package:otlobgas_driver/core/widgets/custom_text.dart';
import 'package:otlobgas_driver/features/location_feature/presentation/locations/controllers/locations_controller.dart';

import '../../../../../core/widgets/loading_widget.dart';

class SelectLocationView extends StatelessWidget {
  const SelectLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationsController>(
      init: LocationsController(
        getAllLocationUseCase: Get.find(),
        deleteLocationUseCase: Get.find(),
      ),
      autoRemove: false,
      builder: (controller) {
        return controller.isLoading
            ? const SizedBox(width: 50, height: 50, child: LoadingWidget())
            : controller.locations.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: controller.indexAddress == index
                              ? Colors.blue.withOpacity(0.2)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          border: controller.indexAddress != index
                              ? null
                              : Border.all(color: Colors.grey.shade400),
                        ),
                        child: ListTile(
                          trailing: SizedBox(
                            width: 70,
                            child: Row(children: [
                              InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.editLocation,
                                      arguments: controller.locations[index],
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.dialog(GetBuilder<LocationsController>(
                                    builder: (controller) {
                                      return Stack(
                                        children: [
                                          AlertDialog(
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                            titlePadding:
                                                const EdgeInsets.all(20),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                  LocaleKeys
                                                      .deleteLocationAlert.tr,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomButton(
                                                      onPressed: () {
                                                        if (Get.isDialogOpen!) {
                                                          Get.back();
                                                        }
                                                      },
                                                      color: Colors.red,
                                                      child: CustomText(
                                                        LocaleKeys.cancel.tr,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    CustomButton(
                                                      onPressed: () =>
                                                          controller
                                                              .deleteLocation(
                                                        locationID: controller
                                                            .locations[index].id
                                                            .toString(),
                                                      ),
                                                      color: AppColors.mainApp,
                                                      child: CustomText(
                                                        LocaleKeys.delete.tr,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          if (controller.isLoading)
                                            Container(
                                              color:
                                                  Colors.grey.withOpacity(.5),
                                              child: Center(
                                                child: SizedBox(
                                                  width: 150,
                                                  height: 150,
                                                  child: LottieBuilder.asset(
                                                      Assets.loading),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ));
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ]),
                          ),
                          visualDensity:
                              const VisualDensity(vertical: -4, horizontal: -4),
                          title: CustomText(
                            controller.locations[index].title,
                          ),
                          leading: SvgPicture.asset(Assets.locationFilledIC),
                          onTap: () => controller.setIndexAddress(index),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext _, int __) {
                      return const Divider(
                        thickness: 1,
                        height: 5,
                        color: AppColors.divider,
                      );
                    },
                    itemCount: controller.locations.length,
                  )
                : Center(
                    child: CustomText(
                      LocaleKeys.noLocations.tr,
                    ),
                  );
      },
    );
  }
}
