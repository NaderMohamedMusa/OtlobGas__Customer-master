import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/charge_balance_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/get_last_week_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/entities/last_week.dart';

class AccountBalanceController extends GetxController {
  ChargeBalanceUseCase chargeBalanceUseCase;
  GetLastWeekUseCase getLastWeekUseCase;
  AccountBalanceController({
    required this.chargeBalanceUseCase,
    required this.getLastWeekUseCase,
  });

  static AccountBalanceController get to => Get.find();

  double currentBalance = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();

  List<LastWeek> lastWeek = [];

  bool isLoading = false;

  Future<void> chargeBalance() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading = true;
    update();
    final result =
        await chargeBalanceUseCase(cardNumber: cardNumberController.text);

    result.fold((failure) {
      isLoading = false;
      update();

      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) async {
      await AssetsAudioPlayer.newPlayer().open(
        Audio("assets/audios/order.mp3"),
        autoStart: true,
        showNotification: false,
      );
      UserService.to.currentUser.value = result.data;
      await getLastWeek();

      if (Get.isDialogOpen!) {
        Get.back();
      }

      ToastManager.showSuccess(result.message);
    });
  }

  Future<void> getLastWeek() async {
    isLoading = true;
    update();
    final result = await getLastWeekUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
    }, (result) {
      lastWeek = result;
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() async {
    await getLastWeek();

    super.onInit();
  }
}
