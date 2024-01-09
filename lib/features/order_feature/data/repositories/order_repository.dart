import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:otlobgas_driver/features/order_feature/data/models/order_model.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/orders_pagenation.dart';

import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';
import '../data_source/order_remote_data_source.dart';

class OrderRespoitory implements BaseOrderRepository {
  final BaseOrderRemoteDataSource baseOrderRemoteDataSource;
  BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkInfo networkInfo;

  OrderRespoitory({
    required this.baseOrderRemoteDataSource,
    required this.baseAuthLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OrderModel>> checkAvailableOrder() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final order = await baseOrderRemoteDataSource.checkAvailableOrder(
          currentLanguage: lang,
          token: token,
        );

        return Right(order);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
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
  Future<Either<Failure, OrderModel>> createOrder({
    required String locationId,
    required String notes,
  }) async {
    debugPrint("dssssssfr333=======>>> ");
    if (await networkInfo.isConnected) {
      debugPrint("dssssssfr3444=======>>> ");
      try {
        debugPrint("dssssssfr34555=======>>> ");
        String token = await baseAuthLocalDataSource.readToken();
        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final order = await baseOrderRemoteDataSource.createOrder(
          locationId: locationId,
          notes: notes,
          currentLanguage: lang,
          token: token,
        );

        debugPrint("order=======>>> $order");

        return Right(order);
      } on AuthException catch (error) {
        debugPrint("order=======>>> $error");
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        debugPrint("order=======>>> $error");
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        debugPrint("order=======>>> $error");
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
    }
    else {
      return Left(NetworkFailure(message: LocaleKeys.networkFailure.tr));
    }
  }

  @override
  Future<Either<Failure, OrderModel?>> rejectOrder() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseOrderRemoteDataSource.rejectOrder(
          currentLanguage: lang,
          token: token,
        );

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
  Future<Either<Failure, String>> cancelOrder() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseOrderRemoteDataSource.cancelOrder(
          currentLanguage: lang,
          token: token,
        );

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
  Future<Either<Failure, OrderModel?>> assignOrder({
    required int paymentMethod,
    required int quantity,
  }) async {
    debugPrint("dssssssfr333=======>>> ");
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        debugPrint("lang=======>>>$lang ");
        final user = await baseOrderRemoteDataSource.assignOrder(
          paymentMethod: paymentMethod,
          quantity: quantity,
          currentLanguage: lang,
          token: token,
        );

        debugPrint("dssssssfr333=======>>>$user ");
        return Right(user);
      } on AuthException catch (error) {
        debugPrint("dssssssfr333=======>>>$error ");
        return Left(AuthFailure(message: error.message));
      } on ValidationException catch (error) {
        error.printInfo();
        // debugPrint("dssssssfr333=======>>>${error.printInfo()} ");
        debugPrint("dssssssfr333=======>>>${error.message} ");
        return Left(ValidationFailure(message: error.message));
      } on UnAuthenticatedException catch (error) {
        debugPrint("dssssssfr333=======>>>$error ");
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
  Future<Either<Failure, OrdersPagenation>> getAllOrders(
      {required String currentPage}) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final allOrders = await baseOrderRemoteDataSource.getAllOrders(
          currentPage: currentPage,
          currentLanguage: lang,
          token: token,
        );

        return Right(allOrders);
      } on AuthException catch (error) {
        return Left(AuthFailure(message: error.message));
      } on UnVerifiedException {
        return Left(UnVerifiedFailure(message: LocaleKeys.unExpectedError.tr));
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
  Future<Either<Failure, String>> cancelConfirmOrder() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseOrderRemoteDataSource.cancelConfirmOrder(
          currentLanguage: lang,
          token: token,
        );

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
  Future<Either<Failure, String>> cancelOrderWithReason(
      {required String reason}) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseOrderRemoteDataSource.cancelOrderWithReason(
          reason: reason,
          currentLanguage: lang,
          token: token,
        );

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
