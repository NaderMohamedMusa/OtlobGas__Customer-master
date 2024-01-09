import 'dart:async';

import 'package:get/get.dart';

import '../../../../core/consts/api_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../models/location_model.dart';

abstract class BaseLocationRemoteDataSource {
  Future<List<LocationModel>> getAllLocations({
    required String currentLanguage,
    required String token,
  });

  Future<List<LocationModel>> addLocation({
    required String title,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
    required String currentLanguage,
    required String token,
  });

  Future<List<LocationModel>> editLocation({
    required String title,
    required String id,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
    required String currentLanguage,
    required String token,
  });

  Future<List<LocationModel>> deleteLocation({
    required String id,
    required String currentLanguage,
    required String token,
  });
}

class LocationRemoteDataSource extends GetConnect
    implements BaseLocationRemoteDataSource {
  @override
  Future<List<LocationModel>> getAllLocations({
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await get(
      ApiUrls.getAllLocation,
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        final List<LocationModel> locationModels = [];

        (response.body['data']).forEach((value) {
          locationModels.add(LocationModel.fromMap(value));
        });

        return locationModels;
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
        return getAllLocations(
          currentLanguage: currentLanguage,
          token: token,
        );
    }
  }

  @override
  Future<List<LocationModel>> addLocation(
      {required String currentLanguage,
      required String token,
      required String title,
      required double lat,
      required double long,
      String? floorNum,
      String? buildingNum}) async {
    Response response = await post(
      ApiUrls.addLocation,
      {
        "title": title,
        "lat": lat.toString(),
        "long": long.toString(),
        "floor_num": floorNum,
        "building_num": buildingNum
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        final List<LocationModel> locationModels = [];

        (response.body['data']).forEach((value) {
          locationModels.add(LocationModel.fromMap(value));
        });

        return locationModels;
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
  Future<List<LocationModel>> deleteLocation({
    required String currentLanguage,
    required String token,
    required String id,
  }) async {
    Response response = await post(
      ApiUrls.editLocations + id,
      {
        "_method": "DELETE",
      },
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        final List<LocationModel> locationModels = [];

        (response.body['data']).forEach((value) {
          locationModels.add(LocationModel.fromMap(value));
        });

        return locationModels;
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
  Future<List<LocationModel>> editLocation({
    required String currentLanguage,
    required String token,
    required String id,
    required String title,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
  }) async {
    Response response = await post(
      ApiUrls.editLocations + id,
      {
        "_method": "PUT",
        "title": title,
        "lat": lat.toString(),
        "long": long.toString(),
        "floor_num": floorNum,
        "building_num": buildingNum
      },
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        final List<LocationModel> locationModels = [];

        (response.body['data']).forEach((value) {
          locationModels.add(LocationModel.fromMap(value));
        });

        return locationModels;
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
