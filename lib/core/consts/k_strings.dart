class Kstrings {
  static const String googleMapApiKey =
      'AIzaSyAAOcn3r6DVavhuoPatQvNGg5kUuV1zAFo';
  static const String userStorage = "user";
  static const String userTokenStorage = "user_token";
  static const String langStorage = "language";

  static const String pusherAppId = "1514905";
  static const String pusherAppKey = "ba374605552e328d9676";
  static const String pusherCluster = "ap2";
  static String getChatChannel({required int orderId}) => 'chat-$orderId';
  static String getOrderChannel({required int driverId}) => 'order-$driverId';

  static const String countryCode = "+962";


  static String getUserChannel({required int driverId}) => 'user-app-$driverId';
}
