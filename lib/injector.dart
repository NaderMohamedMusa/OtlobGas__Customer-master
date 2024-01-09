import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:otlobgas_driver/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/change_user_activity_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/charge_balance_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/edit_user_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/get_ads_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/get_last_week_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/get_orders_count_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/login_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/logout_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/register_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/remove_account_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/resend_otp_code_usecase.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/reset_password_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/send_token_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/update_user_location_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/verify_account_use_case.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/verify_otp_usecase.dart';
import 'package:otlobgas_driver/features/chat_feature/data/data_source/chat_remote_data_source.dart';
import 'package:otlobgas_driver/features/chat_feature/data/repositories/chat_repository.dart';
import 'package:otlobgas_driver/features/chat_feature/domain/repositories/base_chat_repository.dart';
import 'package:otlobgas_driver/features/location_feature/data/data_source/location_remote_data_source.dart';
import 'package:otlobgas_driver/features/location_feature/data/repositories/location_repository.dart';
import 'package:otlobgas_driver/features/location_feature/domain/repositories/base_location_repository.dart';
import 'package:otlobgas_driver/features/location_feature/domain/use_cases/delete_location_use_case.dart';
import 'package:otlobgas_driver/features/location_feature/domain/use_cases/edit_location_use_case.dart';
import 'package:otlobgas_driver/features/location_feature/domain/use_cases/get_all_locations_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/data/data_source/notification_remote_data_source.dart';
import 'package:otlobgas_driver/features/notifications_feature/data/repositories/notification_repository.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/repositories/base_notification_repository.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/delete_all_notifications_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/delete_notification_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/get_all_notifications_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/get_today_notifications_use_case.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/use_cases/read_notification_use_case.dart';
import 'package:otlobgas_driver/features/order_feature/data/data_source/order_remote_data_source.dart';
import 'package:otlobgas_driver/features/order_feature/data/repositories/order_repository.dart';
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/cancel_confirm_order_use_case.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/cancel_order_use_case.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/cancel_order_with_reason_use_case.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/check_available_order_use_case.dart';
import 'package:otlobgas_driver/features/order_feature/domain/use_cases/get_all_orders_use_case.dart';
import 'package:otlobgas_driver/features/others_feature/data/data_source/others_remote_data_source.dart';
import 'package:otlobgas_driver/features/others_feature/domain/repositories/base_others_repository.dart';
import 'package:otlobgas_driver/features/others_feature/domain/use_cases/get_nearest_drivers_use_case.dart';
import 'package:otlobgas_driver/features/others_feature/domain/use_cases/get_phone_number_use_case.dart';
import 'package:otlobgas_driver/features/others_feature/domain/use_cases/get_privacy_use_case.dart';
import 'package:otlobgas_driver/features/pusher_feature/data/data_source/pusher_remote_data_source.dart';
import 'package:otlobgas_driver/features/pusher_feature/data/repositories/pusher_repository.dart';
import 'package:otlobgas_driver/features/pusher_feature/domain/repositories/base_pusher_repository.dart';
import 'package:otlobgas_driver/features/pusher_feature/domain/use_cases/init_pusher_use_case.dart';
import 'package:otlobgas_driver/features/rating_feature/data/data_source/rating_remote_data_source.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/repositories/base_rating_repository.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/use_cases/add_rating_use_case.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/use_cases/get_rating_use_case.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'core/network/network_info.dart';
import 'core/services/internet_connection_service.dart';
import 'core/services/language_service.dart';
import 'core/services/location_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/user_service.dart';
import 'features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'features/auth_feature/data/repositories/auth_repository.dart';
import 'features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'features/auth_feature/domain/use_cases/get_lang_use_case.dart';
import 'features/auth_feature/domain/use_cases/save_lang_use_case.dart';
import 'features/chat_feature/domain/use_cases/get_chat_use_case.dart';
import 'features/chat_feature/domain/use_cases/send_message_use_case.dart';
import 'features/location_feature/domain/use_cases/add_location_use_case.dart';
import 'features/order_feature/domain/use_cases/assign_order_use_case.dart';
import 'features/order_feature/domain/use_cases/create_order_use_case.dart';
import 'features/order_feature/domain/use_cases/reject_order_use_case.dart';
import 'features/others_feature/data/repositories/others_repository.dart';
import 'features/others_feature/domain/use_cases/contact_us_use_case.dart';
import 'features/others_feature/domain/use_cases/get_about_app_use_case.dart';
import 'features/others_feature/domain/use_cases/get_terms_use_case.dart';
import 'features/pusher_feature/domain/use_cases/disconnect_pusher_order_use_case.dart';
import 'features/pusher_feature/domain/use_cases/listen_to_chat_use_case.dart';
import 'features/pusher_feature/domain/use_cases/listen_to_order_use_case.dart';
import 'features/pusher_feature/domain/use_cases/listen_to_user_use_case.dart';
import 'features/pusher_feature/domain/use_cases/subscribe_chat_use_case.dart';
import 'features/pusher_feature/domain/use_cases/subscribe_order_use_case.dart';
import 'features/rating_feature/data/repositories/rating_repository.dart';

