import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';

import '../../../../../core/widgets/back_button_widget.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../controllers/about_app_controller.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutAppController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: CustomText(
              LocaleKeys.aboutApp.tr,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
            ),
            actions: const [
              SizedBox(width: 10),
              BackButtonWidget(),
              SizedBox(width: 10),
            ],
          ),
          body: controller.isLoading
              ? const LoadingWidget()
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SingleChildScrollView(
                      child: SizedBox(
                          width: double.infinity,
                          child: CustomText(controller.aboutApp))),
                ),
        );
      },
    );
  }
}
