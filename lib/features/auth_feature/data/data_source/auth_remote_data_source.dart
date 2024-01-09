import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otlobgas_driver/features/auth_feature/data/models/last_week_model.dart';

import '../../../../core/consts/api_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';
import '../../../../core/utils/hold_message_with.dart';
import '../models/ads_model.dart';
import '../models/orders_count_model.dart';
import '../models/user_model.dart';
import 'auth_local_data_source.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> register({
    required String name,
    required String email,
    required String mobile,
    XFile? image,
    required String password,
    required String confirmPassword,
    required String currentLanguage,
  });

  Future<UserModel> editAccount({
    required String name,
    required String email,
    XFile? image,
    required String password,
    required String confirmPassword,
    required String currentLanguage,
    required String token,
  });

  Future<UserModel> login({
    required String mobile,
    required String password,
    required String currentLanguage,
  });

  Future<Unit> logOut({
    required String token,
    required String currentLanguage,
  });
  Future<Unit> removeAccount({
    required String token,
    required String currentLanguage,
  });
  Future<String> sendToken({required String email});

  Future<String> resetPassword({
    required String email,
    required String token,
    required String pass,
    required String conPass,
  });

  Future<UserModel> verifyAccount({
    required String token,
    required String currentLanguage,
  });

  Future<HoldMessageWith<UserModel>> changeUserActivity({
    required String lat,
    required String long,
    required String token,
    required String currentLanguage,
  });

  Future<Unit> updateUserLocation({
    required String lat,
    required String long,
    required String token,
    required String currentLanguage,
  });

  Future<HoldMessageWith<UserModel>> chargeBalance({
    required String cardNumber,
    required String token,
    required String currentLanguage,
  });

  Future<List<LastWeekModel>> getLastWeek({
    required String token,
    required String currentLanguage,
  });

  Future<OrdersCountModel> getOrdersCount({
    required String token,
    required String currentLanguage,
  });

  Future<List<AdsModel>> getAds({
    required String currentLanguage,
    required String token,
  });

  Future<UserModel> getUserData({
    required String token,
    required String currentLanguage,
  });
  Future<UserModel> verifyOtpCode({
    required String code,
    required String phone,
  });

  Future<Unit> resendOtpCode({
    required String phone,
  });
}

