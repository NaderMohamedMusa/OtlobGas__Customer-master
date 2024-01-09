import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/consts/assets.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/theme/app_colors.dart';
import 'package:otlobgas_driver/core/widgets/custom_text.dart';

import '../../../../../core/consts/validator.dart';
import '../../../../../core/theme/font_manager.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../controllers/add_location_controller.dart';
import 'components/select_location_on_map.dart';

class AddLocationView extends StatelessWidget {
  const AddLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocationController>(
      init: AddLocationController(
        addLocationUseCase: Get.find(),
      ),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leading: const SizedBox(),
            title: Text(
              LocaleKeys.addLocation.tr,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeightManger.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
          ),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  /// top button
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            Assets.map,
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: ElevatedButton(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              minimumSize: MaterialStateProperty.all<Size>(
                                const Size(250, 50),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(
                                      fontSize: 20,
                                      fontFamily: FontConstants.fontFamily)),
                            ),
                        onPressed: () => Get.to(
                          () => const SelectLocationOnMap(),
                          arguments: controller.latLng,
                        ),
                        child: Text(
                          LocaleKeys.confirmMyLocation.tr,
                        ),
                      ),
                    ),
                  ),
                  if (controller.isLatLngEmpty) const SizedBox(height: 10),
                  if (controller.isLatLngEmpty)
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        CustomText(
                          LocaleKeys.emptyConfirmMyLocation.tr,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),

                  const SizedBox(height: 10),

                  /// text edit forms
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            LocaleKeys.buildingNumber.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontWeight: FontWeightManger.regular),
                          ),
                          const SizedBox(height: 20),

                          /// building number
                          CustomTextField(
                            prefixText: '     ',
                            prefixIcon: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: SvgPicture.asset(
                                  Assets.locationOutlinedIC,
                                  color: AppColors.mainApp,
                                )),
                            hintText: LocaleKeys.hintDash.tr,
                            textEditingController:
                                controller.buildingNumberController,
                            // validator: (value) => AppValidator.validateFields(
                            //     value, ValidationType.notEmpty, context),
                          ),
                          const SizedBox(height: 40),

                          /// floor number
                          CustomText(
                            LocaleKeys.floorNumber.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontWeight: FontWeightManger.regular),
                          ),
                          const SizedBox(height: 20),

                          /// floor number
                          CustomTextField(
                            prefixText: '     ',
                            prefixIcon: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: SvgPicture.asset(
                                  Assets.locationOutlinedIC,
                                  color: AppColors.mainApp,
                                )),
                            hintText: LocaleKeys.hintDash.tr,
                            textEditingController:
                                controller.floorNumberController,
                            // validator: (value) => AppValidator.validateFields(
                            //     value, ValidationType.notEmpty, context),
                          ),

                          const SizedBox(height: 40),

                          /// title
                          CustomText(
                            LocaleKeys.addressTitle.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontWeight: FontWeightManger.regular),
                          ),
                          const SizedBox(height: 20),

                          /// title
                          CustomTextField(
                            prefixText: '     ',
                            prefixIcon: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: SvgPicture.asset(
                                  Assets.locationOutlinedIC,
                                  color: AppColors.mainApp,
                                )),
                            hintText: LocaleKeys.hintDash.tr,
                            textEditingController: controller.titleController,
                            validator: (value) => AppValidator.validateFields(
                                value, ValidationType.notEmpty, context),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height / 36.6),

                  // add or edit button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => controller.addLocation(),
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                              minimumSize: MaterialStateProperty.all<Size>(
                                const Size(double.infinity, 50),
                              ),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(
                                      fontSize: 25,
                                      fontFamily: FontConstants.fontFamily)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero))),
                      child: Text(
                        LocaleKeys.addLocation.tr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
