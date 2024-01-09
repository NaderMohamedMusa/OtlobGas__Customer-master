import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/hold_message_with.dart';
import '../entities/ads.dart';
import '../entities/last_week.dart';
import '../entities/orders_count.dart';
import '../entities/user.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, Unit>> saveLang({required String lang});

  Future<Either<Failure, String>> getLang();

  Future<Either<Failure, OrdersCount>> getOrdersCount();

  Future<Either<Failure, List<LastWeek>>> getLastWeek();

  Future<Either<Failure, List<Ads>>> getAds();

  Future<Either<Failure, User>> verifyAccount();

  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String mobile,
    XFile? image,
    required String password,
    required String confirmPassword,
  });

  Future<Either<Failure, User>> editUser({
    required String name,
    required String email,
    XFile? image,
    required String password,
    required String confirmPassword,
  });

  Future<Either<Failure, User>> logIn({
    required String mobile,
    required String password,
  });
  Future<Either<Failure, User>> verifyOtpCode({
    required String code,
    required String phone,
  });

  Future<Either<Failure, Unit>> resendOtpCode({
    required String phone,
  });

  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, Unit>> removeAccount();

  Future<Either<Failure, String>> sendToken({
    required String email,
  });

  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String token,
    required String pass,
    required String conPass,
  });

  Future<Either<Failure, HoldMessageWith<User>>> changeUserActivity({
    required String lat,
    required String long,
  });

  Future<Either<Failure, Unit>> updateUserLocation({
    required String lat,
    required String long,
  });

  Future<Either<Failure, HoldMessageWith<User>>> chargeBalance({
    required String cardNumber,
  });
}