class AuthRemoteDataSource extends GetConnect
    implements BaseAuthRemoteDataSource {
  final BaseAuthLocalDataSource baseAuthLocalDataSource;

  AuthRemoteDataSource({
    required this.baseAuthLocalDataSource,
  });

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String mobile,
    XFile? image,
    required String password,
    required String confirmPassword,
    required String currentLanguage,
  }) async {
    var token = await FirebaseMessaging.instance.getToken();

    var _request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiUrls.signUpUser),
    );
    _request.fields.addAll({
      'name': name,
      'email': email,
      'mobile': mobile,
      'type': '2',
      'password': password,
      'password_confirmation': confirmPassword,
      'lang': currentLanguage,
      'fcm_token': token!,
    });
    _request.headers.addAll(ApiUrls.getHeaders());
    if (image != null) {
      _request.files.add(http.MultipartFile.fromBytes(
          'image',
          await image.readAsBytes().then((value) {
            return value.cast();
          }),
          filename: image.path.toString() + image.name));
    }
    var valueReturn;
    await _request.send().then((value) async {
      valueReturn = value;
    });
    var respo = await http.Response.fromStream(valueReturn);
    final reee = json.decode(respo.body);
    print(respo.body);
    switch (valueReturn.statusCode) {
      case 200:
      case 201:
        return UserModel.fromMap(reee['data']);

      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);

      case 400:
      case 422:
        throw ValidationException(message: reee['message']);
      default:
        throw ServerException();
    }
    // final form = FormData({
    //   'name': name,
    //   'email': email,
    //   'mobile': mobile,
    //   'image': image != null
    //       ? MultipartFile(
    //           File(image).readAsBytesSync(),
    //           filename: 'image.png',
    //         )
    //       : null,
    //   'type': 2,
    //   'password': password,
    //   'password_confirmation': confirmPassword,
    //   'lang': currentLanguage,
    //   'fcm_token': token!,
    // });
    // Response response = await post(
    //   ApiUrls.signUpUser,
    //   form,
    //   headers: ApiUrls.getHeaders(),
    // );
    // print({
    //   'name': name,
    //   'email': email,
    //   'mobile': mobile,
    //   'image': image != null
    //       ? MultipartFile(
    //     File(image).readAsBytesSync(),
    //     filename: 'image.png',
    //   )
    //       : null,
    //   'type': 2,
    //   'password': password,
    //   'password_confirmation': confirmPassword,
    //   'lang': currentLanguage,
    //   'fcm_token': token!,
    // });
  }

  @override
  Future<UserModel> login({
    required String mobile,
    required String password,
    required String currentLanguage,
  }) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcm_token ===============>$fcmToken");
    Response response = await post(
      ApiUrls.signInUser,
      {
        'mobile': mobile,
        'password': password,
        'lang': currentLanguage,
        'fcm_token': fcmToken,
      },
      headers: ApiUrls.getHeaders(),
    );
    print("login response===============>${response.body}");
    switch (response.statusCode) {
      case 200:
        return UserModel.fromMap(response.body['data']);
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 403:
        await baseAuthLocalDataSource.writeUser(
            user: UserModel.fromMap(response.body['data']));
        await baseAuthLocalDataSource.writeToken(
            token: UserModel.fromMap(response.body['data']).token!);
        throw UnVerifiedException(message: response.body['message']);

      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<String> sendToken({required String email}) async {
    Response response = await post(
      ApiUrls.sendToken,
      {
        'email': email,
      },
      headers: ApiUrls.getHeaders(),
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
  Future<UserModel> verifyAccount({
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await post(
      ApiUrls.verifyAccount,
      {
        'lang': currentLanguage,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return UserModel.fromMap(response.body['data']);
      case 203:
        throw ExpiredPlanException(
            message: response.body['message'], result: null);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);

      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<UserModel> editAccount({
    required String name,
    required String email,
    XFile? image,
    required String password,
    required String confirmPassword,
    required String currentLanguage,
    required String token,
  }) async {
    var _request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiUrls.editProfile),
    );
    _request.fields.addAll({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'lang': currentLanguage,
    });

    _request.headers.addAll(ApiUrls.getHeaders(token: token));
    if (image != null) {
      _request.files.add(http.MultipartFile.fromBytes(
          'image',
          await image.readAsBytes().then((value) {
            return value.cast();
          }),
          filename: image.path.toString() + image.name));
    }
    var valueReturn;
    await _request.send().then((value) async {
      valueReturn = value;
    });
    var respo = await http.Response.fromStream(valueReturn);
    final reee = json.decode(respo.body);
    print(respo.body);
    switch (valueReturn.statusCode) {
      case 200:
      case 201:
        return UserModel.fromMap(reee['data']);

      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);

      case 400:
      case 422:
        throw ValidationException(message: reee['message']);
      default:
        throw ServerException();
    }
    // final form = FormData({
    //   'name': name,
    //   'email': email,
    //   'mobile': mobile,
    //   'image': image != null
    //       ? MultipartFile(
    //           File(image).readAsBytesSync(),
    //           filename: 'image.png',
    //         )
    //       : null,
    //   'type': 2,
    //   'password': password,
    //   'password_confirmation': confirmPassword,
    //   'lang': currentLanguage,
    //   'fcm_token': token!,
    // });
    // Response response = await post(
    //   ApiUrls.signUpUser,
    //   form,
    //   headers: ApiUrls.getHeaders(),
    // );
    // print({
    //   'name': name,
    //   'email': email,
    //   'mobile': mobile,
    //   'image': image != null
    //       ? MultipartFile(
    //     File(image).readAsBytesSync(),
    //     filename: 'image.png',
    //   )
    //       : null,
    //   'type': 2,
    //   'password': password,
    //   'password_confirmation': confirmPassword,
    //   'lang': currentLanguage,
    //   'fcm_token': token!,
    // });
  }

  @override
  Future<HoldMessageWith<UserModel>> changeUserActivity({
    required String lat,
    required String long,
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await post(
      ApiUrls.changeUserActivity,
      {
        'lat': lat,
        'long': long,
        'lang': currentLanguage,
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

  @override
  Future<HoldMessageWith<UserModel>> chargeBalance({
    required String cardNumber,
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await post(
      ApiUrls.charge,
      {
        'card_number': cardNumber,
        'lang': currentLanguage,
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

  @override
  Future<List<LastWeekModel>> getLastWeek(
      {required String token, required String currentLanguage}) async {
    Response response = await get(
      '${ApiUrls.lastWeek}?lang=$currentLanguage',
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        final List<LastWeekModel> lastSevenDays = [];
        if (response.body['data'] is Map) {
          (response.body['data'] as Map).forEach((key, value) {
            lastSevenDays.add(LastWeekModel.fromMap(
              key,
              value,
            ));
          });
        }

        return lastSevenDays;
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
        return getLastWeek(
          currentLanguage: currentLanguage,
          token: token,
        );
    }
  }

  @override
  Future<OrdersCountModel> getOrdersCount({
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await get(
      '${ApiUrls.ordersCount}?lang=$currentLanguage',
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        return OrdersCountModel.fromMap(response.body['data']);
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
        return getOrdersCount(
          currentLanguage: currentLanguage,
          token: token,
        );
    }
  }

  @override
  Future<Unit> logOut({
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await post(
      ApiUrls.logoutUser,
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
  Future<Unit> removeAccount({
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await post(
      ApiUrls.deleteAccount,
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
  Future<String> resetPassword({
    required String email,
    required String token,
    required String pass,
    required String conPass,
  }) async {
    Response response = await post(
      ApiUrls.resetPassword,
      {
        'email': email,
        'token': token,
        'password': pass,
        'password_confirmation': conPass,
      },
      headers: ApiUrls.getHeaders(),
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
  Future<List<AdsModel>> getAds({
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await get(
      ApiUrls.getAds,
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        final List<AdsModel> adsModels = [];

        (response.body['data']).forEach((value) {
          adsModels.add(AdsModel.fromMap(value));
        });

        return adsModels;
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
        return getAds(
          currentLanguage: currentLanguage,
          token: token,
        );
    }
  }

  @override
  Future<UserModel> getUserData({
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await get(
      '${ApiUrls.userData}?lang=$currentLanguage',
      headers: ApiUrls.getHeaders(token: token),
    );

    switch (response.statusCode) {
      case 200:
        return UserModel.fromMap(response.body['data']);
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
  Future<Unit> updateUserLocation({
    required String lat,
    required String long,
    required String token,
    required String currentLanguage,
  }) async {
    Response response = await post(
      ApiUrls.updateUserLocation,
      {
        'lat': lat,
        'long': long,
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
  Future<UserModel> verifyOtpCode(
      {required String code, required String phone}) async {
    Response response = await post(
      ApiUrls.verifyOtpCode,
      {
        'code': code,
        'mobile': phone,
      },
      headers: ApiUrls.getHeaders(),
    );

    switch (response.statusCode) {
      case 200:
        //TODO: return user model
        if (response.body['data'] is Map<String, dynamic>) {
          return UserModel.fromMap(response.body['data']);
        }
        return UserModel.fromMap({});
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }

  @override
  Future<Unit> resendOtpCode({required String phone}) async {
    Response response = await post(
      ApiUrls.resendOtpCode,
      {
        'mobile': phone,
      },
      headers: ApiUrls.getHeaders(),
    );

    switch (response.statusCode) {
      case 200:
        return Future.value(unit);
      case 401:
        throw UnAuthenticatedException(message: LocaleKeys.unAuthMessage.tr);
      case 400:
      case 422:
        throw ValidationException(message: response.body['message']);
      default:
        throw ServerException();
    }
  }
}
