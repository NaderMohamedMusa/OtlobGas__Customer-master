import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:otlobgas_driver/features/auth_feature/data/models/last_week_model.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/repositories/base_auth_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/utils/hold_message_with.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/ads_model.dart';
import '../models/orders_count_model.dart';
import '../models/user_model.dart';

class AuthRespoitory implements BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  final BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRespoitory({
    required this.baseAuthRemoteDataSource,
    required this.baseAuthLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String mobile,
    XFile? image,
    required String password,
    required String confirmPassword,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.register(
          name: name,
          email: email,
          mobile: mobile,
          image: image,
          password: password,
          confirmPassword: confirmPassword,
          currentLanguage: lang,
        );

        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token ?? '');
        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, UserModel>> logIn({
    required String mobile,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.login(
          mobile: mobile,
          password: password,
          currentLanguage: lang,
        );
        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token!);
        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, String>> sendToken({required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await baseAuthRemoteDataSource.sendToken(
          email: email,
        );

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, UserModel>> verifyAccount() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        var lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.verifyAccount(
          token: token,
          currentLanguage: lang,
        );
        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token!);
        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, List<AdsModel>>> getAds() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();
        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final ads = await baseAuthRemoteDataSource.getAds(
          currentLanguage: lang,
          token: token,
        );

        return Right(ads);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();
        print("xx====> {${await FirebaseMessaging.instance.getToken()}}");

        var lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.getUserData(
          token: token,
          currentLanguage: lang,
        );
        await baseAuthLocalDataSource.writeUser(user: user);
        if (user.token != null) {
          await baseAuthLocalDataSource.writeToken(token: user.token!);
        }

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();
        print("====> ${await FirebaseMessaging.instance.getToken()}");

        // await FirebaseMessaging.instance.deleteToken();

        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, String>> getLang() async {
    try {
      final userLang = await baseAuthLocalDataSource.readUserLanguage();

      return Right(userLang);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLang({required String lang}) async {
    try {
      await baseAuthLocalDataSource.writeUserLanguage(lang: lang);
      return const Right(unit);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, User>> editUser(
      {required String name,
      required String email,
      XFile? image,
      required String password,
      required String confirmPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        final user = await baseAuthRemoteDataSource.editAccount(
          name: name,
          email: email,
          image: image,
          password: password,
          confirmPassword: confirmPassword,
          currentLanguage: await baseAuthLocalDataSource.readUserLanguage(),
          token: token,
        );

        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token!);
        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, HoldMessageWith<UserModel>>> changeUserActivity({
    required String lat,
    required String long,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.changeUserActivity(
          lat: lat,
          long: long,
          token: token,
          currentLanguage: lang,
        );
        await baseAuthLocalDataSource.writeUser(user: user.data);
        await baseAuthLocalDataSource.writeToken(token: user.data.token!);
        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, HoldMessageWith<User>>> chargeBalance({
    required String cardNumber,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.chargeBalance(
          cardNumber: cardNumber,
          token: token,
          currentLanguage: lang,
        );
        await baseAuthLocalDataSource.writeUser(user: user.data);
        await baseAuthLocalDataSource.writeToken(token: user.data.token!);
        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, List<LastWeekModel>>> getLastWeek() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.getLastWeek(
          token: token,
          currentLanguage: lang,
        );

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, OrdersCountModel>> getOrdersCount() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final orderCounts = await baseAuthRemoteDataSource.getOrdersCount(
          token: token,
          currentLanguage: lang,
        );

        return Right(orderCounts);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        await baseAuthRemoteDataSource.logOut(
          token: token,
          currentLanguage: lang,
        );

        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);

        return const Right(unit);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeAccount() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        await baseAuthRemoteDataSource.removeAccount(
          token: token,
          currentLanguage: lang,
        );

        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);

        return const Right(unit);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String token,
    required String pass,
    required String conPass,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final message = await baseAuthRemoteDataSource.resetPassword(
          email: email,
          token: token,
          pass: pass,
          conPass: conPass,
        );

        return Right(message);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserLocation({
    required String lat,
    required String long,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.updateUserLocation(
          lat: lat,
          long: long,
          token: token,
          currentLanguage: lang,
        );

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
        await FirebaseMessaging.instance.requestPermission();

        await FirebaseMessaging.instance.deleteToken();
        Get.offAllNamed(Routes.login);
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtpCode(
      {required String code, required String phone}) async {
    if (await networkInfo.isConnected) {
      try {
        // String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseAuthRemoteDataSource.verifyOtpCode(
          code: code,
          phone: phone,
        );
        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token ?? '');
        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ServerException {
        return Left(ServerFailure());
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, Unit>> resendOtpCode({required String phone}) async {
    if (await networkInfo.isConnected) {
      try {
        await baseAuthRemoteDataSource.resendOtpCode(
          phone: phone,
        );
        return const Right(unit);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        return Left(UnAuthenticatedFailure(message: error.message));
      } on UnExpectedException {
        return Left(UnExpectedFailure(message: LocaleKeys.unExpectedError.tr));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      }
    } else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }
}
