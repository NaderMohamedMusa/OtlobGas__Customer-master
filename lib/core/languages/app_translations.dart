import 'ar_translations.dart';
import 'en_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'ar': ar,
    'en': en,
  };
}

abstract class LocaleKeys {
  /// Exceptions Messages ======================================================
  static const networkFailure = "networkFailure";
  static const unVerifiedFailure = "unVerifiedFailure";
  static const serverFailure = 'serverFailure';
  static const unAuthMessage = 'unAuthMessage';
  static const emptyCacheMessage = 'emptyCacheMessage';
  static const unExpectedError = 'unExpectedError';

  /// Login Page ===============================================================
  static const login = 'login';
  static const createNewAccount = 'createNewAccount';
  static const forgetYourData = 'forgetYourData';
  static const arabicLang = 'arabicLang';
  static const englishLang = 'englishLang';

  /// Forget Password Page =====================================================
  static const accountRecovery = 'accountRecovery';
  static const accountRecoveryNote = 'accountRecoveryNote';

  /// Register Page ============================================================
  static const createAccount = 'createAccount';
  static const selectProfilePicture = 'selectProfilePicture';
  static const fullName = 'fullName';
  static const name = 'name';
  static const phoneNumber = 'phoneNumber';
  static const hintPhone = 'hintPhone';
  static const mail = 'mail';
  static const hintEmail = 'hintEmail';
  static const enterEmailOrPhone = 'enterEmailOrPhone';
  static const emailOrPhone = 'emailOrPhone';
  static const pass = 'pass';
  static const writePass = 'writePass';
  static const confirmPass = 'confirmPass';
  static const newPassword = 'newPassword';
  static const location = 'location';
  static const acceptPolicy = 'acceptPolicy';
  static const termsConditions = 'termsConditions';
  static const privacyPolicy = 'privacyPolicy';
  static const createTheAccount = 'createTheAccount';
  static const registerSuccess = 'registerSuccess';
  static const editSuccess = 'editSuccess';
  static const matchConfirmPassword = 'matchConfirmPassword';

  /// Contact Us Page ==========================================================
  static const title = 'title';
  static const emptyTitle = 'emptyTitle';
  static const message = 'message';
  static const emptyMessage = 'emptyMessage';
  static const send = 'send';
  static const selectPicture = 'selectPicture';

  /// Edit User Page ===========================================================
  static const dataModification = 'dataModification';

  /// Otp Page =================================================================
  static const verifyYourAccount = 'verifyYourAccount';
  static const verificationCode = 'verificationCode';
  static const enterValidPhone = 'enterValidPhone';
  static const resendCode = 'resendCode';

  /// Reset Password Page ======================================================
  static const resetThePassword = 'resetThePassword';
  static const token = 'token';
  static const hintToken = 'hintToken';

  /// MainLayout Page ==========================================================
  static const doYouWantToExitTheApp = 'doYouWantToExitTheApp';
  static const cancel = 'cancel';
  static const exit = 'exit';
  static const account = 'account';
  static const currentOrder = 'currentOrder';
  static const myOrders = 'myOrders';

  /// Profile Page =============================================================
  static const reviewsOfOrders = 'reviewsOfOrders';
  static const cancelOrders = 'cancelOrders';
  static const acceptOrders = 'acceptOrders';
  static const totalOrders = 'totalOrders';
  static const todaysOrders = 'todaysOrders';
  static const thereAreNoReviewsCurrently = 'thereAreNoReviewsCurrently';

  /// create order Page ========================================================
  static const confirmAddress = 'confirmAddress';
  static const notsToDrive = 'notsToDrive';
  static const continue_ = 'continue_';

  /// current order Page =======================================================
  static const yourWalletBalance = 'yourWalletBalance';
  static const minutesToArrive = 'minutesToArrive';
  static const minuteToArrive = 'minuteToArrive';
  static const arrived = 'arrived';
  static const orderReceived = 'orderReceived';
  static const numberGasCylinder = 'numberGasCylinder';
  static const deliveryCost = 'deliveryCost';
  static const buildingNumber = 'buildingNumber';
  static const floorNumber = 'floorNumber';
  static const notesToDrive = 'notesToDrive';
  static const delivered = 'delivered';
  static const cancelOrder = 'cancelOrder';
  static const connectWithCustomer = 'connectWithCustomer';
  static const connected = 'connected';
  static const notConnected = 'notConnected';
  static const waitingCustomerDeliveryConfirmation =
      'waitingCustomerDeliveryConfirmation';
  static const pleaseConfirmDelivery = 'pleaseConfirmDelivery';
  static const notReceived = 'notReceived';
  static const guest = 'guest';
  static const orderCost = 'orderCost';
  static const acceptOrder = 'acceptOrder';
  static const goToLocationSetting = 'goToLocationSetting';
  static const askGasUnit = 'askGasUnit';
  static const orderDetails = 'orderDetails';
  static const otherData = 'otherData';
  static const payCash = 'payCash';
  static const confirmOrder = 'confirmOrder';
  static const waitingDriverAcceptance = 'waitingDriverAcceptance';
  static const contactMe = 'contactMe';
  static const received = 'received';
  static const driverCancelOrder = 'driverCancelOrder';
  static const noDriverFound = 'noDriverFound';
  static const cancelBecauseOf = 'cancelBecauseOf';
  static const reason = 'reason';
  static const distance = 'distance';
  static const driverName = 'driverName';

