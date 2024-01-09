import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth_feature/domain/use_cases/get_lang_use_case.dart';
import '../../features/auth_feature/domain/use_cases/save_lang_use_case.dart';

class LanguageService extends GetxService {
  GetLangUseCase getLangUseCase;
  SaveLangUseCase saveLangUseCase;

  LanguageService({
    required this.getLangUseCase,
    required this.saveLangUseCase,
  });

  static LanguageService get to => Get.find();

  Rx<String> savedLang = Rx('ar');

  Future<LanguageService> init() async {
    await Future.wait([
      getLang(),
    ]);
    return this;
  }

  /// Change Language
  Future<void> onChangeLang({required String lang}) async {
    var saveLang = await saveLangUseCase(lang: lang);

    saveLang.fold(
      (l) {},
      (r) {
        Get.updateLocale(Locale(lang));
        savedLang.value = lang;
      },
    );
  }

  Future<void> getLang() async {
    var getLang = await getLangUseCase();

    getLang.fold(
      (failure) {},
      (result) {
        savedLang.value = result;
      },
    );
  }
}
