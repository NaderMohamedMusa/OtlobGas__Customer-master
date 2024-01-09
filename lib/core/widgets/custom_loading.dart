// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../consts/assets.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    required this.widget,
    required this.isLoading,
  });

  final Widget widget;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget,
        if (isLoading)
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.grey.withOpacity(.5),
            child: Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: LottieBuilder.asset(Assets.loading),
              ),
            ),
          ),
      ],
    );
  }
}