Future<void> init() async {
  //! External
  await GetStorage.init('OtlobGas-Driver');
  final firebaseAuth = FirebaseAuth.instance;
  const flutterSecureStorage = FlutterSecureStorage();
  final internetConnectionChecker = InternetConnectionChecker();
  final pusher = PusherChannelsFlutter.getInstance();

  Get.lazyPut(
    () => GetStorage('OtlobGas-Driver'),
    fenix: true,
  );
  Get.lazyPut(
    () => firebaseAuth,
    fenix: true,
  );
  Get.lazyPut(
    () => flutterSecureStorage,
    fenix: true,
  );
  Get.lazyPut(
    () => internetConnectionChecker,
    fenix: true,
  );
  Get.lazyPut(
    () => pusher,
    fenix: true,
  );

  //! Core
  Get.lazyPut<NetworkInfo>(
    () => NetworkInfoImpl(
      internetConnectionChecker: Get.find(),
    ),
    fenix: true,
  );

  ///--------------------------- AUTH FEATURE ----------------------------------

  // Data sources
  Get.lazyPut<BaseAuthLocalDataSource>(
    () => AuthLocalDataSource(
      getStorage: Get.find(),
      flutterSecureStorage: Get.find(),
    ),
    fenix: true,
  );

  Get.lazyPut<BaseAuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      baseAuthLocalDataSource: Get.find(),
    ),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BaseAuthRepository>(
    () => AuthRespoitory(
      baseAuthLocalDataSource: Get.find(),
      baseAuthRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  // Use cases

  Get.lazyPut(
    () => GetUserUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => ChangeUserActivityUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => UpdateUserLocationUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetLangUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );
  Get.lazyPut(
    () => RemoveAccountUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => SaveLangUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => LoginUserUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => LogoutUserUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => SendTokenUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => ResetPasswordUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => RegisterUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => EditUserUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => VerifyAccountUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );
  Get.lazyPut(
    () => VerifyOtpUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );
  Get.lazyPut(
    () => ResendOtpCodeUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => ChargeBalanceUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetLastWeekUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetOrdersCountUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetAdsUseCase(baseAuthRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- Locations FEATURE --------------------------------

  // Data sources
  Get.lazyPut<BaseLocationRemoteDataSource>(
    () => LocationRemoteDataSource(),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BaseLocationRepository>(
    () => LocationRespoitory(
      baseAuthLocalDataSource: Get.find(),
      baseLocationRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  // Use cases
  Get.lazyPut(
    () => GetAllLocationUseCase(baseLocationRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => AddLocationUseCase(baseLocationRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => EditLocationUseCase(baseLocationRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => DeleteLocationUseCase(baseLocationRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- PUSHER FEATURE --------------------------------
  // Data sources
  Get.lazyPut<BasePusherRemoteDataSource>(
    () => PusherRemoteDataSource(pusher: Get.find()),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BasePusherRepository>(
    () => PusherRespoitory(
      basePusherRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  Get.lazyPut(
    () => InitPusherUseCase(basePusherRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => DisconnectPusherUseCase(basePusherRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => ListenToOrderUseCase(basePusherRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => ListenToUserUseCase(basePusherRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => ListenToChatUseCase(basePusherRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => SubscribeOrderUseCase(basePusherRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => SubscribeChatUseCase(basePusherRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- ORDER FEATURE ---------------------------------

  // Data sources
  Get.lazyPut<BaseOrderRemoteDataSource>(
    () => OrderRemoteDataSource(),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BaseOrderRepository>(
    () => OrderRespoitory(
      baseAuthLocalDataSource: Get.find(),
      baseOrderRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  // Use cases
  Get.lazyPut(
    () => GetAllOrdersUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => CheckAvailableOrderUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => CreateOrderUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => CancelOrderUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => CancelConfirmOrderUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => CancelOrderWithReasonUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => AssignOrderUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => RejectOrderUseCase(baseOrderRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- CHAT FEATURE ----------------------------------

  // Data sources
  Get.lazyPut<BaseChatRemoteDataSource>(
    () => ChatRemoteDataSource(pusher: Get.find()),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BaseChatRepository>(
    () => ChatRespoitory(
      baseAuthLocalDataSource: Get.find(),
      baseChatRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  // Use cases
  Get.lazyPut(
    () => GetChatUseCase(baseChatRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => SendMessageUseCase(baseChatRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- RATING FEATURE --------------------------------

  // Data sources
  Get.lazyPut<BaseRatingRemoteDataSource>(
    () => RatingRemoteDataSource(),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BaseRatingRepository>(
    () => RatingRespoitory(
      baseAuthLocalDataSource: Get.find(),
      baseRatingRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  // Use cases
  Get.lazyPut(
    () => AddRatingUseCase(baseRatingRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetRatingUseCase(baseRatingRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- OTHERS FEATURE --------------------------------

  // Data sources
  Get.lazyPut<BaseOthersRemoteDataSource>(
    () => OthersRemoteDataSource(),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BaseOthersRepository>(
    () => OthersRespoitory(
      baseAuthLocalDataSource: Get.find(),
      baseOthersRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  // Use cases
  Get.lazyPut(
    () => GetNearestDriversUseCase(baseOthersRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetTermsUseCase(baseOthersRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetAboutAppUseCase(baseOthersRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetPhoneNumberUseCase(baseOthersRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => ContactUsUseCase(baseOthersRepository: Get.find()),
    fenix: true,
  );
  Get.lazyPut(
    () => GetPrivacyUseCase(baseOthersRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- NOTIFICATIONS FEATURE -------------------------

  // Data sources
  Get.lazyPut<BaseNotificationRemoteDataSource>(
    () => NotificationRemoteDataSource(),
    fenix: true,
  );

  // Repository
  Get.lazyPut<BaseNotificationRepository>(
    () => NotificationRespoitory(
      baseAuthLocalDataSource: Get.find(),
      baseNotificationRemoteDataSource: Get.find(),
      networkInfo: Get.find(),
    ),
    fenix: true,
  );

  // Use cases
  Get.lazyPut(
    () => GetAllNotificationsUseCase(baseNotificationRepository: Get.find()),
    fenix: true,
  );
  Get.lazyPut(
    () => ReadAllNotificationsUseCase(baseNotificationRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => GetTodayNotificationsUseCase(baseNotificationRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => DeleteAllNotificationsUseCase(baseNotificationRepository: Get.find()),
    fenix: true,
  );

  Get.lazyPut(
    () => DeleteNotificationUseCase(baseNotificationRepository: Get.find()),
    fenix: true,
  );

  ///--------------------------- SERVICES --------------------------------------
  await Get.putAsync(() => NotificationService().init());

  await Get.putAsync(() => InternetConnectionService(
        networkInfo: Get.find(),
      ).init());

  await Get.putAsync(
    () => LanguageService(
      getLangUseCase: Get.find(),
      saveLangUseCase: Get.find(),
    ).init(),
  );
  await Get.putAsync(
    () => UserService(
      getUserUseCase: Get.find(),
    ).init(),
  );

  await Get.putAsync(() => LocationService(
        changeUserActivityUseCase: Get.find(),
        updateUserLocationUseCase: Get.find(),
        getNearestDriversUseCase: Get.find(),
      ).init());
}
