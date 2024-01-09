import 'package:get/get.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/edit_user/views/edit_user_view.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/forget_password/bindings/forget_password_binding.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/forget_password/views/forget_password_view.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/main_layout/views/main_layout_view.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/otp/bindings/otp_binding.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/otp/views/otp_view.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/register/views/register_view.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/splash/bindings/splash_binding.dart';
import 'package:otlobgas_driver/features/chat_feature/presentation/chat/bindings/chat_binding.dart';
import 'package:otlobgas_driver/features/chat_feature/presentation/chat/views/chat_view.dart';
import 'package:otlobgas_driver/features/rating_feature/presentation/rating/views/rating_view.dart';
import '../../features/auth_feature/presentation/edit_user/bindings/edit_user_binding.dart';
import '../../features/auth_feature/presentation/forget_password/bindings/change_password_binding.dart';
import '../../features/auth_feature/presentation/forget_password/views/change_password_view.dart';
import '../../features/auth_feature/presentation/login/bindings/login_binding.dart';
import '../../features/auth_feature/presentation/login/views/login_view.dart';
import '../../features/auth_feature/presentation/main_layout/bindings/main_layout_binding.dart';
import '../../features/auth_feature/presentation/register/bindings/register_binding.dart';
import '../../features/auth_feature/presentation/splash/views/splash_view.dart';
import '../../features/location_feature/presentation/add_location/bindings/add_location_binding.dart';
import '../../features/location_feature/presentation/add_location/views/add_location_view.dart';
import '../../features/location_feature/presentation/edit_location/bindings/edit_location_binding.dart';
import '../../features/location_feature/presentation/edit_location/views/edit_location_view.dart';
import '../../features/location_feature/presentation/locations/bindings/locations_binding.dart';
import '../../features/location_feature/presentation/locations/views/locations_view.dart';
import '../../features/notifications_feature/presentation/notifications/views/notifications_view.dart';
import '../../features/order_feature/presentation/create_order/bindings/create_order_binding.dart';
import '../../features/order_feature/presentation/create_order/views/create_order_view.dart';
import '../../features/order_feature/presentation/current_order/bindings/current_order_binding.dart';
import '../../features/order_feature/presentation/current_order/views/current_order_view.dart';
import '../../features/others_feature/presentation/about_app/bindings/about_app_binding.dart';
import '../../features/others_feature/presentation/about_app/views/about_app_view.dart';
import '../../features/notifications_feature/presentation/notifications/bindings/notifications_binding.dart';
import '../../features/others_feature/presentation/contact_us/bindings/contact_us_binding.dart';
import '../../features/others_feature/presentation/contact_us/views/contact_us_view.dart';
import '../../features/others_feature/presentation/privacy/bindings/privacy_binding.dart';
import '../../features/others_feature/presentation/privacy/views/privacy_view.dart';
import '../../features/others_feature/presentation/terms/bindings/terms_binding.dart';
import '../../features/others_feature/presentation/terms/views/terms_view.dart';
import '../../features/rating_feature/presentation/rating/bindings/rating_binding.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.editUser,
      page: () => const EditUserView(),
      binding: EditUserBinding(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.mainLayout,
      page: () => const MainLayoutView(),
      binding: MainLayoutBinding(),
    ),
    GetPage(
      name: _Paths.locations,
      page: () => const LocationsView(),
      binding: LocationsBinding(),
    ),
    GetPage(
      name: _Paths.addLocation,
      page: () => const AddLocationView(),
      binding: AddLocationBinding(),
    ),
    GetPage(
      name: _Paths.editLocation,
      page: () => const EditLocationView(),
      binding: EditLocationBinding(),
    ),
    GetPage(
      name: _Paths.createOrder,
      page: () => const CreateOrderView(),
      binding: CreateOrderBinding(),
    ),
    GetPage(
      name: _Paths.currentOrder,
      page: () => const CurrentOrderView(),
      binding: CurrentOrderBinding(),
    ),
    GetPage(
      name: _Paths.forgetPassword,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.changePassword,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.chat,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.rating,
      page: () => const RatingView(),
      binding: RatingBinding(),
    ),
    GetPage(
      name: _Paths.terms,
      page: () => const TermsView(),
      binding: TermsBinding(),
    ),
    GetPage(
      name: _Paths.privacy,
      page: () => const PrivacyView(),
      binding: PrivacyBinding(),
    ),
    GetPage(
      name: _Paths.contactUs,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.aboutApp,
      page: () => const AboutAppView(),
      binding: AboutAppBinding(),
    ),
  ];
}
