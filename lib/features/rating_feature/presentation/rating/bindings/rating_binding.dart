import 'package:get/get.dart';
import 'package:otlobgas_driver/features/rating_feature/presentation/rating/controllers/rating_controller.dart';

class RatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingController>(
      () => RatingController(
        addRatingUseCase: Get.find(),
      ),
    );
  }
}
