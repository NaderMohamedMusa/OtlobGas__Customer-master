import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:otlobgas_driver/features/chat_feature/data/data_source/chat_remote_data_source.dart';
import 'package:otlobgas_driver/features/chat_feature/data/models/chat_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routes/app_pages.dart';
import '../../domain/repositories/base_chat_repository.dart';

class ChatRespoitory implements BaseChatRepository {
  final BaseChatRemoteDataSource baseChatRemoteDataSource;
  BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkInfo networkInfo;

  ChatRespoitory({
    required this.baseChatRemoteDataSource,
    required this.baseAuthLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> initPusherChat({required int orderId}) async {
    try {
      await baseChatRemoteDataSource.initPusherChat(orderId: orderId);

      return const Right(unit);
    } catch (error) {
      return Left(UnExpectedFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> disconnectPusherChat() async {
    try {
      await baseChatRemoteDataSource.disconnectPusherChat();

      return const Right(unit);
    } catch (error) {
      return Left(UnExpectedFailure(message: error.toString()));
    }
  }

  @override
  Stream<ChatModel> listenToChat() {
    return baseChatRemoteDataSource.listenToChat();
  }

  @override
  Future<Either<Failure, ChatModel>> getChat() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseChatRemoteDataSource.getChat(
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
  Future<Either<Failure, ChatModel>> sendMessage(
      {required String message}) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();

        String lang = await baseAuthLocalDataSource.readUserLanguage();

        final user = await baseChatRemoteDataSource.sendMessage(
          message: message,
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
