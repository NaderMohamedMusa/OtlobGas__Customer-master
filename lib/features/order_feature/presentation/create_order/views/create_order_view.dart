import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/validator.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/font_manager.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../controllers/create_order_controller.dart';

class CreateOrderView extends StatelessWidget {
  const CreateOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateOrderController>(
      init: CreateOrderController(
        createOrderUseCase: Get.find(),
      ),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leading: const SizedBox(),
            title: Text(
              LocaleKeys.confirmAddress.tr,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeightManger.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
          ),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                /// text edit forms
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      const SizedBox(height: 10),
                      CustomText(
                        LocaleKeys.addressTitle.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeightManger.regular),
                      ),
                      const SizedBox(height: 20),

                      /// building number
                      CustomTextField(
                        enabled: false,
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

                      CustomText(
                        LocaleKeys.buildingNumber.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeightManger.regular),
                      ),
                      const SizedBox(height: 20),

                      /// building number
                      CustomTextField(
                        enabled: false,
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
                      ),
                      const SizedBox(height: 20),

                      /// floor number
                      CustomText(
                        LocaleKeys.floorNumber.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeightManger.regular),
                      ),
                      const SizedBox(height: 20),

                      /// building number
                      CustomTextField(
                        enabled: false,
                        prefixText: '     ',
                        prefixIcon: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: SvgPicture.asset(
                              Assets.locationOutlinedIC,
                              color: AppColors.mainApp,
                            )),
                        hintText: LocaleKeys.hintDash.tr,
                        textEditingController: controller.floorNumberController,
                      ),
                      const SizedBox(height: 20),

                      /// notes text for driver
                      CustomText(
                        LocaleKeys.notsToDrive.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeightManger.regular),
                      ),
                      const SizedBox(height: 20),

                      /// notes for driver text form filed
                      CustomTextField(
                        isMultiLine: true,
                        prefixText: '     ',
                        prefixIcon: SizedBox(
                          width: 20,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(Assets.attentionsIC,
                                    color: Colors.grey),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 35,
                          minHeight: 0,
                        ),
                        hintText: LocaleKeys.hintDash.tr,
                        textEditingController: controller.driverNotesController,
                        validator: (value) => AppValidator.validateFields(
                            value, ValidationType.notEmpty, context),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),

                /// bottom content
                ElevatedButton(
                  onPressed: () => controller.createOrder(),
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 50),
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(
                                fontSize: 25,
                                fontFamily: FontConstants.fontFamily)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                  child: Text(LocaleKeys.continue_.tr),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
