import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/rating_feature/data/models/rating_model.dart';
import '../../../../core/consts/api_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';

abstract class BaseRatingRemoteDataSource {
  Future<Unit> addRating({
    required String comment,
    required int rating,
    required String currentLanguage,
    required String token,
  });

  Future<RatingModel> getRating({
    required String currentPage,
    required String currentLanguage,
    required String token,
  });
}

class RatingRemoteDataSource extends GetConnect
    implements BaseRatingRemoteDataSource {
  @override
  Future<Unit> addRating({
    required String comment,
    required int rating,
    required String currentLanguage,
    required String token,
  }) async {
    print("addRating ========>>>>> start");
    print("comment ========>>>>> $comment");
    print("rating ========>>>>> $rating");
    print("currentLanguage ========>>>>> $currentLanguage");
    print("token ========>>>>> $token");
    Response response = await post(
      ApiUrls.addRating,
      {
        'rating': rating,
        'lang': currentLanguage,
        'comment': comment,
        'type': "customer",
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    print("addRating ========>>>>> ${response.body}");
    print("addRating ========>>>>> end");
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
  Future<RatingModel> getRating({
    required String currentPage,
    required String currentLanguage,
    required String token,
  }) async {
    debugPrint("rating ========>>>>> start");
    debugPrint("currentPage ========>>>>> $currentPage");
    debugPrint("currentLanguage ========>>>>> $currentLanguage");
    debugPrint("token ========>>>>> $token");
    Response response = await get(
      '${ApiUrls.rating}?lang=$currentLanguage&&page=$currentPage',
      headers: ApiUrls.getHeaders(token: token),
    );
    debugPrint("rating ========>>>>> ${response.body}");
    debugPrint("rating ========>>>>> end");
    switch (response.statusCode) {
      case 200:
        return RatingModel.fromMap(response.body);
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
