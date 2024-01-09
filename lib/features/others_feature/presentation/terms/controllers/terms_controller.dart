import 'package:get/get.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/use_cases/get_terms_use_case.dart';

class TermsController extends GetxController {
  final GetTermsUseCase getTermsUseCase;
  TermsController({required this.getTermsUseCase});

  bool isLoading = false;
  String? terms;

  Future<void> getTerms() async {
    isLoading = true;
    update();
    final result = await getTermsUseCase();

    result.fold((failure) {
      Get.back();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      terms = result;
      print(terms);
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
