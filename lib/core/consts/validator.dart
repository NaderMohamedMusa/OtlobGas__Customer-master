// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';

enum ValidationType {
  phone,
  name,
  cardNumber,
  notEmpty,
  email,
  password,
  validationCode
}

class AppValidator {
  static FilteringTextInputFormatter priceValueOnly() {
    return FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'));
  }

  static String? validateFields(
    String? value,
    ValidationType fieldType,
    BuildContext context,
  ) {
    if (value == null) {
      return LocaleKeys.pleaseFillThisField.tr;
    } else if (fieldType == ValidationType.notEmpty) {
      if (value.trim().isEmpty || value.isEmpty) {
        return LocaleKeys.pleaseFillThisField.tr;
      }
      return null;
    } else if (fieldType == ValidationType.name) {
      if (!RegExp(r'^[a-zA-zأ-ي\s]+$').hasMatch(value)) {
        return LocaleKeys.enterValidName.tr;
      }
      return null;
    } else if (fieldType == ValidationType.email) {
      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
        return LocaleKeys.enterValidEmail.tr;
      }
      return null;
    } else if (fieldType == ValidationType.phone) {
      if (value.trim().isEmpty || value.isEmpty) {
        return LocaleKeys.enterPhoneNumber.tr;
      }
      /* if (!RegExp(r'^1[0125][0-9]{8}$').hasMatch(value)) {
        return Utils.translate(context)?.enter_valid_phone ?? '';
      }*/
      return null;
    } else if (fieldType == ValidationType.cardNumber) {
      if (value.length != 15) {
        return LocaleKeys.validCardNumber.tr;
      }
      return null;
    } else if (fieldType == ValidationType.password) {
      if (value.length < 6) {
        return LocaleKeys.enterValidPassword.tr;
      }
      return null;
    } else if (fieldType == ValidationType.validationCode) {
      if (value.isEmpty || value.length != 4) {
        return LocaleKeys.enterValidVerificationCode.tr;
      }
      return null;
    }
    return null;
  }
}
