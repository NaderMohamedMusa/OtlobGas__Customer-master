import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/core/utils/utils.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/resend_otp_code_usecase.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/verify_account_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/verify_otp_usecase.dart';

import '../../../../../core/consts/k_strings.dart';
import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/services/user_service.dart';

class OtpController extends GetxController {
  final VerifyAccountUseCase verifyAccountUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpCodeUseCase resendOtpCodeUseCase;

  OtpController({
    required this.verifyAccountUseCase,
    required this.verifyOtpUseCase,
    required this.resendOtpCodeUseCase,
    required this.auth,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumber;
  late TextEditingController code;
  late String verId;

  FirebaseAuth auth;

  String? verificationId;
  int timeCounter = 60;
  late Timer timer;

  bool isLoading = false;

  verifyAccountOnBackend() async {
    final result = await verifyAccountUseCase();
    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (user) {
      UserService.to.currentUser.value = user;
      isLoading = false;
      update();
      Get.offAllNamed(Routes.mainLayout);
    });
  }

  Future<void> verifyOtpCode({
    required String code,
    required String phone,
  }) async {
    isLoading = true;
    update();
    final result = await verifyOtpUseCase(
      code: code,
      phone: phone,
    );
    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (user) {
      UserService.to.currentUser.value = user;
      isLoading = false;
      update();
      Get.offAllNamed(Routes.mainLayout);
    });
  }

  Future<void> resendOtpCode({
    required String phone,
  }) async {
    isLoading = true;
    update();
    final result = await resendOtpCodeUseCase(
      phone: phone,
    );
    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (_) {
      isLoading = false;
      startResendTimerCountDown();
      update();
    });
  }

  signInWithCredential() async {
    isLoading = true;
    update();
    // GET CREDENTIAL

    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: code.text,
    );
    try {
      // START LOG IN AUTH

      await auth.signInWithCredential(credential).then((value) async {
        verifyAccountOnBackend();
      });

      // REDIRECT USER TO HOME SCREEN
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      update();
      if (error.code == 'invalid-verification-code') {
        ToastManager.showError(
            'Wrong code, please make sure to write the same code we sent to your phone number in SMS');
      } else {
        ToastManager.showError(error.message!);
      }
    } catch (error) {
      ToastManager.showError(error.toString());
    }
  }

  verifyPhoneNumber() async {
    isLoading = true;
    update();
    RegExp regex = RegExp(r'^0+');
    String phone = phoneNumber.text.toString().replaceFirst(regex, '');
    print("======>s$phone");
    await auth.verifyPhoneNumber(
      phoneNumber: '${Kstrings.countryCode}${phone}',
      codeAutoRetrievalTimeout: (String verId) {
        this.verId = verId;
      },
      codeSent: (String verId, [int? forceCodeResend]) async {
        isLoading = false;
        update();
        // REDIRECT USER TO PIN CODE VIEW
        this.verId = verId;
        startResendTimerCountDown();
      },
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        isLoading = false;
        update();
        if (exception.code == 'invalid-phone-number') {
          ToastManager.showError(LocaleKeys.enterValidPhone.tr);
        } else {
          ToastManager.showError(exception.message!);
        }
      },
    );
  }

  startResendTimerCountDown() {
    timeCounter = 60;

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeCounter == 0) {
          timer.cancel();
        } else {
          timeCounter--;
        }
        update();
      },
    );
  }

  @override
  void onInit() {
    code = TextEditingController();

    if (Get.arguments != null) {
      phoneNumber = TextEditingController(text: Get.arguments['phoneNumber']);
      startResendTimerCountDown();
    }
    super.onInit();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    code.dispose();
    super.dispose();
  }
}
// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:otlobgas_driver/core/routes/app_pages.dart';
// import 'package:otlobgas_driver/core/utils/utils.dart';
// import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/verify_account_use_case.dart';

// import '../../../../../core/consts/k_strings.dart';
// import '../../../../../core/consts/toast_manager.dart';
// import '../../../../../core/languages/app_translations.dart';
// import '../../../../../core/services/user_service.dart';

// class OtpController extends GetxController {
//   VerifyAccountUseCase verifyAccountUseCase;

//   OtpController({
//     required this.verifyAccountUseCase,
//     required this.auth,
//   });

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   late TextEditingController phoneNumber;
//   late TextEditingController code;
//   late String verId;

//   FirebaseAuth auth;

//   String? verificationId;
//   int timeCounter = 60;
//   late Timer timer;

//   bool isLoading = false;

//   verifyAccountOnBackend() async {
//     final result = await verifyAccountUseCase();
//     result.fold((failure) {
//       isLoading = false;
//       update();
//       ToastManager.showError(Utils.mapFailureToMessage(failure));
//     }, (user) {
//       UserService.to.currentUser.value = user;
//       isLoading = false;
//       update();
//       Get.offAllNamed(Routes.mainLayout);
//     });
//   }

//   signInWithCredential() async {
//     isLoading = true;
//     update();
//     // GET CREDENTIAL

//     final AuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verId,
//       smsCode: code.text,
//     );
//     try {
//       // START LOG IN AUTH

//       await auth.signInWithCredential(credential).then((value) async {
//         verifyAccountOnBackend();
//       });

//       // REDIRECT USER TO HOME SCREEN
//     } on FirebaseAuthException catch (error) {
//       isLoading = false;
//       update();
//       if (error.code == 'invalid-verification-code') {
//         ToastManager.showError(
//             'Wrong code, please make sure to write the same code we sent to your phone number in SMS');
//       } else {
//         ToastManager.showError(error.message!);
//       }
//     } catch (error) {
//       ToastManager.showError(error.toString());
//     }
//   }

//   verifyPhoneNumber() async {
//     isLoading = true;
//     update();
//     RegExp regex =RegExp(r'^0+');
//    String phone=phoneNumber.text.toString().replaceFirst(regex, '');
//    print("======>s$phone");
//     await auth.verifyPhoneNumber(
//       phoneNumber: '${Kstrings.countryCode}${phone}',
//       codeAutoRetrievalTimeout: (String verId) {
//         this.verId = verId;
//       },
//       codeSent: (String verId, [int? forceCodeResend]) async {
//         isLoading = false;
//         update();
//         // REDIRECT USER TO PIN CODE VIEW
//         this.verId = verId;
//         startResendTimerCountDown();
//       },
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: (AuthCredential phoneAuthCredential) async {
//         await auth.signInWithCredential(phoneAuthCredential);
//       },
//       verificationFailed: (FirebaseAuthException exception) {
//         isLoading = false;
//         update();
//         if (exception.code == 'invalid-phone-number') {
//           ToastManager.showError(LocaleKeys.enterValidPhone.tr);
//         } else {
//           ToastManager.showError(exception.message!);
//         }
//       },
//     );
//   }

//   startResendTimerCountDown() {
//     timeCounter = 60;

//     const oneSec = Duration(seconds: 1);
//     timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (timeCounter == 0) {
//           timer.cancel();
//         } else {
//           timeCounter--;
//         }
//         update();
//       },
//     );
//   }

//   @override
//   void onInit() {
//     code = TextEditingController();

//     if (Get.arguments != null) {
//       phoneNumber = TextEditingController(text: Get.arguments['phoneNumber']);
//       verifyPhoneNumber();
//     }
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     phoneNumber.dispose();
//     code.dispose();
//     super.dispose();
//   }
// }