  /// Locations Page ===========================================================
  static const noLocations = 'noLocations';
  static const locations = 'locations';
  static const addLocation = 'addLocation';
  static const editLocation = 'editLocation';
  static const hintDash = 'hintDash';
  static const addressTitle = 'addressTitle';
  static const confirmMyLocation = 'confirmMyLocation';
  static const emptyConfirmMyLocation = 'emptyConfirmMyLocation';
  static const deleteLocationAlert = 'deleteLocationAlert';
  static const delete = 'delete';

  /// Home Page ================================================================
  static const askForGas = 'askForGas';
  static const selectYourLocation = 'selectYourLocation';

  /// Orders List Page =========================================================
  static const yourOrdersListIsEmpty = 'yourOrdersListIsEmpty';
  static const numberOfCylinders = 'numberOfCylinders';
  static const yourProfitPercentage = 'yourProfitPercentage';
  static const canceled = 'canceled';
  static const canceledByCustomer = 'canceledByCustomer';

  /// Account Balance Page =====================================================
  static const inTheWallet = 'inTheWallet';
  static const balanceChargeWindow = 'balanceChargeWindow';
  static const rechargeCardNumber = 'rechargeCardNumber';
  static const rechargeTheBalance = 'rechargeTheBalance';

  /// Drawer Page ==============================================================
  static const homePage = 'homePage';
  static const profile = 'profile';
  static const updateAccount = 'updateAccount';
  static const orderList = 'orderList';
  static const wallet = 'wallet';
  static const documents = 'documents';
  static const aboutApp = 'aboutApp';
  static const contactUs = 'contactUs';
  static const logout = 'logout';
  static const removeAccount = 'removeAccount';

  static const yes = 'yes';
  static const no = 'no';

  /// Notifications Page =======================================================
  static const notifications = 'notifications';
  static const doYouWantToDeleteAllNotification =
      'doYouWantToDeleteAllNotification';
  static const todaysAlerts = 'todaysAlerts';
  static const previousAlerts = 'previousAlerts';
  static const emptyNotifications = 'emptyNotifications';

  /// Chats Page ===============================================================
  static const communicationWithTheCustomer = 'communicationWithTheCustomer';
  static const writeAMessage = 'writeAMessage';

  /// Documnets Page ===========================================================
  static const copyOfThePersonalIdentityOnBothSides =
      'copyOfThePersonalIdentityOnBothSides';
  static const getFromCamera = 'getFromCamera';
  static const getFromGallery = 'getFromGallery';
  static const selectAForegroundImage = 'selectAForegroundImage';
  static const selectABackgroundImage = 'selectABackgroundImage';
  static const idExpiryDate = 'idExpiryDate';
  static const doubleSidedCopyOfTheDriversDrivingLicense =
      'doubleSidedCopyOfTheDriversDrivingLicense';
  static const driverLicenseExpiryDate = 'driverLicenseExpiryDate';
  static const doubleSidedVehicleLicense = 'doubleSidedVehicleLicense';
  static const vehicleLicenseExpiryDate = 'vehicleLicenseExpiryDate';
  static const certificateOfNoCriminalRecord = 'certificateOfNoCriminalRecord';
  static const nonGovernedCertificateExpirationDate =
      'nonGovernedCertificateExpirationDate';
  static const diseaseFreeCertificate = 'diseaseFreeCertificate';
  static const diseaseFreeCertificateExpiryDate =
      'diseaseFreeCertificateExpiryDate';
  static const vehicleID = 'vehicleID';
  static const vehicleType = 'vehicleType';
  static const vehicleModel = 'vehicleModel';
  static const save = 'save';
  static const documentUploadedSuccess = 'documentUploadedSuccess';
  static const documentSavedSuccess = 'documentSavedSuccess';

  /// Rating Page ==============================================================
  static const deliveryServiceRating = 'deliveryServiceRating';
  static const yourReviewForEvaluation = 'yourReviewForEvaluation';
  static const confirmRating = 'confirmRating';
  static const rateLater = 'rateLater';
  static const whatIsTheReasonForThePoorServiceRating =
      'whatIsTheReasonForThePoorServiceRating';
  static const pleaseSelectReason = 'pleaseSelectReason';
  static const badCylinder = "badCylinder";
  static const driverCameLate = "driverCameLate";
  static const driverBehavedBadly = "driverBehavedBadly";

  ///===========================================================================
  static const pleaseFillThisField = 'pleaseFillThisField';
  static const enterValidName = 'enterValidName';
  static const enterValidEmail = 'enterValidEmail';
  static const enterPhoneNumber = 'enterPhoneNumber';
  static const validCardNumber = 'validCardNumber';
  static const enterValidPassword = 'enterValidPassword';
  static const enterValidVerificationCode = 'enterValidVerificationCode';
  static const currency = 'currency';
  static const enableLocation = 'enableLocation';
}
