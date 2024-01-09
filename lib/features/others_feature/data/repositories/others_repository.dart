import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:otlobgas_driver/features/others_feature/data/models/nearest_driver_model.dart';
import 'package:otlobgas_driver/features/others_feature/domain/repositories/base_others_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';
import '../data_source/others_remote_data_source.dart';

class OthersRespoitory implements BaseOthersRepository {
  final BaseOthersRemoteDataSource baseOthersRemoteDataSource;
  final BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkInfo networkInfo;

  OthersRespoitory({
    required this.baseOthersRemoteDataSource,
    required this.baseAuthLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<NearestDriverModel>>> getNearestDrivers({
    required String lat,
    required String long,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        final nearestDrivers =
            await baseOthersRemoteDataSource.getNearestDrivers(
          lat: lat,
          long: long,
          token: token,
        );

        return Right(nearestDrivers);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
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
  Future<Either<Failure, String>> getTerms() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await baseOthersRemoteDataSource.getTerms();

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
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
  Future<Either<Failure, String>> getPrivacy() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await baseOthersRemoteDataSource.getPrivacy();

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
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
  Future<Either<Failure, String>> getAboutApp() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await baseOthersRemoteDataSource.getAboutApp();

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
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
  Future<Either<Failure, String>> contactUs({
    required String title,
    required String message,
    required String file,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final messageR = await baseOthersRemoteDataSource.contactUs(
          title: title,
          message: message,
          file: file,
          currentLanguage: lang,
          token: token,
        );

        return Right(messageR);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
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
  Future<Either<Failure, String>> getPhoneNumber() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();
        final user =
            await baseOthersRemoteDataSource.getPhoneNumber(token: token);

        return Right(user);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();
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
}
