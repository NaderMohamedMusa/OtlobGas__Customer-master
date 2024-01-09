import 'dart:io';

import 'package:get/get.dart';
import 'package:otlobgas_driver/core/services/language_service.dart';

import '../../../../core/consts/api_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../models/nearest_driver_model.dart';

abstract class BaseOthersRemoteDataSource {
  Future<List<NearestDriverModel>> getNearestDrivers({
    required String lat,
    required String long,
    required String token,
  });

  Future<String> getTerms();

  Future<String> getAboutApp();

  Future<String> getPrivacy();

  Future<String> getPhoneNumber({required String token});

  Future<String> contactUs({
    required String title,
    required String message,
    required String file,
    required String currentLanguage,
    required String token,
  });
}

class OthersRemoteDataSource extends GetConnect
    implements BaseOthersRemoteDataSource {
  @override
  Future<List<NearestDriverModel>> getNearestDrivers({
    required String lat,
    required String long,
    required String token,
  }) async {
    Response response = await post(
      ApiUrls.nearestDrivers,
      {
        'lat': lat,
        'long': long,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    print('getNearestDrivers==>${response.body}');
    switch (response.statusCode) {
      case 200:
        return List.from(response.body['data'])
            .map((e) => NearestDriverModel.fromMap(e))
            .toList();
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        return getNearestDrivers(
          lat: lat,
          long: long,
          token: token,
        );
    }
  }

  @override
  Future<String> getTerms() async {
    Response response = await get(
      "${ApiUrls.terms}?lang=${LanguageService.to.savedLang.value}",
      headers: ApiUrls.getHeaders(),
    );
    switch (response.statusCode) {
      case 200:
        return response.body['data'];
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<String> getPrivacy() async {
    Response response = await get(
      "${ApiUrls.privacy}?lang=${LanguageService.to.savedLang.value}",
      headers: ApiUrls.getHeaders(),
    );
    switch (response.statusCode) {
      case 200:
        return response.body['data'];
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<String> getAboutApp() async {
    Response response = await get(
      "${ApiUrls.about}?lang=${LanguageService.to.savedLang.value}",
      headers: ApiUrls.getHeaders(),
    );
    switch (response.statusCode) {
      case 200:
        return response.body['data'];
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<String> contactUs({
    required String title,
    required String message,
    required String file,
    required String currentLanguage,
    required String token,
  }) async {
    final form = FormData({
      'title': title,
      if (file.isNotEmpty)
        'file': MultipartFile(
          File(file).readAsBytesSync(),
          filename: file,
        ),
      'message': message,
      'lang': currentLanguage,
      'type': "customer",
    });
    Response response = await post(
      ApiUrls.contactus,
      form,
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        return response.body['message'];
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<String> getPhoneNumber({required String token}) async {
    Response response = await get(
      ApiUrls.phoneNumber,
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return response.body['data']['phone'];
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        if (response.body is String) {
          throw UnExpectedException();
        } else {
          throw UnVerifiedException(message: response.body['message']);
        }
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }
}
