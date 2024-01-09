import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/features/rating_feature/presentation/rating/controllers/rating_controller.dart';
import '../../../../../core/consts/assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/font_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/notification_button_widget.dart';

class RatingView extends StatelessWidget {
  const RatingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: AppColors.mainApp,
            title: Text(
              LocaleKeys.deliveryServiceRating.tr,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeightManger.bold),
            ),
            centerTitle: false,
            actions: const [
              NotificationButton(),
              SizedBox(width: 10.0),
            ],
          ),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: ListView(
              children: [
                /// head image review
                Image.asset(Assets.rate),
                const SizedBox(height: 50.0),

                /// rating builder
                Center(
                  child: RatingBar(
                    initialRating: controller.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    textDirection: TextDirection.ltr,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                        empty: SvgPicture.asset(
                          Assets.starOutlined,
                        ),
                        full: SvgPicture.asset(
                          Assets.starFilled,
                        ),
                        half: const SizedBox()),
                    unratedColor: Colors.grey,
                    onRatingUpdate: (rating) => controller.setRating = rating,
                  ),
                ),

                // rating text
                const SizedBox(height: 10.0),
                Center(
                  child: CustomText(
                    LocaleKeys.deliveryServiceRating.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeightManger.bold,
                          fontSize: 30,
                        ),
                  ),
                ),
                const SizedBox(height: 10.0),

                /// review form filed
                controller.isBadRating
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              CustomText(
                                  LocaleKeys
                                      .whatIsTheReasonForThePoorServiceRating
                                      .tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        fontWeight: FontWeightManger.semiBold,
                                        color: Colors.black,
                                        fontSize: 20,
                                      )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4.2,
                            child: SimpleGroupedCheckbox<String>(
                              controller:
                                  GroupController(isMultipleSelection: true),
                              onItemSelected: (value) {
                                print(value);
                                controller.selectionListName = value;
                              },
                              itemsTitle: controller.allSelection,
                              values: controller.allSelection,
                              groupStyle: GroupStyle(
                                  activeColor: AppColors.mainApp,
                                  itemTitleStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeightManger.regular,
                                        fontSize: 20,
                                      )),
                              checkFirstElement: false,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          isMultiLine: true,
                          textEditingController: controller.commentController,
                          hintText: LocaleKeys.yourReviewForEvaluation.tr,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeightManger.regular,
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                        ),
                      ),
                const SizedBox(height: 10.0),

                /// confirm review button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomButton(
                      height: 45,
                      width: double.infinity,
                      onPressed: () => controller.addRating(),
                      color: AppColors.mainApp,
                      child: Text(
                        LocaleKeys.confirmRating.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeightManger.regular,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                      )),
                ),
                const SizedBox(height: 8.0),

                // rating anther time
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomButton(
                    height: 45,
                    width: double.infinity,
                    onPressed: () => Get.back(),
                    color: Colors.white,
                    borderColor: AppColors.mainApp,
                    child: Text(
                      LocaleKeys.rateLater.tr,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeightManger.regular,
                                color: AppColors.mainApp,
                                fontSize: 18,
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
