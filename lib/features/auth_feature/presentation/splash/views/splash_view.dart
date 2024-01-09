import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/splash/controllers/splash_controller.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/theme/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.splash,
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Spacer(),
            Image.asset(
              Assets.splashTop,
              height: 200,
            ),
            const Spacer(),
            Image.asset(
              Assets.splashCenter,
              height: 250,
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            const Spacer(),
            Image.asset(
              Assets.splashBottom,
            ),
          ]),
        );
      },
    );
  }
}
