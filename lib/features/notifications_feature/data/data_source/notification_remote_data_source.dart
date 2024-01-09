import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/utils/hold_message_with.dart';
import 'package:otlobgas_driver/features/auth_feature/data/models/user_model.dart';

import '../../../../core/consts/api_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../models/notification_model.dart';

abstract class BaseNotificationRemoteDataSource {
  Future<NotificationModel> getAllNotifications({
    required String currentPage,
    required String currentLanguage,
    required String token,
  });

  Future<NotificationModel> deleteNotification({
    required int notificationId,
    required bool isTodayNotification,
    required String currentLanguage,
    required String token,
  });

  Future<NotificationModel> getTodayNotifications({
    required String currentPage,
    required String currentLanguage,
    required String token,
  });

  Future<Unit> deleteAllNotifications({
    required String currentLanguage,
    required String token,
  });
  Future<HoldMessageWith<UserModel>> readNotification({
    required String currentLanguage,
    required String token,
  });
}

class NotificationRemoteDataSource extends GetConnect
    implements BaseNotificationRemoteDataSource {
  @override
  Future<Unit> deleteAllNotifications(
      {required String currentLanguage, required String token}) async {
    Response response = await post(
      ApiUrls.deleteAllNotifications,
      {
        'lang': currentLanguage,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return Future.value(unit);
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
  Future<NotificationModel> getAllNotifications({
    required String currentPage,
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await get(
      "${ApiUrls.allNotifications}?lang=$currentLanguage&&page=$currentPage",
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return NotificationModel.fromMap(response.body['data']);
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
        return getAllNotifications(
          currentLanguage: currentLanguage,
          currentPage: currentPage,
          token: token,
        );
    }
  }

  @override
  Future<NotificationModel> getTodayNotifications({
    required String currentPage,
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await get(
      "${ApiUrls.todayNotifications}?lang=$currentLanguage&&page=$currentPage",
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return NotificationModel.fromMap(response.body['data']);
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
        return getTodayNotifications(
          currentLanguage: currentLanguage,
          currentPage: currentPage,
          token: token,
        );
    }
  }

  @override
  Future<NotificationModel> deleteNotification({
    required int notificationId,
    required bool isTodayNotification,
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await post(
      ApiUrls.deleteNotification,
      {
        "notify_id": notificationId,
        "is_today": isTodayNotification,
        "lang": currentLanguage,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return NotificationModel.fromMap(response.body['data']);
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
  Future<HoldMessageWith<UserModel>> readNotification({
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await post(
      ApiUrls.readNotification,
      {
        "lang": currentLanguage,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        final message = response.body['message'];
        return HoldMessageWith<UserModel>(
          message: message,
          data: UserModel.fromMap(response.body['data']),
        );
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
