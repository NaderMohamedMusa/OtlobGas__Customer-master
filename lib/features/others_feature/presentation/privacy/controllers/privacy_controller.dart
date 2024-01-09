import 'package:get/get.dart';
import 'package:otlobgas_driver/features/others_feature/domain/use_cases/get_privacy_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';

class PrivacyController extends GetxController {
  final GetPrivacyUseCase getPrivacyUseCase;
  PrivacyController({required this.getPrivacyUseCase});

  bool isLoading = false;
  String? privacy;

  Future<void> getPrivacy() async {
    isLoading = true;
    update();
    final result = await getPrivacyUseCase();

    result.fold(
      (failure) {
        Get.back();
        ToastManager.showError(Utils.mapFailureToMessage(failure));
      },
      (result) {
        privacy = result;
        isLoading = false;
        update();
      },
    );
  }

  @override
  void onInit() async {
    await getPrivacy();

    super.onInit();
  }
}
