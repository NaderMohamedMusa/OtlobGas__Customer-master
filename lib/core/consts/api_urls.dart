import 'package:otlobgas_driver/core/consts/k_strings.dart';

class ApiUrls {
  static const String baseUrl = 'https://gas.jabal-p.com/api/customer';
  // static const String baseUrl = 'https://otlopxx.codeella.com/api/customer';

  static String get verifyOtpCode => '$baseUrl/verify-code';
  static String get resendOtpCode => '$baseUrl/resend-code';
  static String get chats => '$baseUrl/chat';
  static String get contactus => '$baseUrl/contactus';
  static String get sendMessage => '$baseUrl/chat/send';
  static String get signInUser => '$baseUrl/login';
  static String get logoutUser => '$baseUrl/logout';
  static String get deleteAccount => '$baseUrl/delete-account';


  static String get signUpUser => '$baseUrl/register';
  static String get userData => '$baseUrl/user-data';
  static String get editProfile => '$baseUrl/profile/update';
  static String get sendToken => '$baseUrl/reset/send-token';
  static String get resetPassword => '$baseUrl/reset/set-new-password';
  static String get changePassword => '$baseUrl/auth/changePassword';
  static String get getAllLocation => '$baseUrl/locations';
  static String get addLocation => '$baseUrl/locations';
  static String get editLocations => '$baseUrl/locations/';
  static String get getAds => '$baseUrl/ads';
  static String get verifyAccount => '$baseUrl/verify';
  static String get driverPaper => '$baseUrl/papers';
  static String get driverPaperUpload => '$baseUrl/papers/update';
  static String get logOutUser => '$baseUrl/logout';
  static String get updateAccount => '$baseUrl/update_user';
  static String get changeUserActivity => '$baseUrl/switch-status';
  static String get updateUserLocation => '$baseUrl/locations/update';
  static String get driverCurrentLocation => '$baseUrl/DriverCurrentLocation';
  static String get driverCheckOrder => '$baseUrl/DriverCheckOrder';
  static String get notification => '$baseUrl/notification';

  static String get rating => '$baseUrl/ratings';
  static String get addRating => '$baseUrl/ratings/create';
  static String get last7days => '$baseUrl/last7day';
  static String get todayNotifications => '$baseUrl/notifications/today';
  static String get allNotifications => '$baseUrl/notifications';
  static String get deleteAllNotifications =>
      '$baseUrl/notifications/delete-all';
  static String get deleteNotification => '$baseUrl/notifications/delete';
  static String get readNotification => '$baseUrl/notifications/read';

  static String orderDelivered({required int orderId}) =>
      '$baseUrl/OrderDelivered/$orderId';
  static String deliveredCheck({required int orderId}) =>
      '$baseUrl/DeliveredCheck/$orderId';
  static String deliveredUnCheck({required int orderId}) =>
      '$baseUrl/DeliveredUnCheck/$orderId';
  static String get allOrders => '$baseUrl/orders';
  static String get checkOrder => '$baseUrl/orders/check-order';
  static String get createOrder => '$baseUrl/orders/create';
  static String get cancelOrder => '$baseUrl/orders/cancel';
  static String get cancelBecauseOfOrder => '$baseUrl/orders/cancel-because-of';
  static String get cancelConfirmOrder => '$baseUrl/orders/cancel-confirm';
  static String get assignOrder => '$baseUrl/orders/assign';
  static String get rejectOrder => '$baseUrl/orders/get-new-driver';
  static String get charge => '$baseUrl/charge';
  static String get lastWeek => '$baseUrl/transactions/last-week';
  static String get ordersCount => '$baseUrl/orders/counts';

  static String get order => '$baseUrl/Order?page=';
  static String get orderStatus => '$baseUrl/orderStatus';
  static String get privacy => '$baseUrl/app/privacy';
  static String get terms => '$baseUrl/app/terms';
  static String get nearestDrivers => '$baseUrl/nearest-drivers';
  static String get about => '$baseUrl/app/about';
  static String get phoneNumber => '$baseUrl/settings/phone';
  static String editLocation(int locationId) => '$baseUrl/location/$locationId';

  static String chat({String? orderId}) =>
      '$baseUrl/chat${orderId == null ? '' : '/$orderId'}';

  static String mapSearch({input, language}) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${Kstrings.googleMapApiKey}&language=$language';

  static Map<String, String> getHeaders({String? token}) => {
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'x-version': '1',
      };
}
