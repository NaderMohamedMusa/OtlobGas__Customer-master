import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/order_feature/data/models/order_model.dart';
import 'package:otlobgas_driver/features/order_feature/data/models/orders_pagenation_model.dart';

import '../../../../core/consts/api_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/languages/app_translations.dart';

abstract class BaseOrderRemoteDataSource {
  Future<OrderModel> checkAvailableOrder({
    required String currentLanguage,
    required String token,
  });

  Future<OrderModel> createOrder({
    required String locationId,
    required String notes,
    required String currentLanguage,
    required String token,
  });

  Future<OrderModel?> rejectOrder({
    required String currentLanguage,
    required String token,
  });

  Future<String> cancelOrder({
    required String currentLanguage,
    required String token,
  });

  Future<String> cancelConfirmOrder({
    required String currentLanguage,
    required String token,
  });

  Future<String> cancelOrderWithReason({
    required String reason,
    required String currentLanguage,
    required String token,
  });

  Future<OrderModel?> assignOrder({
    required int paymentMethod,
    required int quantity,
    required String currentLanguage,
    required String token,
  });

  Future<OrdersPagenationModel> getAllOrders({
    required String currentPage,
    required String currentLanguage,
    required String token,
  });
}

class OrderRemoteDataSource extends GetConnect
    implements BaseOrderRemoteDataSource {
  @override
  Future<OrderModel> checkAvailableOrder({
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await get(
      '${ApiUrls.checkOrder}?lang=$currentLanguage',
      headers: ApiUrls.getHeaders(token: token),
    );
    print('checkAvailableOrder==>${response.body}');
    switch (response.statusCode) {
      case 200:
        return OrderModel.fromMap(response.body['data']);
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
  Future<OrderModel> createOrder({
    required String locationId,
    required String notes,
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await post(
      ApiUrls.createOrder,
      {
        'location_id': locationId,
        'notes': notes,
        'lang': currentLanguage,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    print('createOrder==>${response.body}');
    switch (response.statusCode) {
      case 200:
        return OrderModel.fromMap(response.body['data']);
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
  Future<OrderModel?> rejectOrder({
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await post(
      ApiUrls.rejectOrder,
      {
        'lang': currentLanguage,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    switch (response.statusCode) {
      case 200:
        return response.body['data'] != null
            ? OrderModel.fromMap(response.body['data'])
            : null;
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
  Future<String> cancelOrder({
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await post(
      ApiUrls.cancelOrder,
      {
        'lang': currentLanguage,
      },
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
  Future<String> cancelConfirmOrder({
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await post(
      ApiUrls.cancelConfirmOrder,
      {
        'lang': currentLanguage,
      },
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
  Future<String> cancelOrderWithReason({
    required String currentLanguage,
    required String token,
    required String reason,
  }) async {
    Response response = await post(
      ApiUrls.cancelBecauseOfOrder,
      {
        'lang': currentLanguage,
        'reason': reason,
      },
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
  Future<OrderModel?> assignOrder({
    required int paymentMethod,
    required int quantity,
    required String currentLanguage,
    required String token,
  }) async {
    debugPrint("paymentMethod=======>>>$paymentMethod ");
    debugPrint("quantity=======>>>$quantity ");
    debugPrint("currentLanguage=======>>>$currentLanguage ");
    debugPrint("token=======>>>$token ");
    Response response = await post(
      ApiUrls.assignOrder,
      {
        'payment_method': paymentMethod,
        'quantity': quantity,
        'lang': currentLanguage,
      },
      headers: ApiUrls.getHeaders(token: token),
    );
    debugPrint("response=======>>>${response.status} ");
    debugPrint("response=======>>>${response.body} ");
    switch (response.statusCode) {
      case 200:
        return response.body['data'] != null
            ? OrderModel.fromMap(response.body['data'])
            : null;
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
  Future<OrdersPagenationModel> getAllOrders({
    required String currentPage,
    required String currentLanguage,
    required String token,
  }) async {
    Response response = await get(
      '${ApiUrls.allOrders}?lang=$currentLanguage&&page=$currentPage',
      headers: ApiUrls.getHeaders(token: token),
    );
    print('getAllOrders==>${response.body}');
    switch (response.statusCode) {
      case 200:
        return OrdersPagenationModel.fromMap(response.body);
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
        return getAllOrders(
          currentLanguage: currentLanguage,
          currentPage: currentPage,
          token: token,
        );
    }
  }
}
