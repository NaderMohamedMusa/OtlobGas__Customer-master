import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/consts/assets.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/theme/app_colors.dart';
import 'package:otlobgas_driver/core/widgets/custom_button.dart';
import 'package:otlobgas_driver/core/widgets/custom_text.dart';

import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../controllers/locations_controller.dart';

class LocationsView extends StatelessWidget {
  const LocationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationsController>(
      init: LocationsController(
        getAllLocationUseCase: Get.find(),
        deleteLocationUseCase: Get.find(),
      ),
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: CustomText(
              LocaleKeys.locations.tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: controller.locations.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) {
                            return ListTile(
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: -4),
                              title: CustomText(
                                controller.locations[index].title,
                              ),
                              leading:
                                  SvgPicture.asset(Assets.locationFilledIC),
                              onTap: () => Get.toNamed(
                                Routes.editLocation,
                                arguments: controller.locations[index],
                              ),
                              trailing: IconButton(
                                onPressed: () => Get.dialog(
                                  GetBuilder<LocationsController>(
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
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 24,
                                ),
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CustomButton(
                          width: double.infinity,
                          height: 50,
                          onPressed: () => Get.toNamed(Routes.addLocation),
                          child: Text(
                            LocaleKeys.addLocation.tr,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CustomText(
                      LocaleKeys.noLocations.tr,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
