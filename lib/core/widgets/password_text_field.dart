import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';

import '../consts/assets.dart';
import '../consts/validator.dart';
import 'custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key, required this.controller, this.isEditMode = false});
  final TextEditingController controller;
  final bool isEditMode;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;
  toggleObscure() {
    isObscure = !isObscure;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      // suffixIcon:
      //     IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
      prefixText: '     ',
      prefixIcon: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[300],
          child: SvgPicture.asset(Assets.activeSecretIC)),
      isObscure: isObscure,
      hintText: LocaleKeys.writePass.tr,
      textEditingController: widget.controller,
      validator: (value) {
        if (value!.isEmpty && widget.isEditMode) {
          return null;
        }
        return AppValidator.validateFields(
            value, ValidationType.password, context);
      },
    );
  }
}
