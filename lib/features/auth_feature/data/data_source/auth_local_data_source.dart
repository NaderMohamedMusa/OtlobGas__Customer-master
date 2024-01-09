import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/consts/k_strings.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../models/user_model.dart';

abstract class BaseAuthLocalDataSource {
  Future<UserModel> readUser();

  Future<Unit> writeUser({required UserModel user});
  Future<Unit> removeUser();

  Future<String> readUserLanguage();
  Future<Unit> writeUserLanguage({required String lang});

  Future<String> readToken();
  Future<Unit> writeToken({required String token});
  Future<Unit> removeToken();
}

class AuthLocalDataSource implements BaseAuthLocalDataSource {
  final GetStorage getStorage;
  final FlutterSecureStorage flutterSecureStorage;

  AuthLocalDataSource({
    required this.getStorage,
    required this.flutterSecureStorage,
  });

  ///-------------- USER DATA ------------------------------------------------
  @override
  Future<UserModel> readUser() async {
    try {
      final data = await getStorage.read(Kstrings.userStorage);

      return Future.value(UserModel.fromMap(data));
    } catch (e) {
      throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
    }
  }

  @override
  Future<Unit> writeUser({required UserModel user}) async {
    try {
      await getStorage.write(Kstrings.userStorage, user.toMap());
      return Future.value(unit);
    } catch (e) {
      throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
    }
  }

  @override
  Future<Unit> removeUser() async {
    try {
      await getStorage.remove(Kstrings.userStorage);

      return Future.value(unit);
    } catch (e) {
      throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
    }
  }

  ///-------------- USER LANGUAGE ----------------------------------------------
  @override
  Future<String> readUserLanguage() async {
    final data = await getStorage.read(Kstrings.langStorage);

    if (data != null) {
      return Future.value(data);
    } else {
      return Future.value('ar');
    }
  }

  @override
  Future<Unit> writeUserLanguage({required String lang}) async {
    try {
      await getStorage.write(Kstrings.langStorage, lang);
      return Future.value(unit);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  ///-------------- USER TOKEN -------------------------------------------------
  @override
  Future<String> readToken() async {
    try {
      final token =
          await flutterSecureStorage.read(key: Kstrings.userTokenStorage);

      return Future.value(token);
    } catch (e) {
      throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
    }
  }

  @override
  Future<Unit> writeToken({required String token}) async {
    try {
      await flutterSecureStorage.write(
          key: Kstrings.userTokenStorage, value: token);

      return Future.value(unit);
    } catch (e) {
      throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
    }
  }

  @override
  Future<Unit> removeToken() async {
    try {
      await flutterSecureStorage.delete(key: Kstrings.userTokenStorage);

      return Future.value(unit);
    } catch (e) {
      throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
    }
  }
}
