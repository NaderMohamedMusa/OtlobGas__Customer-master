import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:otlobgas_driver/features/rating_feature/data/data_source/rating_remote_data_source.dart';

import 'package:otlobgas_driver/features/rating_feature/domain/repositories/base_rating_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';
import '../models/rating_model.dart';

class RatingRespoitory implements BaseRatingRepository {
  final BaseRatingRemoteDataSource baseRatingRemoteDataSource;
  BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkInfo networkInfo;

  RatingRespoitory({
    required this.baseRatingRemoteDataSource,
    required this.baseAuthLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addRating({
    required String comment,
    required int rating,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final order = await baseRatingRemoteDataSource.addRating(
          comment: comment,
          rating: rating,
          currentLanguage: lang,
          token: token,
        );

        return Right(order);
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
  Future<Either<Failure, RatingModel>> getRating(
      {required String currentPage}) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final rating = await baseRatingRemoteDataSource.getRating(
          currentPage: currentPage,
          currentLanguage: lang,
          token: token,
        );

        return Right(rating);
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
