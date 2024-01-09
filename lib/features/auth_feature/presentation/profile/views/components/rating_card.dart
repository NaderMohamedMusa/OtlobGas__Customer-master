import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/entities/rating_content.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.ratingContent,
  }) : super(key: key);
  final RatingContent ratingContent;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// time and rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.clockGreyIC,
                  width: 20,
                ),
                const SizedBox(width: 8),
                CustomText(
                  DateFormat.yMd().format(ratingContent.createdAt),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black, fontSize: 25),
                ),
                const Spacer(),

                /// rate
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.starFilled,
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      ratingContent.rating.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black, fontSize: 25),
                    ),
                  ],
                )
              ],
            ),
          ),
          // const Divider(color: AppColors.notActive),

          /// text review
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: CustomText(
          //     ratingContent.comment,
          //     style: Theme.of(context)
          //         .textTheme
          //         .bodySmall
          //         ?.copyWith(color: Colors.black, fontSize: 22),
          //   ),
          // ),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }
}
