import 'package:get/get.dart';

import '../controllers/account_balance_controller.dart';

class AccountBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountBalanceController>(
      () => AccountBalanceController(chargeBalanceUseCase: Get.find(),getLastWeekUseCase: Get.find(),),
    );
  }
}
