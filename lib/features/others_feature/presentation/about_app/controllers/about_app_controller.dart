import 'package:get/get.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/use_cases/get_about_app_use_case.dart';

class AboutAppController extends GetxController {
  final GetAboutAppUseCase getAboutAppUseCase;
  AboutAppController({required this.getAboutAppUseCase});

  bool isLoading = false;
  String? aboutApp;

  Future<void> getTerms() async {
    isLoading = true;
    update();
    final result = await getAboutAppUseCase();

    result.fold((failure) {
      Get.back();

      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      aboutApp = result;
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() async {
    await getTerms();

    super.onInit();
  }
}
