import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';

extension DoubleExtensions on double {
  String get toPrice {
    return '$this ${LocaleKeys.currency.tr}';
  }
}

extension IntExtensions on int {
  String get getDurationReminder {
    if (toString().length == 1) {
      return '0$this';
    } else {
      return '$this';
    }
  }
}

extension DateTimeExtensions on DateTime? {
  String get appDateFormat {
    if (this == null) {
      return '';
    }

    return DateFormat('d/M/y', 'en').format(this!);
  }
}
