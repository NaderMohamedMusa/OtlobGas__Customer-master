import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../consts/assets.dart';
import '../theme/app_colors.dart';
import 'custom_text.dart';

class LocationRowWidget extends StatelessWidget {
  const LocationRowWidget({
    Key? key,
    required this.address,
    this.isCenter = true,
    this.color,
  }) : super(key: key);

  final String? address;
  final Color? color;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        const SizedBox(width: 10.0),
        SvgPicture.asset(
          Assets.locationOutlinedIC,
          color: AppColors.lightRed,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: CustomText(
            address,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
