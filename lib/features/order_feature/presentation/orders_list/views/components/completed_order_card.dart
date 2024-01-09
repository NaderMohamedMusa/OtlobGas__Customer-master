// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/consts/enums.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/utils/extensions.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/widgets/custom_text.dart';

class CompletedOrderCard extends StatelessWidget {
  const CompletedOrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;
  SvgPicture get currentIcon {
    switch (order.status) {
      case OrderStatus.delivered:
        return SvgPicture.asset(
          Assets.orderDoneIC,
          height: 20,
        );
      case OrderStatus.sendToDriver:
        return SvgPicture.asset(
          Assets.clockBlueIC,
          height: 20,
        );
      default:
        return SvgPicture.asset(
          Assets.warning,
          height: 20,
        );
    }
  }

  String get orderStatus {
    switch (order.status) {
      case OrderStatus.delivered:
        return LocaleKeys.delivered.tr;
      case OrderStatus.cancelByCustomer:
        return LocaleKeys.canceledByCustomer.tr;
      default:
        return LocaleKeys.canceled.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: ListTile(
          leading: Image.asset(Assets.ambobaIC, width: 40, height: 40),
          title: CustomText(
              "${LocaleKeys.numberOfCylinders.tr} ${order.quantity}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                order.createdAt.appDateFormat,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              CustomText(
                "",
                // "${LocaleKeys.yourProfitPercentage.tr} : ${order.driverPrice.toPrice}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
          trailing: SizedBox(
            width: 120,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                currentIcon,
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  orderStatus,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ));
  }
}
