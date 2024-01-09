import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:otlobgas_driver/features/location_feature/data/data_source/location_remote_data_source.dart';
import 'package:otlobgas_driver/features/location_feature/domain/repositories/base_location_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../../../../core/network/network_info.dart';
import '../models/location_model.dart';

class LocationRespoitory implements BaseLocationRepository {
  final BaseLocationRemoteDataSource baseLocationRemoteDataSource;
  BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkInfo networkInfo;

  LocationRespoitory({
    required this.baseLocationRemoteDataSource,
    required this.baseAuthLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<LocationModel>>> getAllLocations() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final locations = await baseLocationRemoteDataSource.getAllLocations(
          currentLanguage: lang,
          token: token,
        );

        return Right(locations);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        return Left(ValidationFailure(message: error.message));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
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
  Future<Either<Failure, List<LocationModel>>> addLocation({
    required String title,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final locations = await baseLocationRemoteDataSource.addLocation(
            currentLanguage: lang,
            token: token,
            title: title,
            lat: lat,
            long: long,
            floorNum: floorNum,
            buildingNum: buildingNum);

        return Right(locations);
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
  Future<Either<Failure, List<LocationModel>>> deleteLocation({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();
        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final ads = await baseLocationRemoteDataSource.deleteLocation(
            currentLanguage: lang, token: token, id: id);

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
  Future<Either<Failure, List<LocationModel>>> editLocation(
      {required String title,
      required String id,
      required double lat,
      required double long,
      String? floorNum,
      String? buildingNum}) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();
        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final locations = await baseLocationRemoteDataSource.editLocation(
            currentLanguage: lang,
            token: token,
            id: id,
            lat: lat,
            long: long,
            title: title,
            buildingNum: buildingNum,
            floorNum: floorNum);

        return Right(locations);
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
}
